//
//  Mesh.h
//  Prog04-01
//
//  Created by SAKAI Yuji on 09/11/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Elem3D.h"

#define MATERIAL_AMBIENT_FLAG	(1<<0)
#define MATERIAL_DIFFUSE_FLAG	(1<<1)
#define MATERIAL_SPECULAR_FLAG	(1<<2)
#define MATERIAL_EMISSION_FLAG	(1<<3)
#define MATERIAL_SHININESS_FLAG	(1<<4)

@interface Mesh : Elem3D {
	int numVertices;
	Vector3 *vertices;
	Vector3 *normals;
	Vector2 *texCoords;
	int numIndices;
	GLushort *indices;
	unsigned int flagMaterial;
	Material mat;
	Texture2D *tex;
}
@property (nonatomic) int numVertices;
@property (nonatomic) Vector3 *vertices;
@property (nonatomic) Vector3 *normals;
@property (nonatomic) Vector2 *texCoords;
@property (nonatomic) int numIndices;
@property (nonatomic) GLushort *indices;
@property (nonatomic) unsigned int flagMaterial;
@property (nonatomic) Material mat;
@property (nonatomic, retain) Texture2D *tex;

- (Material *)getMaterialPtr;

- (void)render;

@end
