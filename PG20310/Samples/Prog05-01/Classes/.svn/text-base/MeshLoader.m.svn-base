//
//  MeshLoader.m
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MeshLoader.h"


@implementation MeshLoader

- (Mesh *)load:(NSString *)filename
{
	NSString *path;
	path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], filename];
	NSURL *url;
	url = [NSURL fileURLWithPath:path];
	if (url == nil) {
		return NO;
	}
	NSXMLParser *parser;
	parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	if (parser == nil) {
		return NO;
	}
	currMet = MET_NONE;
	counter = 0;
	BOOL res;
	[parser setDelegate:self];
	res = [parser parse];
	[parser release];
	if (res) {
		return currMesh;
	} else {
		return nil;
	}
}

#pragma mark -
#pragma mark XML Parser
- (BOOL)parseVector3:(Vector3 *)pv from:(NSString *)val
{
	Vector3 vec;
	NSArray *vals;
	vals = [val componentsSeparatedByString:@","];
	if ([vals count] == 3) {
		NSString *temp;
		temp = [vals objectAtIndex:0];
		vec.x = [temp floatValue];
		temp = [vals objectAtIndex:1];
		vec.y = [temp floatValue];
		temp = [vals objectAtIndex:2];
		vec.z = [temp floatValue];
		*pv = vec;
		return YES;
	}
	return NO;
}

- (BOOL)parseVector2:(Vector2 *)pv from:(NSString *)val
{
	Vector2 vec;
	NSArray *vals;
	vals = [val componentsSeparatedByString:@","];
	if ([vals count] == 2) {
		NSString *temp;
		temp = [vals objectAtIndex:0];
		vec.u = [temp floatValue];
		temp = [vals objectAtIndex:1];
		vec.v = [temp floatValue];
		*pv = vec;
		return YES;
	}
	return NO;
}

- (BOOL)parseRGBA:(RGBA *)pcolor from:(NSString *)val
{
	RGBA color;
	NSArray *vals;
	vals = [val componentsSeparatedByString:@","];
	if ([vals count] == 4) {
		NSString *temp;
		temp = [vals objectAtIndex:0];
		color.r = [temp floatValue];
		temp = [vals objectAtIndex:1];
		color.g = [temp floatValue];
		temp = [vals objectAtIndex:2];
		color.b = [temp floatValue];
		temp = [vals objectAtIndex:3];
		color.a = [temp floatValue];
		*pcolor = color;
		return YES;
	}
	return NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
#ifdef DEBUG_LOG
	NSLog(@"didStartElement=\"%@\"", elementName);
#endif
	if ([elementName isEqualToString:@"mesh"]) {
		currMet = MET_MESH;
		currMesh = [[Mesh alloc] initWithParent:nil];
		currMesh.flagMaterial = 0;
	} else if ([elementName isEqualToString:@"numOfVertices"]) {
		currMet = MET_NUMVERTICES;
	} else if ([elementName isEqualToString:@"vertices"]) {
		if (currMesh.numVertices > 0) {
			currMet = MET_VERTICES;
			counter = 0;
			currMesh.vertices = (Vector3 *)malloc(sizeof(Vector3) * currMesh.numVertices);
		} else {
			currMet = MET_ERROR;
		}
	} else if ([elementName isEqualToString:@"normals"]) {
		if (currMesh.numVertices > 0) {
			currMet = MET_NORMALS;
			counter = 0;
			currMesh.normals = (Vector3 *)malloc(sizeof(Vector3) * currMesh.numVertices);
		} else {
			currMet = MET_ERROR;
		}
	} else if ([elementName isEqualToString:@"vector3"]) {
		if (currMet == MET_VERTICES) {
			currMet = MET_VERTICES_VECTOR3;
		} else if (currMet == MET_VERTICES_VECTOR3_END) {
			currMet = MET_VERTICES_VECTOR3;
		} else if (currMet == MET_NORMALS) {
			currMet = MET_NORMALS_VECTOR3;
		} else if (currMet == MET_NORMALS_VECTOR3_END) {
			currMet = MET_NORMALS_VECTOR3;
		} else {
			currMet = MET_ERROR;
		}
	} else if ([elementName isEqualToString:@"texCoords"]) {
		if (currMesh.numVertices > 0) {
			currMet = MET_TEXCOORDS;
			counter = 0;
			currMesh.texCoords = (Vector2 *)malloc(sizeof(Vector2) * currMesh.numVertices);
		} else {
			currMet = MET_ERROR;
		}
	} else if ([elementName isEqualToString:@"vector2"]) {
		if (currMet == MET_TEXCOORDS) {
			currMet = MET_TEXCOORDS_VECTOR2;
		} else if (currMet == MET_TEXCOORDS_VECTOR2_END) {
			currMet = MET_TEXCOORDS_VECTOR2;
		} else {
			currMet = MET_ERROR;
		}
	} else if ([elementName isEqualToString:@"indices"]) {
		currMet = MET_INDICES;
		NSString *val = [attributeDict valueForKey:@"num"];
		if (val) {
			currMesh.numIndices = [val intValue];
			currMesh.indices = (GLushort *)malloc(sizeof(GLushort) * currMesh.numIndices);
			counter = 0;
		} else {
			currMet = MET_ERROR;
		}
	} else if ([elementName isEqualToString:@"material"]) {
		currMet = MET_MATERIAL;
	} else if ([elementName isEqualToString:@"ambient"]) {
		currMet = MET_MATERIAL_AMBIENT;
	} else if ([elementName isEqualToString:@"diffuse"]) {
		currMet = MET_MATERIAL_DIFFUSE;
	} else if ([elementName isEqualToString:@"specular"]) {
		currMet = MET_MATERIAL_SPECULAR;
	} else if ([elementName isEqualToString:@"emission"]) {
		currMet = MET_MATERIAL_EMISSION;
	} else if ([elementName isEqualToString:@"shininess"]) {
		currMet = MET_MATERIAL_SHININESS;
	} else if ([elementName isEqualToString:@"texture"]) {
		currMet = MET_TEXTURE;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
#ifdef DEBUG_LOG
	NSLog(@"didEndElement=\"%@\"", elementName);
#endif
	if ([elementName isEqualToString:@"mesh"]) {
		currMet = MET_MESH_END;
	} else if ([elementName isEqualToString:@"numOfVertices"]) {
		currMet = MET_NUMVERTICES_END;
	} else if ([elementName isEqualToString:@"vertices"]) {
		currMet = MET_VERTICES_END;
	} else if ([elementName isEqualToString:@"normals"]) {
		currMet = MET_NORMALS_END;
	} else if ([elementName isEqualToString:@"vector3"]) {
		if (currMet == MET_VERTICES_VECTOR3) {
			currMet = MET_VERTICES_VECTOR3_END;
		} else if (currMet == MET_NORMALS_VECTOR3) {
			currMet = MET_NORMALS_VECTOR3_END;
		} else {
			currMet = MET_ERROR;
		}
	} else if ([elementName isEqualToString:@"texCoords"]) {
		currMet = MET_TEXCOORDS_END;
	} else if ([elementName isEqualToString:@"vector2"]) {
		if (currMet == MET_TEXCOORDS_VECTOR2) {
			currMet = MET_TEXCOORDS_VECTOR2_END;
		} else {
			currMet = MET_ERROR;
		}
	} else if ([elementName isEqualToString:@"indices"]) {
		currMet = MET_INDICES_END;
	} else if ([elementName isEqualToString:@"material"]) {
		currMet = MET_MATERIAL_END;
	} else if ([elementName isEqualToString:@"ambient"]) {
		currMet = MET_MATERIAL_AMBIENT_END;
	} else if ([elementName isEqualToString:@"diffuse"]) {
		currMet = MET_MATERIAL_DIFFUSE_END;
	} else if ([elementName isEqualToString:@"specular"]) {
		currMet = MET_MATERIAL_SPECULAR_END;
	} else if ([elementName isEqualToString:@"emission"]) {
		currMet = MET_MATERIAL_EMISSION_END;
	} else if ([elementName isEqualToString:@"shininess"]) {
		currMet = MET_MATERIAL_SHININESS_END;
	} else if ([elementName isEqualToString:@"texture"]) {
		currMet = MET_TEXTURE_END;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
#ifdef DEBUG_LOG
	NSLog(@"foundCharacters=\"%@\", currMet=%d", string, currMet);
#endif
	Vector3 vec3;
	Vector2 vec2;
	RGBA color;
	switch (currMet) {
		case MET_NUMVERTICES:
			currMesh.numVertices = [string intValue];
			break;
		case MET_VERTICES_VECTOR3:
			if ([self parseVector3:&vec3 from:string]) {
				currMesh.vertices[counter] = vec3;
				counter++;
			} else {
				NSLog(@"ERROR!!! counter=%d, string=\"%@\"", counter, string);
			}
			break;
		case MET_NORMALS_VECTOR3:
			if ([self parseVector3:&vec3 from:string]) {
				currMesh.normals[counter] = vec3;
				counter++;
			} else {
				NSLog(@"ERROR!!! counter=%d, string=\"%@\"", counter, string);
			}
			break;
		case MET_TEXCOORDS_VECTOR2:
			if ([self parseVector2:&vec2 from:string]) {
				currMesh.texCoords[counter] = vec2;
				counter++;
			} else {
				NSLog(@"ERROR!!! counter=%d, string=\"%@\"", counter, string);
			}
			break;
		case MET_INDICES:
		{
			NSString *temp;
			temp = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
			temp = [temp stringByReplacingOccurrencesOfString:@"\t" withString:@""];
			temp = [temp stringByReplacingOccurrencesOfString:@" " withString:@""];
			NSArray *vals = [temp componentsSeparatedByString:@","];
			int numVals = [vals count];
			if (numVals > 0) {
				for (int i = 0; i < numVals; i++) {
					NSString *temp;
					temp = [vals objectAtIndex:i];
					if ([temp length]) {
						if (counter >= currMesh.numIndices) {
							for (int n = 0; n < 10; n++) {
								NSLog(@"ERROR!!! counter(%d) is over currMesh.numIndices(%d) string=\"%@\"", counter, currMesh.numIndices, string);
								//currMet = MET_ERROR;
							}
						} else {
							currMesh.indices[counter] = (GLushort)[temp intValue];
						}
						counter++;
					}
				}
			}
		}
			break;
		case MET_MATERIAL_AMBIENT:
			if ([self parseRGBA:&color from:string]) {
				currMesh.flagMaterial |= MATERIAL_AMBIENT_FLAG;
				Material *tempMatPtr;
				tempMatPtr = [currMesh getMaterialPtr];
				tempMatPtr->ambient = color;
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
			break;
		case MET_MATERIAL_DIFFUSE:
			if ([self parseRGBA:&color from:string]) {
				currMesh.flagMaterial |= MATERIAL_DIFFUSE_FLAG;
				Material *tempMatPtr;
				tempMatPtr = [currMesh getMaterialPtr];
				tempMatPtr->diffuse = color;
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
			break;
		case MET_MATERIAL_SPECULAR:
			if ([self parseRGBA:&color from:string]) {
				currMesh.flagMaterial |= MATERIAL_SPECULAR_FLAG;
				Material *tempMatPtr;
				tempMatPtr = [currMesh getMaterialPtr];
				tempMatPtr->specular = color;
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
			break;
		case MET_MATERIAL_EMISSION:
			if ([self parseRGBA:&color from:string]) {
				currMesh.flagMaterial |= MATERIAL_EMISSION_FLAG;
				Material *tempMatPtr;
				tempMatPtr = [currMesh getMaterialPtr];
				tempMatPtr->emission = color;
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
			break;
		case MET_MATERIAL_SHININESS:
			currMesh.flagMaterial |= MATERIAL_SHININESS_FLAG;
			Material *tempMatPtr;
			tempMatPtr = [currMesh getMaterialPtr];
			tempMatPtr->shininess = [string floatValue];
			break;
		case MET_TEXTURE:
		{
			UIImage *img;
			img = [UIImage imageNamed:string];
			if (img) {
				currMesh.tex = [[Texture2D alloc] initWithImage:img];
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
		}
			break;
		case MET_ERROR:
			NSLog(@"**** MET_ERROR!!!!");
			break;
		default:
			break;
	}
}

@end
