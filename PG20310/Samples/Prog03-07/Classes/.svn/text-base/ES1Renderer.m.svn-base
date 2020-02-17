//
//  ES1Renderer.m
//  Prog03-07
//
//  Created by SAKAI Yuji on 09/10/31.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ES1Renderer.h"
#import "glu.h"

const GLfloat light0_Position[]			= { 1.4f, -0.9f, -5.0f, 1.0f };
const GLfloat light1_Position[]			= { 0.0f,  1.2f, -5.0f, 1.0f };
const GLfloat light2_Position[]			= { -1.4f, -0.9f, -5.0f, 1.0f };
const GLfloat light0_SpotDirection[]	= { 0.0f, 0.0f, 1.0f };
const GLfloat light1_SpotDirection[]	= { 0.0f, 0.0f, 1.0f };
const GLfloat light2_SpotDirection[]	= { 0.0f, 0.0f, 1.0f };

@implementation ES1Renderer

// Create an ES 1.1 context
- (id) init
{
	if (self = [super init])
	{
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context])
		{
            [self release];
            return nil;
        }
		
		// Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
		glGenFramebuffersOES(1, &defaultFramebuffer);
		glGenRenderbuffersOES(1, &colorRenderbuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
		
#if (USE_DEPTH_BUFFER)
		glGenRenderbuffersOES(1, &depthRenderbuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
#endif
		//plate = [[XYPlate alloc] initWithWidth:3 andHeight:3 andDeltaHalf:1.5f];
		//plate = [[XYPlate alloc] initWithWidth:4 andHeight:4 andDeltaHalf:1.0f];
		//plate = [[XYPlate alloc] initWithWidth:5 andHeight:5 andDeltaHalf:0.7f];
		//plate = [[XYPlate alloc] initWithWidth:6 andHeight:6 andDeltaHalf:0.6f];
		//plate = [[XYPlate alloc] initWithWidth:9 andHeight:9 andDeltaHalf:0.4f];
		//plate = [[XYPlate alloc] initWithWidth:10 andHeight:10 andDeltaHalf:0.33f];
		//plate = [[XYPlate alloc] initWithWidth:11 andHeight:11 andDeltaHalf:0.3f];
		//plate = [[XYPlate alloc] initWithWidth:12 andHeight:12 andDeltaHalf:0.25f];
		//plate = [[XYPlate alloc] initWithWidth:20 andHeight:20 andDeltaHalf:0.16f];
		//plate = [[XYPlate alloc] initWithWidth:21 andHeight:21 andDeltaHalf:0.16f];
		plate = [[XYPlate alloc] initWithWidth:40 andHeight:40 andDeltaHalf:0.1f];
		//plate = [[XYPlate alloc] initWithWidth:41 andHeight:41 andDeltaHalf:0.08f];
		//plate = [[XYPlate alloc] initWithWidth:101 andHeight:101 andDeltaHalf:0.04f];
		spotLights[0] = [[MySpotLight alloc] initWithLight:GL_LIGHT0];
		[spotLights[0] setPosition:light0_Position];
		[spotLights[0] setSpotDirection:light0_SpotDirection];
		spotLights[0].param0 = 240.0f;
		spotLights[0].param1 = 120.0f;
		spotLights[0].param2 =   0.0f;
		spotLights[1] = [[MySpotLight alloc] initWithLight:GL_LIGHT1];
		[spotLights[1] setPosition:light1_Position];
		[spotLights[1] setSpotDirection:light1_SpotDirection];
		spotLights[1].param0 = 120.0f;
		spotLights[1].param1 =   0.0f;
		spotLights[1].param2 = 240.0f;
		spotLights[2] = [[MySpotLight alloc] initWithLight:GL_LIGHT2];
		[spotLights[2] setPosition:light2_Position];
		[spotLights[2] setSpotDirection:light2_SpotDirection];
		spotLights[2].param0 =   0.0f;
		spotLights[2].param1 = 240.0f;
		spotLights[2].param2 = 120.0f;
	}
	
	return self;
}

- (void) render
{
    // Replace the implementation of this method to do your own custom drawing

	// This application only creates a single context which is already set current at this point.
	// This call is redundant, but needed if dealing with multiple contexts.
    [EAGLContext setCurrentContext:context];
    
	// This application only creates a single default framebuffer which is already bound at this point.
	// This call is redundant, but needed if dealing with multiple framebuffers.
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
    glViewport(0, 0, backingWidth, backingHeight);
    
#if (USE_DEPTH_BUFFER)
	glEnable(GL_DEPTH_TEST);
#endif
#if 0 // CULL FACE
	glEnable(GL_CULL_FACE);
	glCullFace(GL_BACK);
#endif
	glEnable(GL_LIGHTING);

	[spotLights[0] rotateColor];
	[spotLights[1] rotateColor];
	[spotLights[2] rotateColor];
	[spotLights[0] doGlLight];
	[spotLights[1] doGlLight];
	[spotLights[2] doGlLight];
	
	glEnable(GL_NORMALIZE);
	
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
#if (USE_DEPTH_BUFFER)
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
#else
	glClear(GL_COLOR_BUFFER_BIT);
#endif
	
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
	gluPerspective(60.0, 320.0/480.0, 1.0, 100.0);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
	gluLookAt(0.0, 0.0, -9.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
	
	glPushMatrix();
	{
		[plate render];
	}
	glPopMatrix();
	
	// This application only creates a single color renderbuffer which is already bound at this point.
	// This call is redundant, but needed if dealing with multiple renderbuffers.
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer
{	
	// Allocate color buffer backing based on the current layer size
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
#if (USE_DEPTH_BUFFER)
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
	glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
#endif
	
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    return YES;
}

- (void) dealloc
{
	[plate release];
	[spotLights[0] release];
	[spotLights[1] release];
	[spotLights[2] release];

	// Tear down GL
	if (defaultFramebuffer)
	{
		glDeleteFramebuffersOES(1, &defaultFramebuffer);
		defaultFramebuffer = 0;
	}

	if (colorRenderbuffer)
	{
		glDeleteRenderbuffersOES(1, &colorRenderbuffer);
		colorRenderbuffer = 0;
	}
	
#if (USE_DEPTH_BUFFER)
    if(depthRenderbuffer) {
        glDeleteRenderbuffersOES(1, &depthRenderbuffer);
        depthRenderbuffer = 0;
    }
#endif
	
	// Tear down context
	if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	
	[context release];
	context = nil;
	
	[super dealloc];
}

@end
