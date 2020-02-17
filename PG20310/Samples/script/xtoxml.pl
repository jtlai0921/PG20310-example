#!/usr/local/bin/perl -w
print "Hello! $ARGV[0]\n";

$mesh_count = 0;
$status = 0;
$nest_level = 0;
$line_count = 0;
$numOfVertices = -1;
$numOfFaces = -1;
$indicesString = "";
$shininess = 0.0;

# ARGV
$xfile = $ARGV[0]; # input X-file
$scaleX = 1.0;
$scaleY = 1.0;
$scaleZ = 1.0;
if (defined($ARGV[1])) {
    $scaleX = $ARGV[1];
}
if (defined($ARGV[2])) {
    $scaleY = $ARGV[2];
}
if (defined($ARGV[3])) {
    $scaleZ = $ARGV[3];
}

open(XSRC, $xfile) || die "Can't open $xfile.";
$ln = <XSRC>;
chomp($ln);
if ($ln !~ /^xof/) {
    die "This file is NOT X-file.";
}
$status = 1; # xof
print $ln;
while ($ln = <XSRC>) {
    chomp($ln);
    if ($ln =~ /^Mesh\s+\{/) {
	print "Mesh start\n";
	$mesh_count++;
	$xmlfile = $xfile . $mesh_count . ".xml";
	open(XML, ">$xmlfile") || die "Can't open $xmlfile.";
	printXmlHeader();
	printXmlMeshOpen($xmlfile);
	$status = 2; # Mesh start
	$nest_level = 1;
	$line_count = 0;
    } elsif ($ln =~ /\}/) {
	$nest_level--;
	if ($nest_level == 0) {
	    printXmlMeshClose();
	    close(XML);
	    $status = 1; # Mesh end
	} elsif ($nest_level < 0) {
	    die "Bad nest level.";
	}
    } elsif ($ln =~ /\{/) {
	$nest_level++;
	if ($ln =~ /MeshNormals\s+\{/) {
	    $status = 5; # MeshNormals start
	    print XML "\t<normals>\r\n";
	} elsif ($ln =~ /MeshTextureCoords\s+\{/) {
	    $status = 6; # MeshTextureCoords start
	    print XML "\t<texCoords>\r\n";
	} elsif ($ln =~ /MeshMaterialList\s+\{/) {
	    $status = 7; # MeshMaterialList start
	} elsif ($ln =~ /Material\s+\{/) {
	    $status = 8; # Material start
	    print XML "\t<material>\r\n";
	} elsif ($ln =~ /TextureFilename\s+\{/) {
	    $status = 12; # TextureFilename
	}
    } elsif ($ln =~ /^\s+([0-9]+),$/) {
	# MeshMaterialList
    } elsif ($ln =~ /^\s+([0-9]+);$/) {
	# int 1 times
	if ($status == 2) { # Mesh
	    $numOfVertices = $1;
	    print XML "\t<numOfVertices>$numOfVertices</numOfVertices>\r\n";
	    $status = 3; # Mesh vertices start
	    print XML "\t<vertices>\r\n";
	} elsif ($status == 3) { # Mesh vertices
	    $numOfFaces = $1;
	    $status = 4; # vertices Face
	    $indicesString = "\t<indices num=\"".($numOfFaces * 3)."\">\r\n";
	} elsif ($status == 5) { # Mesh normals
	    # 読み飛ばし
	    if (($numOfVertices != $1) && ($numOfFaces != $1)) {
		die "Invalid value at MeshNormals. $numOfVertices != $1 && $numOfFaces != $1";
	    }
	} elsif ($status == 6) { # MeshTextureCoords
	    # 読み飛ばし
	    if (($numOfVertices != $1) && ($numOfFaces != $1)) {
		die "Invalid value at MeshTextureCoords. $numOfVertices != $1 && $numOfFaces != $1";
	    }
	} elsif ($status == 7) { # MeshMaterialList
	    # 読み飛ばし
	} else {
	    print "$1\n";
	}
    } elsif ($ln =~ /^\s+(\-*[0-9\.]+);(\-*[0-9\.]+);(\-*[0-9\.]+);,/) {
	# float 3 times
	if ($status == 3) { # Mesh vertices
	    print XML sprintf("\t\t<vector3>%f, %f, %f</vector3>\r\n",
			      $1*$scaleX, $2*$scaleY, $3*$scaleZ);
	} else {
	    print "[float 3 times]$1, $2, $3\n";
	}
    } elsif ($ln =~ /^\s+(\-*[0-9\.]+);(\-*[0-9\.]+);(\-*[0-9\.]+);;/) {
	# float 3 times last line
	if ($status == 3) { # Mesh vertices
	    print XML "\t\t<vector3>$1, $2, $3</vector3>\r\n";
	    print XML "\t</vertices>\r\n";
	} elsif ($status == 9) { # Material power
	    # Material next field of 'power'
	    # specularColor
	    print XML "\t\t<specular>$1, $2, $3, 1.0</specular>\r\n";
	    $status = 10; # Material specularColor
	} elsif ($status == 10) { # Material specularColor
	    # Material next field of 'specularColor'
	    # emissiveColor
	    print XML "\t\t<emission>$1, $2, $3, 1.0</emission>\r\n";
	    print XML "\t\t<shininess>$shininess</shininess>\r\n";
	    print XML "\t</material>\r\n";
	    $status = 11; # end of Material
	} else {
	    print "[float 3 times last line $status]$1, $2, $3\n";
	}
    } elsif ($ln =~ /^\s+(\-*[0-9\.]+),(\-*[0-9\.]+),(\-*[0-9\.]+);,/) {
	# Mesh normals
	if ($status == 5) {
	    print XML "\t\t<vector3>$1, $2, $3</vector3>\r\n";
	} else {
	    print "$1, $2, $3\n";
	}
    } elsif ($ln =~ /^\s+(\-*[0-9\.]+),(\-*[0-9\.]+),(\-*[0-9\.]+);;/) {
	# Mesh normals last line
	if ($status == 5) {
	    print XML "\t\t<vector3>$1, $2, $3</vector3>\r\n";
	    print XML "\t</normals>\r\n";
	} else {
	    print "$1, $2, $3\n";
	}
    } elsif ($ln =~/^\s+3;([0-9]+),([0-9]+),([0-9]+);,/) {
	# face index
	if ($status == 4) { # Mesh Face
	    $indicesString .= "\t\t$1, $2, $3,\r\n";
	} elsif ($status == 5) { # Mesh Normals Face
	    # 読み飛ばし
	} else {
	    print $ln;
	}
    } elsif ($ln =~/^\s+3;([0-9]+),([0-9]+),([0-9]+);;/) {
	# face index last line
	if ($status == 4) { # Mesh Face
	    $indicesString .= "\t\t$1, $2, $3,\r\n";
	    $indicesString .= "\t</indices>\r\n";
	} elsif ($status == 5) { # Mesh Normals Face
	    # 読み飛ばし
	} else {
	    print $ln;
	}
    } elsif ($ln =~ /^\s+(\-*[0-9\.]+);(\-*[0-9\.]+);,/) {
	# float 2 times
	if ($status == 6) { # MeshTextureCoords
	    print XML "\t\t<vector2>$1, $2</vector2>\r\n";
	} else {
	    print $ln;
	}
    } elsif ($ln =~ /^\s+(\-*[0-9\.]+);(\-*[0-9\.]+);;/) {
	# float 2 times last line
	if ($status == 6) { # MeshTextureCoords
	    print XML "\t\t<vector2>$1, $2</vector2>\r\n";
	    print XML "\t</texCoords>\r\n";
	    print XML $indicesString;
	    $indicesString = "";
	} else {
	    print $ln;
	}
    } elsif ($ln =~ /^\s+(\-*[0-9\.]+);(\-*[0-9\.]+);(\-*[0-9\.]+);(\-*[0-9\.]+);;/) {
	# float 4 times (Material faceColor)
	if ($status == 8) { # Material
	    print XML "\t\t<ambient>".($1*0.2).", ".($2*0.2).", ".($3*0.2).", ".($4*0.2)."</ambient>\r\n";
	    print XML "\t\t<diffuse>$1, $2, $3, $4</diffuse>\r\n";
	}
    } elsif ($ln =~ /^\s+(\-*[0-9\.]+);/) {
	# float 1 times (Material power)
	if ($status == 8) { # Material
	    $shininess = $1;
	    $status = 9; # Material power
	}
    } elsif ($ln =~ /^\s+\"([a-zA-Z0-9\-_\.]+)\";/) {
	print XML "\t<texture>$1</texture>\r\n";
    } elsif ($ln =~ /^\s+(\-*[0-9\.]+;)+;/) {
	print "$1, $2, $3, $4, $5\n";
    } else {
	print "???".$ln."???\n";
    }
}
close(XSRC);


sub printXmlHeader
{
    print XML "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n";
}

sub printXmlMeshOpen
{
    print XML "<mesh name=\"$_[0]\">\r\n";
}

sub printXmlMeshClose
{
    print XML "</mesh>\r\n";
}
