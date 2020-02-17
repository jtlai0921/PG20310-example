//
//  AnimYawPitchRollKey.m
//  Prog07-02
//
//  Created by SAKAI Yuji on 10/02/06.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimYawPitchRollKey.h"


@implementation AnimYawPitchRollKey

@synthesize ypr;

+ (YawPitchRoll)interpolate:(float)tm withA:(AnimYawPitchRollKey *)a andB:(AnimYawPitchRollKey *)b
{
	float tm_now, tm_b;
	tm_now = tm - a.timeKey;
	tm_b = b.timeKey - a.timeKey;
	tm_now /= tm_b;
	YawPitchRoll diff, now, ypr_a, ypr_b;
	ypr_a = a.ypr;
	ypr_b = b.ypr;
	diff.yaw = ypr_b.yaw - ypr_a.yaw;
	if (diff.yaw > 180.0f) {
		diff.yaw -= 360.0f;
	} else if (diff.yaw < -180.0f) {
		diff.yaw += 360.0f;
	}
	diff.pitch = ypr_b.pitch - ypr_a.pitch;
	if (diff.pitch > 180.0f) {
		diff.pitch -= 360.0f;
	} else if (diff.pitch < -180.0f) {
		diff.pitch += 360.0f;
	}
	diff.roll = ypr_b.roll - ypr_a.roll;
	if (diff.roll > 180.0f) {
		diff.roll -= 360.0f;
	} else if (diff.roll < -180.0f) {
		diff.roll += 360.0f;
	}
	now.yaw = ypr_a.yaw + diff.yaw * tm_now;
	now.pitch = ypr_a.pitch + diff.pitch * tm_now;
	now.roll = ypr_a.roll + diff.roll * tm_now;
	return now;
}

- (id)initWithTime:(float)tm
{
	self = [super init];
	if (self) {
		akType = AKT_YAWPITCHROLL;
		timeKey = tm;
	}
	return self;
}

@end
