//
//  ES1Renderer.m
//  Prog02-01
//
//  Created by SAKAI Yuji on 10/03/11.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "ES1Renderer.h"
#import "glu.h"

#define STEP	99
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
		// ã–Ê
		-0.5f,  0.5f,  0.5f,
		 0.5f,  0.5f,  0.5f,
		 0.5f,  0.5f, -0.5f,
		-0.5f,  0.5f,  0.5f,
		 0.5f,  0.5f, -0.5f,
		-0.5f,  0.5f, -0.5f,
		// ‘O–Ê
		-0.5f,  0.5f, -0.5f,
		 0.5f,  0.5f, -0.5f,
		 0.5f, -0.5f, -0.5f,
		-0.5f,  0.5f, -0.5f,
		 0.5f, -0.5f, -0.5f,
		-0.5f, -0.5f, -0.5f,
		// ‰º–Ê
		-0.5f, -0.5f, -0.5f,
		 0.5f, -0.5f, -0.5f,
		 0.5f, -0.5f,  0.5f,
		-0.5f, -0.5f, -0.5f,
		 0.5f, -0.5f,  0.5f,
		-0.5f, -0.5f,  0.5f,
		// Œã–Ê
		-0.5f, -0.5f,  0.5f,
		 0.5f, -0.5f,  0.5f,
		 0.5f,  0.5f,  0.5f,
		-0.5f, -0.5f,  0.5f,
		 0.5f,  0.5f,  0.5f,
		-0.5f,  0.5f,  0.5f,
		// ‰E–Ê
		-0.5f,  0.5f,  0.5f,
		-0.5f,  0.5f, -0.5f,
		-0.5f, -0.5f, -0.5f,
		-0.5f,  0.5f,  0.5f,
		-0.5f, -0.5f, -0.5f,
		-0.5f, -0.5f,  0.5f,
		// ¶–Ê
		 0.5f,  0.5f, -0.5f,
		 0.5f,  0.5f,  0.5f,
		 0.5f, -0.5f,  0.5f,
		 0.5f,  0.5f, -0.5f,
		 0.5f, -0.5f,  0.5f,
		 0.5f, -0.5f, -0.5f,
	};
	const GLubyte cubeColors[] = {
		// ã–Ê
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		// ‘O–Ê
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		// ‰º–Ê
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		// Œã–Ê
		0, 255, 255, 255,
		0, 255, 255, 255,
		0, 255, 255, 255,
		0, 255, 255, 255,
		0, 255, 255, 255,
		0, 255, 255, 255,
		// ‰E–Ê
		0, 255,   0, 255,
		0, 255,   0, 255,
		0, 255,   0, 255,
		0, 255,   0, 255,
		0, 255,   0, 255,
		0, 255,   0, 255,
		// ¶–Ê
		255,   0, 255, 255,
		255,   0, 255, 255,
		255,   0, 255, 255,
		255,   0, 255, 255,
		255,   0, 255, 255,
		255,   0, 255, 255,
	};
	const GLubyte cube2Colors[] = {
		// ã–Ê
		128, 128, 255, 255,
		128, 128, 255, 255,
		128, 128, 255, 255,
		128, 128, 255, 255,
		128, 128, 255, 255,
		128, 128, 255, 255,
		// ‘O–Ê
		255, 128, 128, 255,
		255, 128, 128, 255,
		255, 128, 128, 255,
		255, 128, 128, 255,
		255, 128, 128, 255,
		255, 128, 128, 255,
		// ‰º–Ê
		255, 255, 128, 255,
		255, 255, 128, 255,
		255, 255, 128, 255,
		255, 255, 128, 255,
		255, 255, 128, 255,
		255, 255, 128, 255,
		// Œã–Ê
		128, 255, 255, 255,
		128, 255, 255, 255,
		128, 255, 255, 255,
		128, 255, 255, 255,
		128, 255, 255, 255,
		128, 255, 255, 255,
		// ‰E–Ê
		128, 255, 128, 255,
		128, 255, 128, 255,
		128, 255, 128, 255,
		128, 255, 128, 255,
		128, 255, 128, 255,
		128, 255, 128, 255,
		// ¶–Ê
		255, 128, 255, 255,
		255, 128, 255, 255,
		255, 128, 255, 255,
		255, 128, 255, 255,
		255, 128, 255, 255,
		255, 128, 255, 255,
	};
	const GLubyte cube3Colors[] = {
		// ã–Ê
		0,   0, 128, 255,
		0,   0, 128, 255,
		0,   0, 128, 255,
		0,   0, 128, 255,
		0,   0, 128, 255,
		0,   0, 128, 255,
		// ‘O–Ê
		128,   0,   0, 255,
		128,   0,   0, 255,
		128,   0,   0, 255,
		128,   0,   0, 255,
		128,   0,   0, 255,
		128,   0,   0, 255,
		// ‰º–Ê
		128, 128,   0, 255,
		128, 128,   0, 255,
		128, 128,   0, 255,
		128, 128,   0, 255,
		128, 128,   0, 255,
		128, 128,   0, 255,
		// Œã–Ê
		0, 128, 128, 255,
		0, 128, 128, 255,
		0, 128, 128, 255,
		0, 128, 128, 255,
		0, 128, 128, 255,
		0, 128, 128, 255,
		// ‰E–Ê
		0, 128,   0, 255,
		0, 128,   0, 255,
		0, 128,   0, 255,
		0, 128,   0, 255,
		0, 128,   0, 255,
		0, 128,   0, 255,
		// ¶–Ê
		128,   0, 128, 255,
		128,   0, 128, 255,
		128,   0, 128, 255,
		128,   0, 128, 255,
		128,   0, 128, 255,
		128,   0, 128, 255,
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
	
	// “®á`—p“IÌÉ
	static GLfloat baseRot = 30.0f;
	static GLfloat arm1Param = 0.0f;
	static GLfloat arm1Rot = 30.0f;
	static GLfloat arm2Param = 0.0f;
	static GLfloat arm2Rot = -90.0f;
	static GLfloat palmParam = 0.0f;
	static GLfloat palmRot = 45.0f;
	static GLfloat thumb1Param = 0.0f;
	static GLfloat thumb1Rot = -67.5f;
	static GLfloat thumb2Rot = 90.0f;
	static GLfloat finger1Param = 0.0f;
	static GLfloat finger1Rot = 67.5f;
	static GLfloat finger2Rot = -90.0f;
	
	// ’²®Šî’êˆÊ’u
	glTranslatef(0.0f, -1.5f, 0.0f);
	glPushMatrix();
	{
		// Šî’ê
		glTranslatef(0.0f, 0.1f, 0.0);
		glRotatef(baseRot, 0.0f, 1.0f, 0.0f);
		glPushMatrix();
		{
			glScalef(1.3f, 0.2f, 1.3f);
			glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
			glEnableClientState(GL_VERTEX_ARRAY);
			glColorPointer(4, GL_UNSIGNED_BYTE, 0, cube3Colors);
			glEnableClientState(GL_COLOR_ARRAY);
			glDrawArrays(GL_TRIANGLES, 0, 12*3);
		}
		glPopMatrix();
		
		// Žèä]1
		glTranslatef(0.0f, 0.1f, 0.0);
		glRotatef(arm1Rot, 1.0f, 0.0f, 0.0f);
		glTranslatef(0.0f, 0.75f, 0.0);
		glPushMatrix();
		{
			glScalef(0.5f, 1.5f, 0.5f);
			glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
			glEnableClientState(GL_VERTEX_ARRAY);
			glColorPointer(4, GL_UNSIGNED_BYTE, 0, cubeColors);
			glEnableClientState(GL_COLOR_ARRAY);
			glDrawArrays(GL_TRIANGLES, 0, 12*3);
		}
		glPopMatrix();
		
		// Žèä]2
		glTranslatef(0.0f, 0.75f, 0.0);
		glRotatef(arm2Rot, 1.0f, 0.0f, 0.0f);
		glTranslatef(0.0f, 0.6f, 0.0);
		glPushMatrix();
		{
			glScalef(0.5f, 1.2f, 0.5f);
			glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
			glEnableClientState(GL_VERTEX_ARRAY);
			glColorPointer(4, GL_UNSIGNED_BYTE, 0, cubeColors);
			glEnableClientState(GL_COLOR_ARRAY);
			glDrawArrays(GL_TRIANGLES, 0, 12*3);
		}
		glPopMatrix();
		
		// Žè¶
		glTranslatef(0.0f, 0.6f, 0.0f);
		glRotatef(palmRot, 0.0f, 1.0f, 0.0f);
		glTranslatef(0.0f, 0.25f, 0.0f);
		glPushMatrix();
		{
			glScalef(0.5f, 0.5f, 0.5f);
			glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
			glEnableClientState(GL_VERTEX_ARRAY);
			glColorPointer(4, GL_UNSIGNED_BYTE, 0, cube2Colors);
			glEnableClientState(GL_COLOR_ARRAY);
			glDrawArrays(GL_TRIANGLES, 0, 12*3);
		}
		glPopMatrix();
		
		// dŽw1
		glPushMatrix();
		{
			glTranslatef(0.0f, 0.25f, 0.0f);
			glRotatef(thumb1Rot, 1.0f, 0.0f, 0.0f);
			glTranslatef(0.0f, 0.25f, 0.0f);
			glPushMatrix();
			{
				glScalef(0.2f, 0.5f, 0.2f);
				glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
				glEnableClientState(GL_VERTEX_ARRAY);
				glColorPointer(4, GL_UNSIGNED_BYTE, 0, cubeColors);
				glEnableClientState(GL_COLOR_ARRAY);
				glDrawArrays(GL_TRIANGLES, 0, 12*3);
			}
			glPopMatrix();
			
			// dŽw2
			glTranslatef(0.0f, 0.25f, 0.0f);
			glRotatef(thumb2Rot, 1.0f, 0.0f, 0.0f);
			glTranslatef(0.0f, 0.25f, 0.0f);
			glPushMatrix();
			{
				glScalef(0.2f, 0.5f, 0.2f);
				glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
				glEnableClientState(GL_VERTEX_ARRAY);
				glColorPointer(4, GL_UNSIGNED_BYTE, 0, cubeColors);
				glEnableClientState(GL_COLOR_ARRAY);
				glDrawArrays(GL_TRIANGLES, 0, 12*3);
			}
			glPopMatrix();
		}
		glPopMatrix();
		
		// HŽw1
		glPushMatrix();
		{
			glTranslatef(0.0f, 0.25f, 0.0f);
			glRotatef(finger1Rot, 1.0f, 0.0f, 0.0f);
			glTranslatef(0.0f, 0.25f, 0.0f);
			glPushMatrix();
			{
				glScalef(0.2f, 0.5f, 0.2f);
				glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
				glEnableClientState(GL_VERTEX_ARRAY);
				glColorPointer(4, GL_UNSIGNED_BYTE, 0, cubeColors);
				glEnableClientState(GL_COLOR_ARRAY);
				glDrawArrays(GL_TRIANGLES, 0, 12*3);
			}
			glPopMatrix();
			
			// HŽw2
			glTranslatef(0.0f, 0.25f, 0.0f);
			glRotatef(finger2Rot, 1.0f, 0.0f, 0.0f);
			glTranslatef(0.0f, 0.25f, 0.0f);
			glPushMatrix();
			{
				glScalef(0.2f, 0.5f, 0.2f);
				glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
				glEnableClientState(GL_VERTEX_ARRAY);
				glColorPointer(4, GL_UNSIGNED_BYTE, 0, cubeColors);
				glEnableClientState(GL_COLOR_ARRAY);
				glDrawArrays(GL_TRIANGLES, 0, 12*3);
			}
			glPopMatrix();
		}
		glPopMatrix();
	}
	glPopMatrix();
	
#if 1 // ”@‰Ê—v’âŽ~“®á`¿Ýˆ×0
	// ‹@ŠBŽèä]“I“®á`
	baseRot += 0.5f;
	if (baseRot >= 360.0f) {
		baseRot = 0.0f;
	}
	arm1Param += 0.7f;
	if (arm1Param >= 360.0f) {
		arm1Param = 0.0f;
	}
	arm1Rot = sinf(arm1Param * 3.141593f / 180.0f) * 45.0f;
	arm2Param += 1.0f;
	if (arm2Param >= 360.0f) {
		arm2Param = 0.0f;
	}
	arm2Rot = sinf(arm2Param * 3.141593f / 180.0f) * 90.0f;
	palmParam += 2.0f;
	if (palmParam >= 360.0f) {
		palmParam = 0.0f;
	}
	palmRot = sinf(palmParam * 3.141593f / 180.0f) * 90.0f;
	thumb1Param += 3.0f;
	if (thumb1Param >= 360.0f) {
		thumb1Param = 0.0f;
	}
	thumb1Rot = sinf(thumb1Param * 3.141593f / 180.0f) * 22.5f - 67.5f;
	finger1Param += 3.0f;
	if (finger1Param >= 360.0f) {
		finger1Param = 0.0f;
	}
	finger1Rot = -sinf(finger1Param * 3.141593f / 180.0f) * 22.5f + 67.5f;
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
