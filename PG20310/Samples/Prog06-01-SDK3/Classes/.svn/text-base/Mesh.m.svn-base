//
//  Mesh.m
//  Prog04-01
//
//  Created by SAKAI Yuji on 09/11/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Mesh.h"


@implementation Mesh

@synthesize numVertices;
@synthesize vertices;
@synthesize normals;
@synthesize texCoords;
@synthesize numIndices;
@synthesize indices;
@synthesize flagMaterial;
@synthesize mat;
@synthesize tex;

- (Material *)getMaterialPtr
{
	return &mat;
}

- (void)render
{
	if (vertices) {
		glVertexPointer(3, GL_FLOAT, 0, vertices);
		glEnableClientState(GL_VERTEX_ARRAY);
	}
	if (normals) {
		glNormalPointer(GL_FLOAT, 0, normals);
		glEnableClientState(GL_NORMAL_ARRAY);
	}
	if (texCoords) {
		glTexCoordPointer(2, GL_FLOAT, 0, texCoords);
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	}
	if (tex) {
		glEnable(GL_TEXTURE_2D);
		glEnable(GL_BLEND);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glBindTexture(GL_TEXTURE_2D, tex.name);
	} else {
		/*
		glEnable(GL_TEXTURE_2D);
		glEnable(GL_BLEND);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		 */
		glBindTexture(GL_TEXTURE_2D, 0);
	}
	if (flagMaterial) {
		if (flagMaterial & MATERIAL_AMBIENT_FLAG) {
			glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, (GLfloat *)&mat.ambient);
		}
		if (flagMaterial & MATERIAL_DIFFUSE_FLAG) {
			glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, (GLfloat *)&mat.diffuse);
		}
		if (flagMaterial & MATERIAL_SPECULAR_FLAG) {
			glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, (GLfloat *)&mat.specular);
		}
		if (flagMaterial & MATERIAL_EMISSION_FLAG) {
			glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, (GLfloat *)&mat.emission);
		}
		if (flagMaterial & MATERIAL_SHININESS_FLAG) {
			glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, (GLfloat *)&mat.shininess);
		}
	}
	if (indices) {
		glDrawElements(GL_TRIANGLES, numIndices, GL_UNSIGNED_SHORT, indices);
	} else {
		glDrawArrays(GL_TRIANGLES, 0, numVertices);
	}
}

@end
