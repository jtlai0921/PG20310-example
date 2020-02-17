//
//  ES1Renderer.m
//  Prog02-01
//
//  Created by SAKAI Yuji on 10/03/11.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "ES1Renderer.h"
#import "glu.h"

#define STEP	1
@implementation ES1Renderer

// Create an OpenGL ES 1.1 context
- (id)init
{
    if ((self = [super init]))
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
    }

    return self;
}

- (void)render
{
    // Replace the implementation of this method to do your own custom drawing
	
    const GLfloat cubeVertices[] = {
		// 
		-0.5f,  0.5f,  0.5f,
		 0.5f,  0.5f,  0.5f,
		 0.5f,  0.5f, -0.5f,
		-0.5f,  0.5f,  0.5f,
		 0.5f,  0.5f, -0.5f,
		-0.5f,  0.5f, -0.5f,
		// 
		-0.5f,  0.5f, -0.5f,
		 0.5f,  0.5f, -0.5f,
		 0.5f, -0.5f, -0.5f,
		-0.5f,  0.5f, -0.5f,
		 0.5f, -0.5f, -0.5f,
		-0.5f, -0.5f, -0.5f,
		// 
		-0.5f, -0.5f, -0.5f,
		 0.5f, -0.5f, -0.5f,
		 0.5f, -0.5f,  0.5f,
		-0.5f, -0.5f, -0.5f,
		 0.5f, -0.5f,  0.5f,
		-0.5f, -0.5f,  0.5f,
		// 
		-0.5f, -0.5f,  0.5f,
		 0.5f, -0.5f,  0.5f,
		 0.5f,  0.5f,  0.5f,
		-0.5f, -0.5f,  0.5f,
		 0.5f,  0.5f,  0.5f,
		-0.5f,  0.5f,  0.5f,
		// 
		-0.5f,  0.5f,  0.5f,
		-0.5f,  0.5f, -0.5f,
		-0.5f, -0.5f, -0.5f,
		-0.5f,  0.5f,  0.5f,
		-0.5f, -0.5f, -0.5f,
		-0.5f, -0.5f,  0.5f,
		// 
		 0.5f,  0.5f, -0.5f,
		 0.5f,  0.5f,  0.5f,
		 0.5f, -0.5f,  0.5f,
		 0.5f,  0.5f, -0.5f,
		 0.5f, -0.5f,  0.5f,
		 0.5f, -0.5f, -0.5f,
	};
	const GLubyte cubeColors[] = {
		// 
		  0,   0, 255, 255,
		  0,   0, 255, 255,
		  0,   0, 255, 255,
		  0,   0, 255, 255,
		  0,   0, 255, 255,
		  0,   0, 255, 255,
		// 
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		// 
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		// 
		  0, 255, 255, 255,
		  0, 255, 255, 255,
		  0, 255, 255, 255,
		  0, 255, 255, 255,
		  0, 255, 255, 255,
		  0, 255, 255, 255,
		// 
		  0, 255,   0, 255,
		  0, 255,   0, 255,
		  0, 255,   0, 255,
		  0, 255,   0, 255,
		  0, 255,   0, 255,
		  0, 255,   0, 255,
		// 
		255,   0, 255, 255,
		255,   0, 255, 255,
		255,   0, 255, 255,
		255,   0, 255, 255,
		255,   0, 255, 255,
		255,   0, 255, 255,
	};

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
	
    glClearColor(0.2f, 0.2f, 0.2f, 1.0f);
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
	gluLookAt(0.0, 0.0, -5.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
#if (STEP==1)
	static GLfloat rot = 0.0f;
	glRotatef(rot, 0.0f, 1.0f, 0.0f);
	glTranslatef(-2.0f, 0.0f, 0.0f);
	rot += 3.0f;
	if (rot >= 360.0f) {
		rot = 0.0f;
	}
#elif (STEP==2)
	static GLfloat rot = 0.0f;
	glRotatef(rot, 0.0f, 1.0f, 0.0f);			// Œöçz—pùçz
	glTranslatef(-2.0f, 0.0f, 0.0f);
	glRotatef(5.0f * rot, 0.0f, 1.0f, 0.0f);	// Ž©çz—pùçz
	rot += 3.0f;
	if (rot >= 360.0f) {
		rot = 0.0f;
	}
#elif (STEP==3)
	static GLfloat rot = 0.0f;
	glRotatef(23.4f, 0.0f, 0.0f, 1.0f);			// Ž©çzŽ²“IŒXŽÎ
	glRotatef(5.0f * rot, 0.0f, 1.0f, 0.0f);	// Ž©çz—pùçz
	rot += 3.0f;
	if (rot >= 360.0f) {
		rot = 0.0f;
	}
#elif (STEP==4)
	static GLfloat rot = 0.0f;
	glRotatef(rot, 0.0f, 1.0f, 0.0f);			// Œöçz—pùçz
	glTranslatef(-2.0f, 0.0f, 0.0f);
	glRotatef(23.4f, 0.0f, 0.0f, 1.0f);			// Ž©çzŽ²“IŒXŽÎ
	glRotatef(5.0f * rot, 0.0f, 1.0f, 0.0f);	// Ž©çz—pùçz
	rot += 3.0f;
	if (rot >= 360.0f) {
		rot = 0.0f;
	}
#elif (STEP==5)
	static GLfloat rot = 0.0f;
	glRotatef(rot, 0.0f, 1.0f, 0.0f);			// Œöçz—pùçz
	glTranslatef(-2.0f, 0.0f, 0.0f);
	glRotatef(-rot, 0.0f, 1.0f, 0.0f);			// ›’Œöçz“IùçzŽ²•œŒ´
	glRotatef(23.4f, 0.0f, 0.0f, 1.0f);			// Ž©çzŽ²“IŒXŽÎ
	glRotatef(5.0f * rot, 0.0f, 1.0f, 0.0f);	// Ž©çz—pùçz
	rot += 3.0f;
	if (rot >= 360.0f) {
		rot = 0.0f;
	}
#elif (STEP==6)
	static GLfloat rot = 0.0f;
	glTranslatef(-1.0f, 0.0f, 0.0f);
	glRotatef(rot, 0.0f, 1.0f, 0.0f);
	rot += 3.0f;
	if (rot >= 360.0f) {
		rot = 0.0f;
	}
#elif (STEP==7)
	static GLfloat rot = 0.0f;
	glTranslatef(sinf(rot * 3.141592 / 180.0f), 0.0f, 0.0f);
	glRotatef(rot, 0.0f, 1.0f, 0.0f);
	rot += 3.0f;
	if (rot >= 360.0f) {
		rot = 0.0f;
	}
#endif
    glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
    glEnableClientState(GL_VERTEX_ARRAY);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, cubeColors);
    glEnableClientState(GL_COLOR_ARRAY);
    
    glDrawArrays(GL_TRIANGLES, 0, 12*3);
	
	// This application only creates a single color renderbuffer which is already bound at this point.
    // This call is redundant, but needed if dealing with multiple renderbuffers.
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer
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

- (void)dealloc
{
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
