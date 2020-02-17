//
//  Camera.h
//  Prog06-02
//
//  Created by SAKAI Yuji on 10/01/08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Elem3D.h"


@interface Camera : Elem3D {
	BOOL active;
	GLfloat angle;
	GLfloat aspect;
	GLfloat near;
	GLfloat far;
	Vector3 eye;
	Vector3 lookAt;
	Vector3 up;
}
@property (nonatomic) BOOL active;
@property (nonatomic) GLfloat angle;
@property (nonatomic) GLfloat aspect;
@property (nonatomic) GLfloat near;
@property (nonatomic) GLfloat far;
@property (nonatomic) Vector3 eye;
@property (nonatomic) Vector3 lookAt;
@property (nonatomic) Vector3 up;

- (void)preRender:(float)elapsedTime;

@end
