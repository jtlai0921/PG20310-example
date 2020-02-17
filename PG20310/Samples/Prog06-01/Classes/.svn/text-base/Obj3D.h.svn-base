//
//  Obj3D.h
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/22.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Mesh.h"
#import "Light.h"

@interface Obj3D : Elem3D {
	Matrix mat;
	NSMutableArray *meshes;
	NSMutableArray *lights;
	NSMutableArray *children;
}

- (id)initWithParent:(Elem3D *)prnt;

- (void)matrixIdentity;
- (Matrix *)getMatrixPtr;

- (void)addMesh:(Mesh *)mesh;
- (void)addLight:(Light *)light;
- (void)addChild:(Obj3D *)child;

- (void)preRender;
- (void)render;

@end
