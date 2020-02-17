/*
 *  Matrix.h
 *  Prog07-02
 *
 *  Created by SAKAI Yuji on 10/02/05.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

typedef struct {
	float yaw;
	float pitch;
	float roll;
} YawPitchRoll;

typedef struct {
	GLfloat m[16];
} Matrix;

#define MatrixCalcIndex(row, col)	(col * 4 + row)

#if 0
inline int MatrixCalcIndex(int row, int col)
{
	return (col * 4 + row);
}
#endif

void MatrixIdentity(Matrix *pmat);
void MatrixMutiply(Matrix *pMatRes, const Matrix *pmatA, const Matrix *pmatB);
void MatrixRotateX(Matrix *pmat, float deg);
void MatrixRotateY(Matrix *pmat, float deg);
void MatrixRotateZ(Matrix *pmat, float deg);
void MatrixYawPitchRoll(Matrix *pmat, YawPitchRoll *ypr);

