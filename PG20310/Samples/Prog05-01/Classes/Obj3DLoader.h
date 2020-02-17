//
//  Obj3DLoader.h
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Obj3D.h"

typedef enum {
	OET_NONE,
	OET_OBJECT,
	OET_OBJECT_END,
	OET_MATRIX,
	OET_MATRIX_END,
	OET_MESHES,
	OET_MESHES_END,
	OET_MESHFILE,
	OET_MESHFILE_END,
	OET_OBJFILE,
	OET_OBJFILE_END,
	OET_CHILDREN,
	OET_CHILDREN_END,
	OET_ERROR
} OBJELEMTYPE;

@interface Obj3DLoader : NSObject <NSXMLParserDelegate> {
	OBJELEMTYPE currOET;
	Obj3D *rootObj;
	Obj3D *currObj;
}

- (Obj3D *)load:(NSString *)filename;

@end
