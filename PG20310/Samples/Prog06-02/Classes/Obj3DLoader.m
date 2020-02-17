//
//  Obj3DLoader.m
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Obj3DLoader.h"
#import "MeshLoader.h"

//#define DEBUG_LOG

@implementation Obj3DLoader

@synthesize activeCam;

- (Obj3D *)load:(NSString *)filename
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
	currOET = OET_NONE;
	activeCam = nil;
	BOOL res;
	[parser setDelegate:self];
	res = [parser parse];
	[parser release];
	if (res) {
		activeCam.active = YES;
		return rootObj;
	} else {
		return nil;
	}
}

#pragma mark -
#pragma mark XML Parser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
#ifdef DEBUG_LOG
	NSLog(@"didStartElement \"%@\"", elementName);
#endif
	if ([elementName isEqualToString:@"object"]) {
		currOET = OET_OBJECT;
		Obj3D *obj;
		obj = [[Obj3D alloc] initWithParent:currObj];
		NSString *name;
		name = [attributeDict valueForKey:@"name"];
		if (name) {
			obj.name = name;
		}
		if (rootObj == nil) {
			rootObj = obj;
		}
		if (currObj) {
			[currObj addChild:obj];
		}
		currObj = obj;
	} else if ([elementName isEqualToString:@"matrix"]) {
		currOET = OET_MATRIX;
	} else if ([elementName isEqualToString:@"meshfile"]) {
		NSString *src;
		src = [attributeDict valueForKey:@"src"];
		if (src) {
#ifdef DEBUG_LOG
			NSLog(@"src=\"%@\"", src);
#endif
			MeshLoader *meshLoader;
			Mesh *mesh;
			meshLoader = [[MeshLoader alloc] init];
			mesh = [meshLoader load:src];
			if (mesh) {
				[currObj addMesh:mesh];
			}
			currOET = OET_MESHFILE;
			[meshLoader release];
		} else {
			currOET = OET_ERROR;
		}
	} else if ([elementName isEqualToString:@"light"]) {
		currOET = OET_LIGHT;
		currLight = [[Light alloc] initWithParent:currObj];
		NSString *name;
		name = [attributeDict valueForKey:@"name"];
		if (name) {
			currLight.name = name;
		}
		NSString *type;
		type = [attributeDict valueForKey:@"type"];
		if (type) {
			LIGHT_TYPE lt = LT_NONE;
			if ([type isEqualToString:@"DIRECTIONAL"]) {
				lt = LT_DIRECTIONAL;
			} else if ([type isEqualToString:@"POINT"]) {
				lt = LT_POINT;
			} else if ([type isEqualToString:@"SPOT"]) {
				lt = LT_SPOT;
			}
			currLight.ltype = lt;
		}
	} else if ([elementName isEqualToString:@"color"]) {
		currOET = OET_LIGHT_COLOR;
	} else if ([elementName isEqualToString:@"ambient"]) {
		currOET = OET_LIGHT_COLOR_AMBIENT;
	} else if ([elementName isEqualToString:@"diffuse"]) {
		currOET = OET_LIGHT_COLOR_DIFFUSE;
	} else if ([elementName isEqualToString:@"specular"]) {
		currOET = OET_LIGHT_COLOR_SPECULAR;
	} else if ([elementName isEqualToString:@"position"]) {
		currOET = OET_LIGHT_POSITION;
	} else if ([elementName isEqualToString:@"spot"]) {
		currOET = OET_LIGHT_SPOT;
	} else if ([elementName isEqualToString:@"direction"]) {
		currOET = OET_LIGHT_SPOT_DIRECTION;
	} else if ([elementName isEqualToString:@"exponent"]) {
		currOET = OET_LIGHT_SPOT_EXPONENT;
	} else if ([elementName isEqualToString:@"cutoff"]) {
		currOET = OET_LIGHT_SPOT_CUTOFF;
	} else if ([elementName isEqualToString:@"camera"]) {
		currOET = OET_CAMERA;
		currCam = [[Camera alloc] initWithParent:currObj];
		NSString *name;
		name = [attributeDict valueForKey:@"name"];
		if (name) {
			currCam.name = name;
		}
		NSString *current;
		current = [attributeDict valueForKey:@"active"];
		if (current) {
			if ([current isEqualToString:@"yes"]) {
				activeCam = currCam;
			}
		}
		if (activeCam == nil) {
			activeCam = currCam;
		}
	} else if ([elementName isEqualToString:@"angle"]) {
		currOET = OET_CAMERA_ANGLE;
	} else if ([elementName isEqualToString:@"aspect"]) {
		currOET = OET_CAMERA_ASPECT;
	} else if ([elementName isEqualToString:@"near"]) {
		currOET = OET_CAMERA_NEAR;
	} else if ([elementName isEqualToString:@"far"]) {
		currOET = OET_CAMERA_FAR;
	} else if ([elementName isEqualToString:@"eye"]) {
		currOET = OET_CAMERA_EYE;
	} else if ([elementName isEqualToString:@"lookat"]) {
		currOET = OET_CAMERA_LOOKAT;
	} else if ([elementName isEqualToString:@"up"]) {
		currOET = OET_CAMERA_UP;
	} else if ([elementName isEqualToString:@"objfile"]) {
		NSString *src;
		src = [attributeDict valueForKey:@"src"];
		if (src) {
#ifdef DEBUG_LOG
			NSLog(@"src=\"%@\"", src);
#endif
			Obj3DLoader *obj3dLoader;
			Obj3D *obj;
			obj3dLoader = [[Obj3DLoader alloc] init];
			obj = [obj3dLoader load:src];
			if (obj) {
				[currObj addChild:obj];
			}
			currOET = OET_OBJFILE;
			[obj3dLoader release];
		} else {
			currOET = OET_ERROR;
		}
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
#ifdef DEBUG_LOG
	NSLog(@"didEndElement \"%@\"", elementName);
#endif
	if ([elementName isEqualToString:@"object"]) {
		currOET = OET_OBJECT_END;
		currObj = (Obj3D *)currObj.parent;
	} else if ([elementName isEqualToString:@"matrix"]) {
		currOET = OET_MATRIX_END;
	} else if ([elementName isEqualToString:@"meshfile"]) {
		currOET = OET_MESHFILE_END;
	} else if ([elementName isEqualToString:@"light"]) {
		currOET = OET_LIGHT_END;
		[currObj addLight:currLight];
		currLight = nil;
	} else if ([elementName isEqualToString:@"color"]) {
		currOET = OET_LIGHT_COLOR_END;
	} else if ([elementName isEqualToString:@"ambient"]) {
		currOET = OET_LIGHT_COLOR_AMBIENT_END;
	} else if ([elementName isEqualToString:@"diffuse"]) {
		currOET = OET_LIGHT_COLOR_DIFFUSE_END;
	} else if ([elementName isEqualToString:@"specular"]) {
		currOET = OET_LIGHT_COLOR_SPECULAR_END;
	} else if ([elementName isEqualToString:@"position"]) {
		currOET = OET_LIGHT_POSITION_END;
	} else if ([elementName isEqualToString:@"spot"]) {
		currOET = OET_LIGHT_SPOT_END;
	} else if ([elementName isEqualToString:@"direction"]) {
		currOET = OET_LIGHT_SPOT_DIRECTION_END;
	} else if ([elementName isEqualToString:@"exponent"]) {
		currOET = OET_LIGHT_SPOT_EXPONENT_END;
	} else if ([elementName isEqualToString:@"cutoff"]) {
		currOET = OET_LIGHT_SPOT_CUTOFF_END;
	} else if ([elementName isEqualToString:@"camera"]) {
		currOET = OET_CAMERA_END;
		[currObj addCamera:currCam];
		currCam = nil;
	} else if ([elementName isEqualToString:@"angle"]) {
		currOET = OET_CAMERA_ANGLE_END;
	} else if ([elementName isEqualToString:@"aspect"]) {
		currOET = OET_CAMERA_ASPECT_END;
	} else if ([elementName isEqualToString:@"near"]) {
		currOET = OET_CAMERA_NEAR_END;
	} else if ([elementName isEqualToString:@"far"]) {
		currOET = OET_CAMERA_FAR_END;
	} else if ([elementName isEqualToString:@"eye"]) {
		currOET = OET_CAMERA_EYE_END;
	} else if ([elementName isEqualToString:@"lookat"]) {
		currOET = OET_CAMERA_LOOKAT_END;
	} else if ([elementName isEqualToString:@"up"]) {
		currOET = OET_CAMERA_UP_END;
	} else if ([elementName isEqualToString:@"objfile"]) {
		currOET = OET_OBJFILE_END;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
#ifdef DEBUG_LOG
	NSLog(@"foundCharacters \"%@\"", string);
#endif
	RGBA color;
	Vector4 v4;
	Vector3 v3;
	switch (currOET) {
		case OET_MATRIX:
		{
			[Loader parseMatrix:[currObj getMatrixPtr] withString:string];
		}
			break;
		case OET_LIGHT_COLOR_AMBIENT:
			if ([Loader parseRGBA:&color from:string]) {
				currLight.ambient = color;
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
			break;
		case OET_LIGHT_COLOR_DIFFUSE:
			if ([Loader parseRGBA:&color from:string]) {
				currLight.diffuse = color;
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
			break;
		case OET_LIGHT_COLOR_SPECULAR:
			if ([Loader parseRGBA:&color from:string]) {
				currLight.specular = color;
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
			break;
		case OET_LIGHT_POSITION:
			if ([Loader parseVector4:&v4 from:string]) {
				currLight.position = v4;
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
			break;
		case OET_LIGHT_SPOT_DIRECTION:
			if ([Loader parseVector3:&v3 from:string]) {
				currLight.direction = v3;
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
			break;
		case OET_LIGHT_SPOT_EXPONENT:
			currLight.exponent = [string floatValue];
			break;
		case OET_LIGHT_SPOT_CUTOFF:
			currLight.cutoff = [string floatValue];
			break;
		case OET_CAMERA_ANGLE:
			currCam.angle = [string floatValue];
			break;
		case OET_CAMERA_ASPECT:
			currCam.aspect = [string floatValue];
			break;
		case OET_CAMERA_NEAR:
			currCam.near = [string floatValue];
			break;
		case OET_CAMERA_FAR:
			currCam.far = [string floatValue];
			break;
		case OET_CAMERA_EYE:
			if ([Loader parseVector3:&v3 from:string]) {
				currCam.eye = v3;
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
			break;
		case OET_CAMERA_LOOKAT:
			if ([Loader parseVector3:&v3 from:string]) {
				currCam.lookAt = v3;
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
			break;
		case OET_CAMERA_UP:
			if ([Loader parseVector3:&v3 from:string]) {
				currCam.up = v3;
			} else {
				NSLog(@"ERROR!!! string=\"%@\"", string);
			}
			break;
		default:
			break;
	}
}

@end
