//
//  AnimPlayer.h
//  Prog07-01
//
//  Created by SAKAI Yuji on 10/01/25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Animation.h"


@interface AnimPlayer : NSObject {
	BOOL play;
	float currTime;
	float lastTime;
	Animation *anim;
}
@property (nonatomic) BOOL play;
@property (nonatomic) float currTime;
@property (nonatomic) float lastTime;
@property (nonatomic, retain) Animation *anim;

- (void)doPlay:(float)elapsedTime;

@end
