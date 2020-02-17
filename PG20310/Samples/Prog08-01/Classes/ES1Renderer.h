//
//  ES1Renderer.h
//  Prog08-01
//
//  Created by SAKAI Yuji on 10/02/16.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ESRenderer.h"

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import "TGATexture.h"

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
	TGATexture *tex;
}

- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;

@end
