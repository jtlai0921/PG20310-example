//
//  AnimPlayer.m
//  Prog07-01
//
//  Created by SAKAI Yuji on 10/01/25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimPlayer.h"
#import "AnimPosition3Key.h"
#import "AnimYawPitchRollKey.h"

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
	*(anim.objMatPtr) = anim.orgMat;
	AnimKey *keyA, *keyB;
	int res;
	res = [anim getKeyAtTime:currTime withType:AKT_YAWPITCHROLL fromA:&keyA toB:&keyB];
	if (res == VALID_KEY_A) {
		Matrix rot;
		YawPitchRoll ypr = ((AnimYawPitchRollKey *)keyA).ypr;
		MatrixYawPitchRoll(&rot, &ypr);
		MatrixMutiply(anim.objMatPtr, anim.objMatPtr, &rot);
	} else if (res == VALID_KEY_B) {
		Matrix rot;
		YawPitchRoll ypr = ((AnimYawPitchRollKey *)keyB).ypr;
		MatrixYawPitchRoll(&rot, &ypr);
		MatrixMutiply(anim.objMatPtr, anim.objMatPtr, &rot);
	} else if (res == (VALID_KEY_A | VALID_KEY_B)) {
		Matrix rot;
		YawPitchRoll ypr;
		ypr = [AnimYawPitchRollKey interpolate:currTime withA:(AnimYawPitchRollKey *)keyA andB:(AnimYawPitchRollKey *)keyB];
		MatrixYawPitchRoll(&rot, &ypr);
		MatrixMutiply(anim.objMatPtr, anim.objMatPtr, &rot);
	}
	res = [anim getKeyAtTime:currTime withType:AKT_POSITION3 fromA:&keyA toB:&keyB];
	if (res == VALID_KEY_A) {
		anim.objMatPtr->m[12] += ((AnimPosition3Key *)keyA).pos.v.x;
		anim.objMatPtr->m[13] += ((AnimPosition3Key *)keyA).pos.v.y;
		anim.objMatPtr->m[14] += ((AnimPosition3Key *)keyA).pos.v.z;
	} else if (res == VALID_KEY_B) {
		anim.objMatPtr->m[12] += ((AnimPosition3Key *)keyB).pos.v.x;
		anim.objMatPtr->m[13] += ((AnimPosition3Key *)keyB).pos.v.y;
		anim.objMatPtr->m[14] += ((AnimPosition3Key *)keyB).pos.v.z;
	} else if (res == (VALID_KEY_A | VALID_KEY_B)) {
		Vector3 pos;
		pos = [AnimPosition3Key interpolate:currTime withA:(AnimPosition3Key *)keyA andB:(AnimPosition3Key *)keyB];
		anim.objMatPtr->m[12] += pos.v.x;
		anim.objMatPtr->m[13] += pos.v.y;
		anim.objMatPtr->m[14] += pos.v.z;
	}
}

@end
