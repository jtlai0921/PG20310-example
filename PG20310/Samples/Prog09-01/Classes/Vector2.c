/*
 *  Vector2.c
 *  Prog09-01
 *
 *  Created by SAKAI Yuji on 10/03/20.
 *  Copyright 2010 Apple Inc. All rights reserved.
 *
 */

#include "Vector2.h"
#include <float.h>
#include <math.h>

void setVector2(Vector2 *pv, GLfloat _x, GLfloat _y)
{
	pv->x = _x;
	pv->y = _y;
}

void setVector2FromCGPoint(Vector2 *pv, const CGPoint *pp)
{
	pv->x = pp->x;
	pv->y = pp->y;
}

GLfloat getLengthVector2(const Vector2 *pv)
{
	GLfloat len;
	len = pv->x * pv->x + pv->y * pv->y;
	if (len > FLT_EPSILON) {
		len = sqrtf(len);
		return len;
	} else {
		return 0.0f;
	}
}

void normalizeVector2(Vector2 *pv)
{
	GLfloat len;
	len = getLengthVector2(pv);
	if (len != 1.0f) {
		pv->x /= len;
		pv->y /= len;
	}
}

GLfloat dotVector2(const Vector2 *pv1, const Vector2 *pv2)
{
	return pv1->x * pv2->x + pv1->y * pv2->y;
}

