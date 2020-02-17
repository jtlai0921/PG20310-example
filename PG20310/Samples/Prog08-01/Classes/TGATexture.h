//
//  TGATexture.h
//  Prog08-01
//
//  Created by SAKAI Yuji on 10/02/16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>


@interface TGATexture : NSObject {
	GLvoid *texBuffer;
	GLsizei width;
	GLsizei height;
	GLenum name;
}
@property (nonatomic, readonly) GLenum name;

- (id)initWithFilename:(NSString *)filename;

- (BOOL)load:(NSString *)filename;

@end
