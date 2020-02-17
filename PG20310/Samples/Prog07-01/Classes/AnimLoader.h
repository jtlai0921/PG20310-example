//
//  AnimLoader.h
//  Prog07-01
//
//  Created by SAKAI Yuji on 10/01/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Loader.h"
#import "Animation.h"
#import "AnimKey.h"

typedef enum {
	AET_NONE,
	AET_ANIMATION,
	AET_ANIMATION_END,
	AET_ANIMKEY,
	AET_ANIMKEY_END,
	AET_ERROR
} ANIMELEMTYPE;

@interface AnimLoader : Loader <NSXMLParserDelegate> {
	ANIMELEMTYPE currAET;
	Animation *anim;
	ANIMKEY_TYPE currAnimKeyType;
	AnimKey *currAnimKey;
}

- (Animation *)load:(NSString *)filename;

@end
