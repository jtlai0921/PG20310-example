/*
 *  Matrix.c
 *  Prog07-02
 *
 *  Created by SAKAI Yuji on 10/02/05.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#include "Matrix.h"
#include <math.h>

#define PI (3.141592)

void MatrixIdentity(Matrix *pmat)
{
	int i = 0;
	for (int x = 0; x < 4; x++) {
		for (int y = 0; y < 4; y++) {
			if (x == y) {
				pmat->m[i] = 1.0f;
			} else {
				pmat->m[i] = 0.0f;
			}
			i++;
		}
	}
}

void MatrixMutiply(Matrix *pMatRes, const Matrix *pmatA, const Matrix *pmatB)
{
	Matrix mat;
	for (int y = 0; y < 4; y++) {
		for (int x = 0; x < 4; x++) {
			int i = MatrixCalcIndex(y, x);
			float val = 0.0f;
			for (int n = 0; n < 4; n++) {
				int i1, i2;
				i1 = MatrixCalcIndex(y, n);
				i2 = MatrixCalcIndex(n, x);
				val += pmatA->m[i1] * pmatB->m[i2];
			}
			mat.m[i] = val;
		}
	}
	*pMatRes = mat;
}

void MatrixRotateX(Matrix *pmat, float deg)
{
	float c, s;
	c = cos(deg * PI / 180.0);
	s = sin(deg * PI / 180.0);
	MatrixIdentity(pmat);
	pmat->m[MatrixCalcIndex(1, 1)] = c;
	pmat->m[MatrixCalcIndex(2, 2)] = c;
	pmat->m[MatrixCalcIndex(1, 2)] = -s;
	pmat->m[MatrixCalcIndex(2, 1)] = s;
}

void MatrixRotateY(Matrix *pmat, float deg)
{
	float c, s;
	c = cos(deg * PI / 180.0);
	s = sin(deg * PI / 180.0);
	MatrixIdentity(pmat);
	pmat->m[MatrixCalcIndex(0, 0)] = c;
	pmat->m[MatrixCalcIndex(2, 2)] = c;
	pmat->m[MatrixCalcIndex(0, 2)] = s;
	pmat->m[MatrixCalcIndex(2, 0)] = -s;
}

void MatrixRotateZ(Matrix *pmat, float deg)
{
	float c, s;
	c = cos(deg * PI / 180.0);
	s = sin(deg * PI / 180.0);
	MatrixIdentity(pmat);
	pmat->m[MatrixCalcIndex(0, 0)] = c;
	pmat->m[MatrixCalcIndex(1, 1)] = c;
	pmat->m[MatrixCalcIndex(0, 1)] = -s;
	pmat->m[MatrixCalcIndex(1, 0)] = s;
}

void MatrixYawPitchRoll(Matrix *pmat, YawPitchRoll *ypr)
{
	Matrix mat, temp;
	MatrixRotateY(&mat, ypr->yaw);
	MatrixRotateX(&temp, ypr->pitch);
	MatrixMutiply(&mat, &mat, &temp);
	MatrixRotateZ(&temp, ypr->roll);
	MatrixMutiply(&mat, &mat, &temp);
	*pmat = mat;
}

