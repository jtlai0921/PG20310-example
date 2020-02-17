/*
 *  Vector2.h
 *  Prog09-01
 *
 *  Created by SAKAI Yuji on 10/03/20.
 *  Copyright 2010 Apple Inc. All rights reserved.
 *
 */

#import <CoreGraphics/CoreGraphics.h>
#import <OpenGLES/ES1/gl.h>

typedef struct {
	GLfloat x, y;
} Vector2;

void setVector2(Vector2 *pv, GLfloat _x, GLfloat _y);
void setVector2FromCGPoint(Vector2 *pv, const CGPoint *pp);
GLfloat getLengthVector2(const Vector2 *pv);
void normalizeVector2(Vector2 *pv);
GLfloat dotVector2(const Vector2 *pv1, const Vector2 *pv2);
