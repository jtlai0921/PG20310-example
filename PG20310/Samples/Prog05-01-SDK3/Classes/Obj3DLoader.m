//
//  Obj3DLoader.m
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Obj3DLoader.h"
#import "MeshLoader.h"


@implementation Obj3DLoader

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
	BOOL res;
	[parser setDelegate:self];
	res = [parser parse];
	[parser release];
	if (res) {
		return rootObj;
	} else {
		return nil;
	}
}

#pragma mark -
#pragma mark XML Parser
- (int)transpose:(int)index
{
	int x, y;
	x = index % 4;
	y = index / 4;
	return (x * 4) + y;
}

- (BOOL)parseMatrix:(Matrix *)pmat withString:(NSString *)val
{
	NSString *edit;
	edit = [val stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	edit = [edit stringByReplacingOccurrencesOfString:@"\t" withString:@""];
	edit = [edit stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSArray *vals;
	vals = [edit componentsSeparatedByString:@","];
	if ([vals count] == 16) {
		for (int i = 0; i < 16; i++) {
			NSString *temp;
			temp = [vals objectAtIndex:i];
			pmat->m[[self transpose:i]] = [temp floatValue];
		}
		return YES;
	}
	return NO;
}

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
	} else if ([elementName isEqualToString:@"objfile"]) {
		currOET = OET_OBJFILE_END;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
#ifdef DEBUG_LOG
	NSLog(@"foundCharacters \"%@\"", string);
#endif
	switch (currOET) {
		case OET_MATRIX:
		{
			[self parseMatrix:[currObj getMatrixPtr] withString:string];
		}
			break;
		default:
			break;
	}
}

@end
