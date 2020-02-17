//
//  Animation.m
//  Prog07-01
//
//  Created by SAKAI Yuji on 10/01/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Animation.h"
#import "Obj3D.h"


@implementation Animation

@synthesize loop;
@synthesize objMatPtr;
@synthesize orgMat;

- (void)dealloc
{
	[keys removeAllObjects];
	[keys release];
	[super dealloc];
}

- (void)addKey:(AnimKey *)key
{
	if (keys == nil) {
		keys = [NSMutableArray arrayWithCapacity:32];
		[keys retain];
	}
	[keys addObject:key];
}

- (int)getKeyAtTime:(float)tm withA:(AnimKey **)keyA andB:(AnimKey **)keyB
{
	int res = 0;
	(*keyA) = nil;
	(*keyB) = nil;
	for (AnimKey *key in keys) {
		if (key.timeKey > tm) {
			(*keyB) = key;
			res |= VALID_KEY_B;
			break;
		} else {
			(*keyA) = key;
			res |= VALID_KEY_A;
		}
	}
	return res;
}

- (float)lastTime
{
	int count;
	count = [keys count];
	if (count > 0) {
		AnimKey *lastKey;
		lastKey = [keys lastObject];
		//lastKey = [keys objectAtIndex:(count - 1)];	// どっちが速いかな？
		return lastKey.timeKey;
	} else {
		return 0.0f;
	}
}

- (void)saveMatrix:(Obj3D *)obj
{
	objMatPtr = [obj getMatrixPtr];
	if (objMatPtr) {
		orgMat = *objMatPtr;
	}
}

@end
