//
//  ES1Renderer.m
//  Prog03-05
//
//  Created by SAKAI Yuji on 09/10/31.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ES1Renderer.h"
#import "glu.h"

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
		plate = [[XYPlate alloc] initWithWidth:40 andHeight:40 andDeltaHalf:0.08f];
		//plate = [[XYPlate alloc] initWithWidth:41 andHeight:41 andDeltaHalf:0.08f];
		//plate = [[XYPlate alloc] initWithWidth:101 andHeight:101 andDeltaHalf:0.03f];
		
		pen = (Pendulum *)malloc(sizeof(Pendulum));
		pen->origin.f[0] = 0.0f;
		pen->origin.f[1] = 2.5f;
		pen->origin.f[2] = 0.0f;
		pen->origin.f[3] = 1.0f;
		pen->light = pen->origin;
		/*
		 pen->light.f[0] = 0.0f;
		 pen->light.f[1] = 0.0f;
		 pen->light.f[2] = 0.0f;
		 pen->light.f[3] = 1.0f;
		 */
		pen->length = 2.0f;
		pen->deg = 0.0f;
		pen->delta = 3.0f;
	}
	
	return self;
}

- (void) render
{
    // Replace the implementation of this method to do your own custom drawing
	const GLfloat lightAmbient[] = { 0.2f, 0.2f, 0.2f, 1.0f };
	const GLfloat lightDiffuse[] = { 0.8f, 0.8f, 0.8f, 1.0f };
	const GLfloat lightSpecular[] = { 1.0f, 1.0f, 1.0f, 1.0f };
	//const GLfloat lightPosition[] = { 0.0f, 0.0f, -1.0f, 1.0f };
#if 0
	const GLfloat lightSpotDirection[] = { 0.0f, -1.0f, 1.0f };
	const GLfloat lightSpotExponent = 3.0f;
	const GLfloat lightSpotCutoff = 30.0f;
#endif
    
	const GLfloat cubeAmbient[] = { 0.2f, 0.2f, 0.2f, 1.0f };
#if 0
	const GLfloat cubeMaterial[] = { 1.0f, 0.0f, 0.0f, 1.0f };
	const GLfloat cubeEmission[] = { 1.0f, 0.0f, 0.0f, 1.0f };
	const GLfloat cubeSpecular[] = { 1.0f, 0.0f, 0.0f, 1.0f };
#else
	const GLfloat cubeMaterial[] = { 1.0f, 1.0f, 1.0f, 1.0f };
	const GLfloat cubeEmission[] = { 1.0f, 1.0f, 1.0f, 1.0f };
	const GLfloat cubeSpecular[] = { 1.0f, 1.0f, 1.0f, 1.0f };
#endif
	const GLfloat cubeShiness[] = { 32.0f };
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
	const GLfloat cubeNormals[] = {
		// 上面
		0.0f, 1.0f, 0.0f,
		0.0f, 1.0f, 0.0f,
		0.0f, 1.0f, 0.0f,
		0.0f, 1.0f, 0.0f,
		0.0f, 1.0f, 0.0f,
		0.0f, 1.0f, 0.0f,
		// 前面
		0.0f, 0.0f, -1.0f,
		0.0f, 0.0f, -1.0f,
		0.0f, 0.0f, -1.0f,
		0.0f, 0.0f, -1.0f,
		0.0f, 0.0f, -1.0f,
		0.0f, 0.0f, -1.0f,
		// 下面
		0.0f, -1.0f, 0.0f,
		0.0f, -1.0f, 0.0f,
		0.0f, -1.0f, 0.0f,
		0.0f, -1.0f, 0.0f,
		0.0f, -1.0f, 0.0f,
		0.0f, -1.0f, 0.0f,
		// 後面
		0.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f,
		// 右面
		-1.0f, 0.0f, 0.0f,
		-1.0f, 0.0f, 0.0f,
		-1.0f, 0.0f, 0.0f,
		-1.0f, 0.0f, 0.0f,
		-1.0f, 0.0f, 0.0f,
		-1.0f, 0.0f, 0.0f,
		// 左面
		1.0f, 0.0f, 0.0f,
		1.0f, 0.0f, 0.0f,
		1.0f, 0.0f, 0.0f,
		1.0f, 0.0f, 0.0f,
		1.0f, 0.0f, 0.0f,
		1.0f, 0.0f, 0.0f,
	};
    
	pen->deg += pen->delta;
	if (pen->deg >= 45.0f) {
		pen->delta = -pen->delta;
	} else if (pen->deg <= -45.0f) {
		pen->delta = -pen->delta;
	}
	pen->light.f[0] = pen->origin.f[0] + pen->length * sinf((pen->deg * 3.141593f) / 180.0f);
	pen->light.f[1] = pen->origin.f[1] - pen->length * cosf((pen->deg * 3.141593f) / 180.0f);
	//pen->light.f[2] = pen->origin.f[2] + pen->length * sinf((pen->deg * 3.141593f) / 180.0f);
	
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
#if 1 // CULL FACE
	glEnable(GL_CULL_FACE);
	glCullFace(GL_BACK);
#endif
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	glLightfv(GL_LIGHT0, GL_AMBIENT, lightAmbient);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, lightDiffuse);
	glLightfv(GL_LIGHT0, GL_SPECULAR, lightSpecular);
	//glLightfv(GL_LIGHT0, GL_POSITION, lightPosition);
	glLightfv(GL_LIGHT0, GL_POSITION, pen->light.f);
#if 0
	glLightfv(GL_LIGHT0, GL_SPOT_DIRECTION, lightSpotDirection);
	glLightf(GL_LIGHT0, GL_SPOT_EXPONENT, lightSpotExponent);
	glLightf(GL_LIGHT0, GL_SPOT_CUTOFF, lightSpotCutoff);
#endif
#if	1
#if 0
	glLightf(GL_LIGHT0, GL_CONSTANT_ATTENUATION, 0.1f);
	glLightf(GL_LIGHT0, GL_LINEAR_ATTENUATION, 0.1f);
	glLightf(GL_LIGHT0, GL_QUADRATIC_ATTENUATION, 0.0f);
#else
	glLightf(GL_LIGHT0, GL_CONSTANT_ATTENUATION, 0.1f);
	glLightf(GL_LIGHT0, GL_LINEAR_ATTENUATION, 0.1f);
	glLightf(GL_LIGHT0, GL_QUADRATIC_ATTENUATION, 0.2f);
#endif
#endif
	
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
	gluLookAt(0.0, 0.0, -7.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
	//gluLookAt(-7.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
	
	glPushMatrix();
	{
		glTranslatef(0.0f, 0.0f, 2.5f);
		[plate render];
	}
	glPopMatrix();
	
	glPushMatrix();
	{
		glTranslatef(2.5f, 0.0f, 0.0f);
		glRotatef(90.0f, 0.0f, 1.0f, 0.0f);
		[plate render];
	}
	glPopMatrix();
	
	glPushMatrix();
	{
		glTranslatef(-2.5f, 0.0f, 0.0f);
		glRotatef(-90.0f, 0.0f, 1.0f, 0.0f);
		[plate render];
	}
	glPopMatrix();
	
	glPushMatrix();
	{
		glTranslatef(0.0f, -2.5f, 0.0f);
		glRotatef(90.0f, 1.0f, 0.0f, 0.0f);
		[plate render];
	}
	glPopMatrix();
	
	glPushMatrix();
	{
		glTranslatef(0.0f, 2.5f, 0.0f);
		glRotatef(-90.0f, 1.0f, 0.0f, 0.0f);
		[plate render];
	}
	glPopMatrix();
	
	glPushMatrix();
	{
		glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
		glEnableClientState(GL_VERTEX_ARRAY);
		glNormalPointer(GL_FLOAT, 0, cubeNormals);
		glEnableClientState(GL_NORMAL_ARRAY);
		
		glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, cubeAmbient);
		glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, cubeMaterial);
		glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, cubeEmission);
		glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, cubeSpecular);
		glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, cubeShiness);
		
		glTranslatef(pen->light.f[0], pen->light.f[1], pen->light.f[2]);
		glScalef(0.2f, 0.2f, 0.2f);
		glDrawArrays(GL_TRIANGLES, 0, 12*3);
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
	if (pen) {
		free(pen);
	}
	[plate release];
		
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
