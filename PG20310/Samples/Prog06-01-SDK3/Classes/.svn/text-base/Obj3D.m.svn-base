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
	[lights removeAllObjects];
	[lights release];
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
	if (lights == nil) {
		lights = [NSMutableArray arrayWithCapacity:16];
		[lights retain];
	}
	[lights addObject:light];
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
	for (Light *lt in lights) {
		[lt preRender];
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
