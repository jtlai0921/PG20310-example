//
//  AnimLoader.m
//  Prog07-01
//
//  Created by SAKAI Yuji on 10/01/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimLoader.h"
#import "AnimPosition3Key.h"

#define DEBUG_LOG

@implementation AnimLoader

- (Animation *)load:(NSString *)filename
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
	anim = nil;
	currAnimKeyType = AKT_NONE;
	currAnimKey = nil;
	BOOL res;
	[parser setDelegate:self];
	res = [parser parse];
	[parser release];
	if (res) {
		return anim;
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
	if ([elementName isEqualToString:@"animation"]) {
		currAET = AET_ANIMATION;
		anim = [[Animation alloc] init];
		NSString *name;
		name = [attributeDict valueForKey:@"name"];
		if (name) {
			anim.name = name;
		}
		NSString *loop;
		loop = [attributeDict valueForKey:@"loop"];
		if ([loop isEqualToString:@"yes"]) {
			anim.loop = YES;
		} else {
			anim.loop = NO;
		}
	} else if ([elementName isEqualToString:@"animkey"]) {
		currAET = AET_ANIMKEY;
		currAnimKeyType = AKT_NONE;
		NSString *tk;
		NSString *type = nil;
		tk = [attributeDict valueForKey:@"time"];
		if (tk) {
			type = [attributeDict valueForKey:@"type"];
			if ([type isEqualToString:@"position3"]) {
				currAnimKeyType = AKT_POSITION3;
			} else {
				currAET = AET_ERROR;
			}
		} else {
			currAET = AET_ERROR;
		}
		if (currAET == AET_ANIMKEY) {
			float tm = [tk floatValue];
			if (currAnimKeyType == AKT_POSITION3) {
				currAnimKey = [[AnimPosition3Key alloc] initWithTime:tm];
			}
		}
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
#ifdef DEBUG_LOG
	NSLog(@"didEndElement \"%@\"", elementName);
#endif
	if ([elementName isEqualToString:@"animation"]) {
		currAET = AET_ANIMATION_END;
	} else if ([elementName isEqualToString:@"animkey"]) {
		if (currAnimKey) {
			[anim addKey:currAnimKey];
			currAnimKey = nil;
		}
		currAET = AET_ANIMKEY_END;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
#ifdef DEBUG_LOG
	NSLog(@"foundCharacters \"%@\"", string);
#endif
	Vector3 v3;
	switch (currAET) {
		case AET_ANIMKEY:
			if (currAnimKeyType == AKT_POSITION3) {
				if ([Loader parseVector3:&v3 from:string]) {
					((AnimPosition3Key *)currAnimKey).pos = v3;
				} else {
					NSLog(@"ERROR!!! string=\"%@\"", string);
				}
			}
			break;
		default:
			break;
	}
}

@end
