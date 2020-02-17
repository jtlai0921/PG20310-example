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
		// 上面
		-0.5f,  0.5f,  0.5f,
		 0.5f,  0.5f,  0.5f,
		 0.5f,  0.5f, -0.5f,
		-0.5f,  0.5f,  0.5f,
		 0.5f,  0.5f, -0.5f,
		-0.5f,  0.5f, -0.5f,
		// 前面
		-0.5f,  0.5f, -0.5f,
		 0.5f,  0.5f, -0.5f,
		 0.5f, -0.5f, -0.5f,
		-0.5f,  0.5f, -0.5f,
		 0.5f, -0.5f, -0.5f,
		-0.5f, -0.5f, -0.5f,
		// 下面
		-0.5f, -0.5f, -0.5f,
		 0.5f, -0.5f, -0.5f,
		 0.5f, -0.5f,  0.5f,
		-0.5f, -0.5f, -0.5f,
		 0.5f, -0.5f,  0.5f,
		-0.5f, -0.5f,  0.5f,
		// 後面
		-0.5f, -0.5f,  0.5f,
		 0.5f, -0.5f,  0.5f,
		 0.5f,  0.5f,  0.5f,
		-0.5f, -0.5f,  0.5f,
		 0.5f,  0.5f,  0.5f,
		-0.5f,  0.5f,  0.5f,
		// 右面
		-0.5f,  0.5f,  0.5f,
		-0.5f,  0.5f, -0.5f,
		-0.5f, -0.5f, -0.5f,
		-0.5f,  0.5f,  0.5f,
		-0.5f, -0.5f, -0.5f,
		-0.5f, -0.5f,  0.5f,
		// 左面
		 0.5f,  0.5f, -0.5f,
		 0.5f,  0.5f,  0.5f,
		 0.5f, -0.5f,  0.5f,
		 0.5f,  0.5f, -0.5f,
		 0.5f, -0.5f,  0.5f,
		 0.5f, -0.5f, -0.5f,
	};
	const GLubyte sunColors[] = {
		// 上面
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		// 前面
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		// 下面
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		// 後面
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		// 右面
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		// 左面
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
		255, 255,   0, 255,
	};
	const GLubyte earthColors[] = {
		// 上面
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		// 前面
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		// 下面
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		// 後面
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		// 右面
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		// 左面
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
		0,   0, 255, 255,
	};
	const GLubyte moonColors[] = {
		// 上面
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		// 前面
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		// 下面
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		// 後面
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		// 右面
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		// 左面
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
		192, 192, 192, 255,
	};
	const GLubyte marsColors[] = {
		// 上面
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		// 前面
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		// 下面
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		// 後面
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		// 右面
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		// 左面
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
		255,   0,   0, 255,
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

	static GLfloat rot = 0.0f;
	glPushMatrix();
	{
		// 太陽
		glTranslatef(0.0f, sinf(rot * 3.141593f / 180.0f) * 0.1f, 0.0f);
		glPushMatrix();
		{
			glRotatef(rot, 0.0f, 1.0f, 0.0f);
			
			glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
			glEnableClientState(GL_VERTEX_ARRAY);
			glColorPointer(4, GL_UNSIGNED_BYTE, 0, sunColors);
			glEnableClientState(GL_COLOR_ARRAY);
			glDrawArrays(GL_TRIANGLES, 0, 12*3);
		}
		glPopMatrix();
		
		// 地球
		glPushMatrix();
		{
			glRotatef(rot, 0.0f, 1.0f, 0.0f);
			glTranslatef(-2.5f, 0.0f, 0.0f);
			glRotatef(-rot, 0.0f, 1.0f, 0.0f);
			glPushMatrix();
			{
				glRotatef(23.4f, 0.0f, 0.0f, 1.0f);
				glRotatef(6.0f * rot, 0.0f, 1.0f, 0.0f);
				glScalef(0.3f, 0.3f, 0.3f);
				
				glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
				glEnableClientState(GL_VERTEX_ARRAY);
				glColorPointer(4, GL_UNSIGNED_BYTE, 0, earthColors);
				glEnableClientState(GL_COLOR_ARRAY);
				glDrawArrays(GL_TRIANGLES, 0, 12*3);
			}
			glPopMatrix();
			
			// 月亮
			glPushMatrix();
			{
				glRotatef(5.0f * rot, 0.0f, 1.0f, 0.0f);
				glTranslatef(-0.7f, 0.0f, 0.0f);
				glScalef(0.1f, 0.1f, 0.1f);
				
				glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
				glEnableClientState(GL_VERTEX_ARRAY);
				glColorPointer(4, GL_UNSIGNED_BYTE, 0, moonColors);
				glEnableClientState(GL_COLOR_ARRAY);
				glDrawArrays(GL_TRIANGLES, 0, 12*3);
			}
			glPopMatrix();
		}
		glPopMatrix();
#if 1
		static GLfloat rot2 = 0.0f;
		// 火星
		glPushMatrix();
		{
			glRotatef(rot2, 0.0f, 1.0f, 0.0f);
			glTranslatef(-3.5f, 0.0f, 0.0f);
			glRotatef(10.0f * rot2, 0.0f, 1.0f, 0.0f);
			glScalef(0.2f, 0.2f, 0.2f);
			
			glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
			glEnableClientState(GL_VERTEX_ARRAY);
			glColorPointer(4, GL_UNSIGNED_BYTE, 0, marsColors);
			glEnableClientState(GL_COLOR_ARRAY);
			glDrawArrays(GL_TRIANGLES, 0, 12*3);
		}
		glPopMatrix();
		rot2 += 0.3f;
		if (rot2 >= 360.0f) {
			rot2 = 0.0f;
		}
#endif
	}
	glPopMatrix();
	
	rot += 0.5f;
	if (rot >= 360.0f) {
		rot = 0.0f;
	}
	
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
