//
//  MySpotLight.m
//  Prog03-07
//
//  Created by SAKAI Yuji on 09/10/31.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MySpotLight.h"


@implementation MySpotLight

@synthesize lightSpotExponent;
@synthesize lightSpotCutoff;
@synthesize constantAttenuation;
@synthesize linearAttenuation;
@synthesize quadraticAttenuation;
@synthesize param0;
@synthesize param1;
@synthesize param2;

- (id)initWithLight:(GLenum)theLightID {
	self = [super init];
	if (self) {
		lightID = theLightID;
		lightAmbient[0] = 0.2f;
		lightAmbient[1] = 0.2f;
		lightAmbient[2] = 0.2f;
		lightAmbient[3] = 1.0f;
		lightDiffuse[0] = 0.8f;
		lightDiffuse[1] = 0.8f;
		lightDiffuse[2] = 0.8f;
		lightDiffuse[3] = 1.0f;
		lightSpecular[0] = 1.0f;
		lightSpecular[1] = 1.0f;
		lightSpecular[2] = 1.0f;
		lightSpecular[3] = 1.0f;
		lightPosition[0] = 0.0f;
		lightPosition[1] = 0.0f;
		lightPosition[2] = 0.0f;
		lightPosition[3] = 1.0f;
		lightSpotDirection[0] = 0.0f;
		lightSpotDirection[1] = 0.0f;
		lightSpotDirection[2] = 1.0f;
		lightSpotExponent = 24;
		lightSpotCutoff = 30.0f;
		constantAttenuation = 0.1f;
		linearAttenuation = 0.1f;
		quadraticAttenuation = 0.1f;
		param0 = 0.0f;
		param1 = 0.0f;
		param2 = 0.0f;
	}
	return self;
}

- (GLfloat *)getAmbientPtr {
	return lightAmbient;
}

- (void)setAmbient:(GLfloat *)ambient {
	for (int i = 0; i < 4; i++) {
		lightAmbient[i] = ambient[i];
	}
}

- (GLfloat *)getDiffusePtr {
	return lightDiffuse;
}

- (void)setDiffuse:(GLfloat *)diffuse {
	for (int i = 0; i < 4; i++) {
		lightDiffuse[i] = diffuse[i];
	}
}

- (GLfloat *)getSpecularPtr {
	return lightSpecular;
}

- (void)setSpecular:(GLfloat *)specular {
	for (int i = 0; i < 4; i++) {
		lightSpecular[i] = specular[i];
	}
}

- (GLfloat *)getPositionPtr {
	return lightPosition;
}

- (void)setPosition:(GLfloat *)position {
	for (int i = 0; i < 4; i++) {
		lightPosition[i] = position[i];
	}
}

- (GLfloat *)getSpotDirectionPtr {
	return lightSpotDirection;
}

- (void)setSpotDirection:(GLfloat *)direction {
	for (int i = 0; i < 3; i++) {
		lightSpotDirection[i] = direction[i];
	}
}

- (void)rotateColor {
	param0 += 0.03f;
	param1 += 0.03f;
	param2 += 0.03f;
	if (param0 >= 360.0f) {
		param0 -= 360.0f;
	}
	if (param1 >= 360.0f) {
		param1 -= 360.0f;
	}
	if (param2 >= 360.0f) {
		param2 -= 360.0f;
	}
	lightDiffuse[0] = 0.5f + sinf(param0) * 0.4f;
	lightDiffuse[1] = 0.5f + sinf(param1) * 0.4f;
	lightDiffuse[2] = 0.5f + sinf(param2) * 0.4f;
}

- (void)doGlLight {
	glEnable(lightID);
	glLightfv(lightID, GL_AMBIENT, lightAmbient);
	glLightfv(lightID, GL_DIFFUSE, lightDiffuse);
	glLightfv(lightID, GL_SPECULAR, lightSpecular);
	glLightfv(lightID, GL_POSITION, lightPosition);
	glLightfv(lightID, GL_SPOT_DIRECTION, lightSpotDirection);
	glLightf(lightID, GL_SPOT_EXPONENT, lightSpotExponent);
	glLightf(lightID, GL_SPOT_CUTOFF, lightSpotCutoff);
	glLightf(lightID, GL_CONSTANT_ATTENUATION, constantAttenuation);
	glLightf(lightID, GL_LINEAR_ATTENUATION, linearAttenuation);
	glLightf(lightID, GL_QUADRATIC_ATTENUATION, quadraticAttenuation);
}

@end
