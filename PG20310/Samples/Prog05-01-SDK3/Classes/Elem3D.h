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

typedef struct {
	GLfloat u, v;
} Vector2;

typedef struct {
	GLfloat x, y, z;
} Vector3;

typedef struct {
	GLfloat r, g, b, a;
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

@interface Elem3D : NSObject {
	NSString *name;
	Elem3D *parent;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) Elem3D *parent;

- (id)initWithParent:(Elem3D *)prnt;

- (void)render;

@end
