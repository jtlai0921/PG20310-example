//
//  AnimYawPitchRollKey.h
//  Prog07-02
//
//  Created by SAKAI Yuji on 10/02/06.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimKey.h"

@interface AnimYawPitchRollKey : AnimKey {
	YawPitchRoll ypr;
}
@property (nonatomic) YawPitchRoll ypr;

+ (YawPitchRoll)interpolate:(float)tm withA:(AnimYawPitchRollKey *)a andB:(AnimYawPitchRollKey *)b;

- (id)initWithTime:(float)tm;

@end
