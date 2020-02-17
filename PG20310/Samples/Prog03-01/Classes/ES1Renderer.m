//
//  ES1Renderer.m
//  Prog02-01
//
//  Created by SAKAI Yuji on 10/03/11.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "ES1Renderer.h"
#import "glu.h"

#define STEP	4
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
#if (STEP==4)
	const GLfloat lightAmbient[] = { 0.2f, 0.2f, 0.2f, 1.0f };
	const GLfloat lightDiffuse[] = { 0.8f, 0.8f, 0.8f, 1.0f };
	const GLfloat lightSpecular[] = { 1.0f, 1.0f, 1.0f, 1.0f };
	const GLfloat lightPosition[] = { 1.0f, 1.0f, -1.0f, 1.0f };

	const GLfloat cubeAmbient[] = { 0.2f, 0.2f, 0.2f, 1.0f };
	const GLfloat cubeMaterial[] = { 1.0f, 1.0f, 0.0f, 1.0f };
	const GLfloat cubeSpecular[] = { 1.0f, 1.0f, 1.0f, 1.0f };
	const GLfloat cubeShiness[] = { 32.0f };
#endif
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
#if (STEP!=4)
	const GLubyte cubeColors[] = {
		// 
		  0,   0, 255, 255,
		  0,   0, 255, 255,
		  0,   0, 255, 255,
		  0,   0, 255, 255,
		  0,   0, 255, 255,
		  0,   0, 255, 255,
#if (STEP==1)
		// 
		255, 255,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
#elif (STEP==2)
		// 
		255, 255,   0, 255,
		  0, 255, 255, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
#elif (STEP==3)
		// 
		255, 255,   0, 255,
		  0, 255, 255, 255,
		255,   0, 255, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
#else
		// 
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
#endif
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
#endif
	const GLfloat cubeNormals[] = {
		// 
		0.0f, 1.0f, 0.0f,
		0.0f, 1.0f, 0.0f,
		0.0f, 1.0f, 0.0f,
		0.0f, 1.0f, 0.0f,
		0.0f, 1.0f, 0.0f,
		0.0f, 1.0f, 0.0f,
		// 
		0.0f, 0.0f, -1.0f,
		0.0f, 0.0f, -1.0f,
		0.0f, 0.0f, -1.0f,
		0.0f, 0.0f, -1.0f,
		0.0f, 0.0f, -1.0f,
		0.0f, 0.0f, -1.0f,
		// 
		0.0f, -1.0f, 0.0f,
		0.0f, -1.0f, 0.0f,
		0.0f, -1.0f, 0.0f,
		0.0f, -1.0f, 0.0f,
		0.0f, -1.0f, 0.0f,
		0.0f, -1.0f, 0.0f,
		// 
		0.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f,
		// 
		-1.0f, 0.0f, 0.0f,
		-1.0f, 0.0f, 0.0f,
		-1.0f, 0.0f, 0.0f,
		-1.0f, 0.0f, 0.0f,
		-1.0f, 0.0f, 0.0f,
		-1.0f, 0.0f, 0.0f,
		// 
		1.0f, 0.0f, 0.0f,
		1.0f, 0.0f, 0.0f,
		1.0f, 0.0f, 0.0f,
		1.0f, 0.0f, 0.0f,
		1.0f, 0.0f, 0.0f,
		1.0f, 0.0f, 0.0f,
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
#if (STEP==4)
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	glLightfv(GL_LIGHT0, GL_AMBIENT, lightAmbient);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, lightDiffuse);
	glLightfv(GL_LIGHT0, GL_SPECULAR, lightSpecular);
	glLightfv(GL_LIGHT0, GL_POSITION, lightPosition);
#endif
	glEnable(GL_NORMALIZE);

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
	
    glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
    glEnableClientState(GL_VERTEX_ARRAY);
#if (STEP==4)
    glNormalPointer(GL_FLOAT, 0, cubeNormals);
    glEnableClientState(GL_NORMAL_ARRAY);

	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, cubeAmbient);
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, cubeMaterial);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, cubeSpecular);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, cubeShiness);
#if 1
	glPushMatrix();
	{
		static GLfloat cubeRot = 0.0f;
		glRotatef(cubeRot, 1.0f, 1.0f, 1.0f);
		cubeRot += 1.0f;
		if (cubeRot >= 360.0f) {
			cubeRot -= 360.0f;
		}
		glDrawArrays(GL_TRIANGLES, 0, 12*3);
	}
	glPopMatrix();
#else
	static GLfloat cubeRot = 0.0f;
	glPushMatrix();
	{
		glTranslatef(0.0f, 2.0f, 0.0f);
		glRotatef(cubeRot, 1.0f, 1.0f, 1.0f);
		glScalef(0.5f, 0.5f, 0.5f);
		glDrawArrays(GL_TRIANGLES, 0, 12*3);
	}
	glPopMatrix();
	glPushMatrix();
	{
		glTranslatef(0.0f, 0.0f, 0.0f);
		glRotatef(cubeRot, 1.0f, 1.0f, 1.0f);
		glScalef(0.5f, 0.5f, 0.5f);
		glDrawArrays(GL_TRIANGLES, 0, 12*3);
	}
	glPopMatrix();
	glPushMatrix();
	{
		glTranslatef(0.0f, -2.0f, 0.0f);
		glRotatef(cubeRot, 1.0f, 1.0f, 1.0f);
		glScalef(0.5f, 0.5f, 0.5f);
		glDrawArrays(GL_TRIANGLES, 0, 12*3);
	}
	glPopMatrix();
	cubeRot += 1.0f;
	if (cubeRot >= 360.0f) {
		cubeRot -= 360.0f;
	}
#endif
#else
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, cubeColors);
    glEnableClientState(GL_COLOR_ARRAY);
	
	glDrawArrays(GL_TRIANGLES, 0, 12*3);
#endif

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
