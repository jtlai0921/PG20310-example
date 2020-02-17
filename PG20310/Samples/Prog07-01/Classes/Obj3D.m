//
//  Obj3D.m
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/22.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Obj3D.h"
#import "AnimPosition3Key.h"


@implementation Obj3D

- (id)initWithParent:(Elem3D *)prnt
{
	self = [super init];
	if (self) {
		parent = prnt;
		[self matrixIdentity];
	}
	return self;
}

- (void)dealloc
{
	[animPlayer release];
	[meshes removeAllObjects];
	[meshes release];
	[prerenders removeAllObjects];
	[prerenders release];
	[children removeAllObjects];
	[children release];
	[super dealloc];
}

- (void)matrixIdentity
{
	for (int i = 0; i < 16; i++) {
		if (i % 5 == 0) {
			mat.m[i] = 1.0f;
		} else {
			mat.m[i] = 0.0f;
		}
	}
}

- (Matrix *)getMatrixPtr
{
	return &mat;
}

- (Camera *)searchCamera:(int)index withCounter:(int *)counter
{
	for (Elem3D *elem in prerenders) {
		if ([elem isKindOfClass:[Camera class]]) {
			if (index == *counter) {
				return (Camera *)elem;
			}
			(*counter)++;
		}
	}
	for (Obj3D *obj in children) {
		Camera *findCam;
		findCam = [obj searchCamera:index withCounter:counter];
		if (findCam) {
			return findCam;
		}
	}
	return nil;
}

- (void)addMesh:(Mesh *)mesh
{
	if (meshes == nil) {
		meshes = [NSMutableArray arrayWithCapacity:16];
		[meshes retain];
	}
	[meshes addObject:mesh];
}

- (void)addLight:(Light *)light
{
	if (prerenders == nil) {
		prerenders = [NSMutableArray arrayWithCapacity:16];
		[prerenders retain];
	}
	[prerenders addObject:light];
}

- (void)addCamera:(Camera *)cam
{
	if (prerenders == nil) {
		prerenders = [NSMutableArray arrayWithCapacity:16];
		[prerenders retain];
	}
	[prerenders addObject:cam];
}

- (void)addChild:(Obj3D *)child
{
	if (children == nil) {
		children = [NSMutableArray arrayWithCapacity:16];
		[children retain];
	}
	[children addObject:child];
}

- (void)setAnimation:(Animation *)anm
{
	animPlayer = [[AnimPlayer alloc] init];
	animPlayer.anim = anm;
	animPlayer.lastTime = [anm lastTime];
	[anm saveMatrix:self];
}

- (void)preRender:(float)elapsedTime
{
	if (animPlayer.currTime == 0.0) {
		animPlayer.play = YES;
	}
#if 1
	[animPlayer doPlay:elapsedTime];
#else
	if (animPlayer.play) {
		animPlayer.currTime += elapsedTime;
		if (animPlayer.currTime > animPlayer.lastTime) {
			if (animPlayer.anim.loop) {
				animPlayer.currTime -= animPlayer.lastTime;
			} else {
				animPlayer.currTime = animPlayer.lastTime;
				animPlayer.play = NO;
			}
		}
		AnimKey *keyA, *keyB;
		int res;
		res = [animPlayer.anim getKeyAtTime:animPlayer.currTime withA:&keyA andB:&keyB];
		if (res == VALID_KEY_A) {
			mat = animPlayer.anim.orgMat;
			mat.m[12] += ((AnimPosition3Key *)keyA).pos.v.x;
			mat.m[13] += ((AnimPosition3Key *)keyA).pos.v.y;
			mat.m[14] += ((AnimPosition3Key *)keyA).pos.v.z;
		} else if (res == VALID_KEY_B) {
			mat = animPlayer.anim.orgMat;
			mat.m[12] += ((AnimPosition3Key *)keyB).pos.v.x;
			mat.m[13] += ((AnimPosition3Key *)keyB).pos.v.y;
			mat.m[14] += ((AnimPosition3Key *)keyB).pos.v.z;
		} else if (res == (VALID_KEY_A | VALID_KEY_B)) {
			Vector3 pos;
			pos = [AnimPosition3Key interpolate:animPlayer.currTime withA:(AnimPosition3Key *)keyA andB:(AnimPosition3Key *)keyB];
			mat = animPlayer.anim.orgMat;
			mat.m[12] += pos.v.x;
			mat.m[13] += pos.v.y;
			mat.m[14] += pos.v.z;
		} else {
		}
	} else {
	}
#endif
	for (Elem3D *elem in prerenders) {
		[elem preRender:elapsedTime];
	}
	for (Obj3D *obj in children) {
		[obj preRender:elapsedTime];
	}
}

- (void)render
{
	glPushMatrix();
	glMultMatrixf(mat.m);
	for (Mesh *msh in meshes) {
		[msh render];
	}
	for (Obj3D *obj in children) {
		[obj render];
	}
	glPopMatrix();
}

@end
