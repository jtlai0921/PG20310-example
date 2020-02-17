//
//  Loader.m
//  Prog06-01
//
//  Created by SAKAI Yuji on 10/01/07.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Loader.h"


@implementation Loader

+ (int)transpose:(int)index
{
	int x, y;
	x = index % 4;
	y = index / 4;
	return (x * 4) + y;
}

+ (BOOL)parseVector4:(Vector4 *)pv from:(NSString *)val
{
	Vector4 vec;
	NSArray *vals;
	vals = [val componentsSeparatedByString:@","];
	if ([vals count] == 4) {
		for (int i = 0; i < 4; i++) {
			NSString *temp;
			temp = [vals objectAtIndex:i];
			vec.f[i] = [temp floatValue];
		}
		*pv = vec;
		return YES;
	}
	return NO;
}

+ (BOOL)parseVector3:(Vector3 *)pv from:(NSString *)val
{
	Vector3 vec;
	NSArray *vals;
	vals = [val componentsSeparatedByString:@","];
	if ([vals count] == 3) {
		for (int i = 0; i < 3; i++) {
			NSString *temp;
			temp = [vals objectAtIndex:i];
			vec.f[i] = [temp floatValue];
		}
		*pv = vec;
		return YES;
	}
	return NO;
}

+ (BOOL)parseVector2:(Vector2 *)pv from:(NSString *)val
{
	Vector2 vec;
	NSArray *vals;
	vals = [val componentsSeparatedByString:@","];
	if ([vals count] == 2) {
		for (int i = 0; i < 2; i++) {
			NSString *temp;
			temp = [vals objectAtIndex:i];
			vec.f[i] = [temp floatValue];
		}
		*pv = vec;
		return YES;
	}
	return NO;
}

+ (BOOL)parseRGBA:(RGBA *)pcolor from:(NSString *)val
{
	RGBA color;
	NSArray *vals;
	vals = [val componentsSeparatedByString:@","];
	if ([vals count] == 4) {
		for (int i = 0; i < 4; i++) {
			NSString *temp;
			temp = [vals objectAtIndex:i];
			color.f[i] = [temp floatValue];
		}
		*pcolor = color;
		return YES;
	}
	return NO;
}

+ (BOOL)parseMatrix:(Matrix *)pmat withString:(NSString *)val
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

+ (BOOL)parseYawPitchRoll:(YawPitchRoll *)pypr from:(NSString *)val
{
	YawPitchRoll ypr;
	NSArray *vals;
	vals = [val componentsSeparatedByString:@","];
	if ([vals count] == 3) {
		NSString *temp;
		temp = [vals objectAtIndex:0];
		ypr.yaw = [temp floatValue];
		temp = [vals objectAtIndex:1];
		ypr.pitch = [temp floatValue];
		temp = [vals objectAtIndex:2];
		ypr.roll = [temp floatValue];
		*pypr = ypr;
		return YES;
	}
	return NO;
}

@end
