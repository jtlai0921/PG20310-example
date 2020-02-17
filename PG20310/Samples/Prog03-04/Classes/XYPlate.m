//
//  XYPlate.m
//  Prog03-04
//
//  Created by SAKAI Yuji on 09/10/21.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "XYPlate.h"

#define XYPLATE_Z_VAL	(0.0f)

const GLfloat plateAmbient[] = { 0.2f, 0.2f, 0.2f, 1.0f };
const GLfloat plateMaterial[] = { 1.0f, 1.0f, 0.0f, 1.0f };
const GLfloat plateEmission[] = { 0.0f, 0.0f, 0.0f, 1.0f };
const GLfloat plateSpecular[] = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat plateShiness[] = { 32.0f };

@implementation XYPlate

- (id)initWithWidth:(int)w andHeight:(int)h andDeltaHalf:(GLfloat)dh
{
	self = [super init];
	if (self) {
		width = w - 1;
		height = h - 1;
		deltaHalf = dh;
		vertices = malloc(sizeof(Vector3) * (height + 1) * 2);
		normals = malloc(sizeof(Vector3) * (height + 1) * 2);
		int index = 0;
		GLfloat yval = deltaHalf * height;
		for (int y = 0; y <= height; y++) {
			vertices[index].x = -deltaHalf;
			vertices[index].y = yval;
			vertices[index].z = XYPLATE_Z_VAL;
			normals[index].x = 0.0f;
			normals[index].y = 0.0f;
			normals[index].z = -1.0f;
			index++;
			vertices[index].x = deltaHalf;
			vertices[index].y = yval;
			vertices[index].z = XYPLATE_Z_VAL;
			normals[index].x = 0.0f;
			normals[index].y = 0.0f;
			normals[index].z = -1.0f;
			index++;
			yval -= deltaHalf * 2.0f;
		}
	}
	return self;
}

- (void)render
{
    glVertexPointer(3, GL_FLOAT, 0, vertices);
    glEnableClientState(GL_VERTEX_ARRAY);
    glNormalPointer(GL_FLOAT, 0, normals);
    glEnableClientState(GL_NORMAL_ARRAY);
	
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, plateAmbient);
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, plateMaterial);
	glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, plateEmission);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, plateSpecular);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SHININESS, plateShiness);
	
	glPushMatrix();
	{
		glTranslatef(deltaHalf * (width - 1), 0.0f, 0.0f);
		for (int x = 0; x < width; x++) {
			glDrawArrays(GL_TRIANGLE_STRIP, 0, (height + 1) * 2);
			glTranslatef(-deltaHalf * 2, 0.0f, 0.0f);
		}
	}
	glPopMatrix();
}

- (void)dealloc
{
	if (vertices) {
		free(vertices);
		vertices = NULL;
	}
	if (normals) {
		free(normals);
		normals = NULL;
	}
	[super dealloc];
}

@end
