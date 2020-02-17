//
//  AnimPosition3Key.m
//  Prog07-01
//
//  Created by SAKAI Yuji on 10/01/25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimPosition3Key.h"


@implementation AnimPosition3Key

@synthesize pos;

+ (Vector3)interpolate:(float)tm withA:(AnimPosition3Key *)a andB:(AnimPosition3Key *)b
{
	float tm_now, tm_b;
	Vector3 pos_diff, pos_now;
	tm_now = tm - a.timeKey;
	tm_b = b.timeKey - a.timeKey;
	tm_now /= tm_b;
	pos_diff.v.x = b.pos.v.x - a.pos.v.x;
	pos_diff.v.y = b.pos.v.y - a.pos.v.y;
	pos_diff.v.z = b.pos.v.z - a.pos.v.z;
	pos_now = a.pos;
	pos_now.v.x += pos_diff.v.x * tm_now;
	pos_now.v.y += pos_diff.v.y * tm_now;
	pos_now.v.z += pos_diff.v.z * tm_now;
	return pos_now;
}

- (id)initWithTime:(float)tm
{
	self = [super init];
	if (self) {
		akType = AKT_POSITION3;
		timeKey = tm;
	}
	return self;
}

@end
