//
//  Obj3D.m
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/22.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Obj3D.h"


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

- (void)preRender
{
	for (Elem3D *elem in prerenders) {
		[elem preRender];
	}
	for (Obj3D *obj in children) {
		[obj preRender];
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
