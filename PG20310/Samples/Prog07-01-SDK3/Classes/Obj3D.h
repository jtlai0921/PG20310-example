//
//  Obj3D.h
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/22.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Mesh.h"
#import "Light.h"
#import "Camera.h"
#import "AnimPlayer.h"

@interface Obj3D : Elem3D {
	Matrix mat;
	AnimPlayer *animPlayer;
	NSMutableArray *meshes;
	NSMutableArray *prerenders;
	NSMutableArray *children;
}

- (id)initWithParent:(Elem3D *)prnt;

- (void)matrixIdentity;
- (Matrix *)getMatrixPtr;

- (Camera *)searchCamera:(int)index withCounter:(int *)counter;

- (void)addMesh:(Mesh *)mesh;
- (void)addLight:(Light *)light;
- (void)addCamera:(Camera *)cam;
- (void)addChild:(Obj3D *)child;
- (void)setAnimation:(Animation *)anm;

@end
