//
//  Light.m
//  Prog06-01
//
//  Created by SAKAI Yuji on 10/01/06.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Light.h"

typedef struct {
	GLenum lightId;
	BOOL used;
} LightIdRec;

static LightIdRec s_LightId[] = {
	{GL_LIGHT0, NO},
	{GL_LIGHT1, NO},
	{GL_LIGHT2, NO},
	{GL_LIGHT3, NO},
	{GL_LIGHT4, NO},
	{GL_LIGHT5, NO},
	{GL_LIGHT6, NO},
	{GL_LIGHT7, NO},
	{BAD_LIGHT_INDEX, NO}
};

@implementation Light

@synthesize ltype;
@synthesize ambient;
@synthesize diffuse;
@synthesize specular;
@synthesize position;
@synthesize direction;
@synthesize exponent;
@synthesize cutoff;

+ (int)searchLightId
{
	int i = 0;
	while (s_LightId[i].lightId != BAD_LIGHT_INDEX) {
		if (!s_LightId[i].used) {
			s_LightId[i].used = YES;
			return i;
		}
	}
	return BAD_LIGHT_INDEX;
}

- (id)initWithParent:(Elem3D *)prnt
{
	self = [super init];
	if (self) {
		parent = prnt;
		lightIndex = [Light searchLightId];
		ltype = LT_NONE;
	}
	return self;
}

- (void)dealloc
{
	if (lightIndex != BAD_LIGHT_INDEX) {
		s_LightId[lightIndex].used = NO;
	}
	[super dealloc];
}

- (GLenum)getLightId
{
	if (lightIndex != BAD_LIGHT_INDEX) {
		return s_LightId[lightIndex].lightId;
	} else {
		return BAD_LIGHT_INDEX;
	}
}

- (void)preRender
{
	if (ltype == LT_NONE) {
		return;
	}
	if (lightIndex == BAD_LIGHT_INDEX) {
		return;
	}
	GLenum lightId;
	lightId = [self getLightId];
	if (lightId == BAD_LIGHT_INDEX) {
		return;
	}
	
    glEnable(lightId);
    glLightfv(lightId, GL_AMBIENT, ambient.f);
    glLightfv(lightId, GL_DIFFUSE, diffuse.f);
    glLightfv(lightId, GL_SPECULAR, specular.f);
    glLightfv(lightId, GL_POSITION, position.f);
	if (ltype == LT_SPOT) {
		glLightfv(lightId, GL_SPOT_DIRECTION, direction.f);
		glLightf(lightId, GL_SPOT_EXPONENT, exponent);
		glLightf(lightId, GL_SPOT_CUTOFF, cutoff);
	}
}

@end
