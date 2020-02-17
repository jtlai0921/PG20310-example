//
//  AnimPlayer.m
//  Prog07-01
//
//  Created by SAKAI Yuji on 10/01/25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimPlayer.h"
#import "AnimPosition3Key.h"

@implementation AnimPlayer

@synthesize play;
@synthesize currTime;
@synthesize lastTime;
@synthesize anim;

- (void)dealloc
{
	[anim release];
	[super dealloc];
}

- (void)doPlay:(float)elapsedTime
{
	if (!play) {
		return;
	}
	currTime += elapsedTime;
	if (currTime > lastTime) {
		if (anim.loop) {
			currTime -= lastTime;
		} else {
			currTime = lastTime;
			play = NO;
		}
	}
	AnimKey *keyA, *keyB;
	int res;
	res = [anim getKeyAtTime:currTime withA:&keyA andB:&keyB];
	if (res == VALID_KEY_A) {
		*(anim.objMatPtr) = anim.orgMat;
		if (keyA.akType == AKT_POSITION3) {
			anim.objMatPtr->m[12] += ((AnimPosition3Key *)keyA).pos.v.x;
			anim.objMatPtr->m[13] += ((AnimPosition3Key *)keyA).pos.v.y;
			anim.objMatPtr->m[14] += ((AnimPosition3Key *)keyA).pos.v.z;
		}
	} else if (res == VALID_KEY_B) {
		*(anim.objMatPtr) = anim.orgMat;
		if (keyB.akType == AKT_POSITION3) {
			anim.objMatPtr->m[12] += ((AnimPosition3Key *)keyB).pos.v.x;
			anim.objMatPtr->m[13] += ((AnimPosition3Key *)keyB).pos.v.y;
			anim.objMatPtr->m[14] += ((AnimPosition3Key *)keyB).pos.v.z;
		}
	} else if (res == (VALID_KEY_A | VALID_KEY_B)) {
		if (keyA.akType == AKT_POSITION3) {
			Vector3 pos;
			pos = [AnimPosition3Key interpolate:currTime withA:(AnimPosition3Key *)keyA andB:(AnimPosition3Key *)keyB];
			*(anim.objMatPtr) = anim.orgMat;
			anim.objMatPtr->m[12] += pos.v.x;
			anim.objMatPtr->m[13] += pos.v.y;
			anim.objMatPtr->m[14] += pos.v.z;
		}
	}
}

@end
