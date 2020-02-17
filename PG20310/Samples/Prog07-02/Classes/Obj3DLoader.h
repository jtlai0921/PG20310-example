//
//  Obj3DLoader.h
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Loader.h"
#import "Obj3D.h"

typedef enum {
	OET_NONE,
	OET_OBJECT,
	OET_OBJECT_END,
	OET_MATRIX,
	OET_MATRIX_END,
	// <animfile>
	OET_ANIMFILE,
	OET_ANIMFILE_END,
	OET_MESHES,
	OET_MESHES_END,
	OET_MESHFILE,
	OET_MESHFILE_END,
	// <light>
	OET_LIGHT,
	OET_LIGHT_END,
	OET_LIGHT_COLOR,
	OET_LIGHT_COLOR_END,
	OET_LIGHT_COLOR_AMBIENT,
	OET_LIGHT_COLOR_AMBIENT_END,
	OET_LIGHT_COLOR_DIFFUSE,
	OET_LIGHT_COLOR_DIFFUSE_END,
	OET_LIGHT_COLOR_SPECULAR,
	OET_LIGHT_COLOR_SPECULAR_END,
	OET_LIGHT_POSITION,
	OET_LIGHT_POSITION_END,
	OET_LIGHT_SPOT,
	OET_LIGHT_SPOT_END,
	OET_LIGHT_SPOT_DIRECTION,
	OET_LIGHT_SPOT_DIRECTION_END,
	OET_LIGHT_SPOT_EXPONENT,
	OET_LIGHT_SPOT_EXPONENT_END,
	OET_LIGHT_SPOT_CUTOFF,
	OET_LIGHT_SPOT_CUTOFF_END,
	// <camera>
	OET_CAMERA,
	OET_CAMERA_END,
	OET_CAMERA_ANGLE,
	OET_CAMERA_ANGLE_END,
	OET_CAMERA_ASPECT,
	OET_CAMERA_ASPECT_END,
	OET_CAMERA_NEAR,
	OET_CAMERA_NEAR_END,
	OET_CAMERA_FAR,
	OET_CAMERA_FAR_END,
	OET_CAMERA_EYE,
	OET_CAMERA_EYE_END,
	OET_CAMERA_LOOKAT,
	OET_CAMERA_LOOKAT_END,
	OET_CAMERA_UP,
	OET_CAMERA_UP_END,
	OET_OBJFILE,
	OET_OBJFILE_END,
	OET_CHILDREN,
	OET_CHILDREN_END,
	OET_ERROR
} OBJELEMTYPE;

@interface Obj3DLoader : Loader <NSXMLParserDelegate> {
	OBJELEMTYPE currOET;
	Obj3D *rootObj;
	Obj3D *currObj;
	Light *currLight;
	Camera *currCam;
	Camera *activeCam;
}
@property (nonatomic, readonly) Camera *activeCam;

- (Obj3D *)load:(NSString *)filename;

@end