//
//  Elem3D.h
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/22.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import "Texture2D.h"

typedef union {
	struct { GLfloat u, v; } uv;
	GLfloat f[2];
} Vector2;

typedef union {
	struct { GLfloat x, y, z; } v;
	GLfloat f[3];
} Vector3;

typedef union {
	struct { GLfloat x, y, z, w; } v;
	GLfloat f[4];
} Vector4;

typedef union {
	struct { GLfloat r, g, b, a; } c;
	GLfloat f[4];
} RGBA;

typedef struct {
	RGBA ambient;
	RGBA diffuse;
	RGBA specular;
	RGBA emission;
	GLfloat shininess;
} Material;

typedef struct {
	GLfloat m[16];
} Matrix;

@class Camera;

@interface Elem3D : NSObject {
	NSString *name;
	Elem3D *parent;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) Elem3D *parent;

- (id)initWithParent:(Elem3D *)prnt;

- (Camera *)searchCamera:(int)index withCounter:(int *)counter;

- (void)preRender:(float)elapsedTime;
- (void)render;

@end
