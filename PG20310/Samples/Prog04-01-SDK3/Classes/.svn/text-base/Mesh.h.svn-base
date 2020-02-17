//
//  Mesh.h
//  Prog04-01
//
//  Created by SAKAI Yuji on 09/11/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import "Texture2D.h"

typedef enum {
	MET_NONE,
	MET_NUMVERTICES,
	MET_NUMVERTICES_END,
	MET_VERTICES,
	MET_VERTICES_VECTOR3,
	MET_VERTICES_VECTOR3_END,
	MET_VERTICES_END,
	MET_NORMALS,
	MET_NORMALS_VECTOR3,
	MET_NORMALS_VECTOR3_END,
	MET_NORMALS_END,
	MET_TEXCOORDS,
	MET_TEXCOORDS_VECTOR2,
	MET_TEXCOORDS_VECTOR2_END,
	MET_TEXCOORDS_END,
	MET_INDICES,
	MET_INDICES_END,
	MET_MATERIAL,
	MET_MATERIAL_AMBIENT,
	MET_MATERIAL_AMBIENT_END,
	MET_MATERIAL_DIFFUSE,
	MET_MATERIAL_DIFFUSE_END,
	MET_MATERIAL_SPECULAR,
	MET_MATERIAL_SPECULAR_END,
	MET_MATERIAL_EMISSION,
	MET_MATERIAL_EMISSION_END,
	MET_MATERIAL_SHININESS,
	MET_MATERIAL_SHININESS_END,
	MET_MATERIAL_END,
	MET_TEXTURE,
	MET_TEXTURE_END,
	MET_END,
	MET_ERROR
} MESHELEMTYPE;

#define MATERIAL_AMBIENT_FLAG	(1<<0)
#define MATERIAL_DIFFUSE_FLAG	(1<<1)
#define MATERIAL_SPECULAR_FLAG	(1<<2)
#define MATERIAL_EMISSION_FLAG	(1<<3)
#define MATERIAL_SHININESS_FLAG	(1<<4)

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

@interface Mesh : NSObject {
	int numVertices;
	Vector3 *vertices;
	Vector3 *normals;
	Vector2 *texCoords;
	int numIndices;
	GLushort *indices;
	unsigned int flagMaterial;
	Material mat;
	Texture2D *tex;
	
	// ---- parser用 ----
	MESHELEMTYPE currMet;
	int counter;
}

- (BOOL)load:(NSString *)filename;
- (void)render;

@end
