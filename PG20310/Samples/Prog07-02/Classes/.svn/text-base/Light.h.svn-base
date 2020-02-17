//
//  Light.h
//  Prog06-01
//
//  Created by SAKAI Yuji on 10/01/06.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Elem3D.h"

#define BAD_LIGHT_INDEX	(-1)

typedef enum {
	LT_NONE,
	LT_DIRECTIONAL,
	LT_POINT,
	LT_SPOT
} LIGHT_TYPE;

@interface Light : Elem3D {
	int lightIndex;
	LIGHT_TYPE ltype;
	RGBA ambient;
	RGBA diffuse;
	RGBA specular;
	Vector4 position;
	Vector3 direction;
	GLfloat exponent;
	GLfloat cutoff;
}
@property (nonatomic) LIGHT_TYPE ltype;
@property (nonatomic) RGBA ambient;
@property (nonatomic) RGBA diffuse;
@property (nonatomic) RGBA specular;
@property (nonatomic) Vector4 position;
@property (nonatomic) Vector3 direction;
@property (nonatomic) GLfloat exponent;
@property (nonatomic) GLfloat cutoff;

+ (int)searchLightId;

- (id)initWithParent:(Elem3D *)prnt;

- (GLenum)getLightId;

@end
