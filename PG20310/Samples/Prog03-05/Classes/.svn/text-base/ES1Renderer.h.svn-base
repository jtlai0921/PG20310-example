//
//  ES1Renderer.h
//  Prog03-05
//
//  Created by SAKAI Yuji on 09/10/31.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ESRenderer.h"

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import "XYPlate.h"

typedef struct {
	GLfloat f[4];
} Vector4;

struct _Pendulum {
	Vector4 origin;
	Vector4 light;
	float length;
	float deg;
	float delta;
};
typedef struct _Pendulum Pendulum;

#define USE_DEPTH_BUFFER 1

@interface ES1Renderer : NSObject <ESRenderer>
{
@private
	EAGLContext *context;
	
	// The pixel dimensions of the CAEAGLLayer
	GLint backingWidth;
	GLint backingHeight;
	
	// The OpenGL names for the framebuffer and renderbuffer used to render to this view
	GLuint defaultFramebuffer, colorRenderbuffer;
#if (USE_DEPTH_BUFFER)
	GLuint depthRenderbuffer;
#endif
	XYPlate *plate;
	Pendulum *pen;
}

- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;

@end
