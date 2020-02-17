//
//  ESRenderer.h
//  Prog09-01
//
//  Created by SAKAI Yuji on 10/03/20.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>

@protocol ESRenderer <NSObject>

- (void)render;
- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer;
// ëÄçÏópìIï˚ñ@
- (float)getBaseRot;
- (void)setBaseRot:(float)brot;
- (float)getArmParam;
- (void)setArmParam:(float)arm;
- (float)getPalmParam;
- (void)setPalmParam:(float)palm;
- (float)getFingerParam;
- (void)setFingerParam:(float)finger;

@end
