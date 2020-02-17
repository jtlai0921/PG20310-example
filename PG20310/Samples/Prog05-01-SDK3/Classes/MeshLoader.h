//
//  MeshLoader.h
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Mesh.h"

typedef enum {
	MET_NONE,
	MET_MESH,
	MET_MESH_END,
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

@interface MeshLoader : NSObject {
	MESHELEMTYPE currMet;
	int counter;
	Mesh *currMesh;
}

- (Mesh *)load:(NSString *)filename;

@end
