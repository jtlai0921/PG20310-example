//
//  Animation.h
//  Prog07-01
//
//  Created by SAKAI Yuji on 10/01/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Elem3D.h"
#import "AnimKey.h"

@class Obj3D;

#define VALID_KEY_A	(1)
#define VALID_KEY_B	(1<<1)

@interface Animation : Elem3D {
	BOOL loop;
	NSMutableArray *keys;
	Matrix *objMatPtr;
	Matrix orgMat;
}
@property (nonatomic) BOOL loop;
@property (nonatomic, readonly) Matrix *objMatPtr;
@property (nonatomic, readonly) Matrix orgMat;

- (void)addKey:(AnimKey *)key;
- (int)getKeyAtTime:(float)tm withA:(AnimKey **)keyA andB:(AnimKey **)keyB;
- (float)lastTime;
- (void)saveMatrix:(Obj3D *)obj;

@end
