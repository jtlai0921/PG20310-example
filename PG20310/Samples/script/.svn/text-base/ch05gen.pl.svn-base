#!/usr/bin/perl -w

#$func = '$x * $x + $y * $y';
$func = $ARGV[0];
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

open(OUT, ">ch05gen.xml");
print OUT "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n";
print OUT "<mesh name=\"generated mesh\">\r\n";
print OUT "\t<numOfVertices>".(11 * 11)."</numOfVertices>\r\n";
print OUT "\t<vertices>\r\n";
$i = 0;
for ($y = 1.0*10; $y >= -1.0*10; $y-=(0.2*10)) {
    for ($x = 1.0*10; $x >= -1.0*10; $x-=(0.2*10)) {
        print OUT "\t\t<vector3>";
        print OUT sprintf("%f, %f, %f", $x*$scaleX, $y*$scaleY, eval($func)*$scaleZ);
        print OUT "</vector3>";
        print OUT sprintf("<!-- %d -->", $i++);
        print OUT "\r\n";
    }
}
print OUT "\t</vertices>\r\n";
print OUT "\t<normals>\r\n";
$i = 0;
for ($y = 1.0; $y >= -1.0; $y-=0.2) {
    for ($x = 1.0; $x >= -1.0; $x-=0.2) {
        print OUT "\t\t<vector3>";
        print OUT sprintf("%f, %f, %f", 0, 0, -1);
        print OUT "</vector3>";
        print OUT sprintf("<!-- %d -->", $i++);
        print OUT "\r\n";
    }
}
print OUT "\t</normals>\r\n";
print OUT "\t<texCoords>\r\n";
$i = 0;
for ($y = 1.0; $y >= -1.0; $y-=0.2) {
    for ($x = 1.0; $x >= -1.0; $x-=0.2) {
        print OUT "\t\t<vector2>";
        print OUT sprintf("%f, %f", 1.0 - ($x * 0.5 + 0.5), 1.0 - ($y * 0.5 + 0.5));
        print OUT "</vector2>";
        print OUT sprintf("<!-- %d -->", $i++);
        print OUT "\r\n";
    }
}
print OUT "\t</texCoords>\r\n";
print OUT "\t<indices num=\"610\">\r\n";
for ($y = 0; $y < 10; $y++) {
    print OUT "\t\t";
    for ($x = 0; $x < 10; $x++) {
        print OUT sprintf(" %d, %d, %d,", $y * 11 + $x, ($y + 1) * 11 + $x, $y * 11 + $x + 1);
        print OUT sprintf(" %d, %d, %d,", $y * 11 + $x + 1, ($y + 1) * 11 + $x, ($y + 1) * 11 + $x + 1);
    }
    print OUT "\r\n";
}
print OUT "\t</indices>\r\n";
print OUT "\t<material>\r\n";
print OUT "\t\t<ambient>0.2, 0.2, 0.2, 1.0</ambient>\r\n";
print OUT "\t\t<diffuse>0.8, 0.8, 0.8, 1.0</diffuse>\r\n";
print OUT "\t\t<specular>1.0, 1.0, 1.0, 1.0</specular>\r\n";
print OUT "\t\t<emission>0.0, 0.0, 0.0, 0.0</emission>\r\n";
print OUT "\t\t<shininess>1.0</shininess>\r\n";
print OUT "\t</material>\r\n";
print OUT "\t<texture>mark.png</texture>\r\n";
print OUT "</mesh>\r\n";
close(OUT);
