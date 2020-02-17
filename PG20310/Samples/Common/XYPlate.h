//
//  XYPlate.h
//  Prog03-04
//
//  Created by SAKAI Yuji on 09/10/21.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>


typedef struct {
	GLfloat x, y, z;
} Vector3;

@interface XYPlate : NSObject {
	Vector3 *vertices;
	Vector3 *normals;
	int width;
	int height;
	GLfloat deltaHalf;
}

- (id)initWithWidth:(int)w andHeight:(int)h andDeltaHalf:(GLfloat)dh;
- (void)render;

@end
