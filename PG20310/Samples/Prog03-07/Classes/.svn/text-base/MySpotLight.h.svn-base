//
//  MySpotLight.h
//  Prog03-07
//
//  Created by SAKAI Yuji on 09/10/31.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface MySpotLight : NSObject {
	GLenum lightID;
	GLfloat lightAmbient[4];
	GLfloat lightDiffuse[4];
	GLfloat lightSpecular[4];
	GLfloat lightPosition[4];
	GLfloat lightSpotDirection[3];
	GLfloat lightSpotExponent;
	GLfloat lightSpotCutoff;
	GLfloat constantAttenuation;
	GLfloat linearAttenuation;
	GLfloat quadraticAttenuation;
	GLfloat param0;
	GLfloat param1;
	GLfloat param2;
}
@property (nonatomic) GLfloat lightSpotExponent;
@property (nonatomic) GLfloat lightSpotCutoff;
@property (nonatomic) GLfloat constantAttenuation;
@property (nonatomic) GLfloat linearAttenuation;
@property (nonatomic) GLfloat quadraticAttenuation;
@property (nonatomic) GLfloat param0;
@property (nonatomic) GLfloat param1;
@property (nonatomic) GLfloat param2;

- (id)initWithLight:(GLenum)theLightID;

- (GLfloat *)getAmbientPtr;
- (void)setAmbient:(GLfloat *)ambient;
- (GLfloat *)getDiffusePtr;
- (void)setDiffuse:(GLfloat *)diffuse;
- (GLfloat *)getSpecularPtr;
- (void)setSpecular:(GLfloat *)specular;
- (GLfloat *)getPositionPtr;
- (void)setPosition:(GLfloat *)position;
- (GLfloat *)getSpotDirectionPtr;
- (void)setSpotDirection:(GLfloat *)direction;

- (void)rotateColor;
- (void)doGlLight;

@end
