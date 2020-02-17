//
//  Camera.m
//  Prog06-02
//
//  Created by SAKAI Yuji on 10/01/08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Camera.h"
#import "glu.h"

@implementation Camera

@synthesize active;
@synthesize angle;
@synthesize aspect;
@synthesize near;
@synthesize far;
@synthesize eye;
@synthesize lookAt;
@synthesize up;

- (void)preRender
{
	if (active) {
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		gluPerspective(angle, aspect, near, far);
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		gluLookAt(eye.v.x, eye.v.y, eye.v.z,
				  lookAt.v.x, lookAt.v.y, lookAt.v.z,
				  up.v.x, up.v.y, up.v.z);
	}
}

@end
