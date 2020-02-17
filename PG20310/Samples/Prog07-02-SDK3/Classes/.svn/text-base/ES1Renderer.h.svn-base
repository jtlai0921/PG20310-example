//
//  ES1Renderer.h
//  Prog07-02
//
//  Created by SAKAI Yuji on 10/02/05.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ESRenderer.h"
#import "Obj3D.h"

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

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
	Obj3D *rootObj;
}

- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;

@end
