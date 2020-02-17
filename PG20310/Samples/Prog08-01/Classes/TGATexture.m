//
//  TGATexture.m
//  Prog08-01
//
//  Created by SAKAI Yuji on 10/02/16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TGATexture.h"
#import "TGA.h"

#pragma pack(push, GLTEXPIXEL32, 1)
typedef struct {
	unsigned char r, g, b, a;
} GLTexPixel32;
#pragma pack(pop, GLTEXPIXEL32)

@implementation TGATexture

@synthesize name;

- (id)initWithFilename:(NSString *)filename
{
	self = [super init];
	if (self) {
		BOOL res;
		res = [self load:filename];
	}
	return self;
}

- (void)dealloc
{
	if (name != GL_INVALID_VALUE) {
		glDeleteTextures(1, &name);
	}
	if (texBuffer) {
		free(texBuffer);
	}
	[super dealloc];
}

- (BOOL)load:(NSString *)filename
{
	NSString *path;
	path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], filename];
	NSFileHandle *fh;
	fh = [NSFileHandle fileHandleForReadingAtPath:path];
	if (fh == nil) {
		return NO;
	}
	unsigned long long offset, filesize;
	filesize = offset = [fh seekToEndOfFile];
	offset -= sizeof(TGAFileFooter);
	[fh seekToFileOffset:offset];
	TGAFileFooter *footer;
	NSData *data;
	data = [fh readDataOfLength:sizeof(TGAFileFooter)];
	footer = (TGAFileFooter *)[data bytes];
	if (strcmp(footer->signature, "TRUEVISION-XFILE.") != 0) {
		return NO;
	}
	[fh seekToFileOffset:0];
	data = [fh readDataOfLength:sizeof(TGAFileHeader)];
	TGAFileHeader *header;
	header = (TGAFileHeader *)[data bytes];
	offset = sizeof(TGAFileHeader);
	offset += header->idLength;
	if (header->colorMapType != 0) {
		return NO;
	}
	if (header->imageType != 2) {
		return NO;
	}
	// 
	[fh seekToFileOffset:offset];
	unsigned long imgSize;
	imgSize = header->imgSpec.imageWidth * header->imgSpec.imageHeight * (header->imgSpec.imageDepth >> 3);
	if (imgSize == 0) {
		return NO;
	}
	data = [fh readDataOfLength:imgSize];
	TGAPixel32 *tgaPixel;
	tgaPixel = (TGAPixel32 *)[data bytes];
	unsigned char imgOrigin;
	imgOrigin = ((header->imgSpec.imageDesc & 0x30) >> 4);
	if (imgOrigin == 0) {
		// Bottom Left
		texBuffer = (GLvoid *)malloc(header->imgSpec.imageWidth * header->imgSpec.imageHeight * sizeof(GLTexPixel32));
		if (texBuffer == NULL) {
			return NO;
		}
		width = header->imgSpec.imageWidth;
		height = header->imgSpec.imageHeight;
		GLTexPixel32 *texPixel;
		for (int y = height - 1; y >= 0; y--) {
			texPixel = (GLTexPixel32 *)(((unsigned long)texBuffer) + y * width * sizeof(GLTexPixel32));
			for (int x = 0; x < width; x++) {
				texPixel->a = tgaPixel->a;
				texPixel->r = tgaPixel->r;
				texPixel->g = tgaPixel->g;
				texPixel->b = tgaPixel->b;
				texPixel++;
				tgaPixel++;
			}
		}
	} else if (imgOrigin == 2) {
		// Top Left
		texBuffer = (GLvoid *)malloc(header->imgSpec.imageWidth * header->imgSpec.imageHeight * sizeof(GLTexPixel32));
		if (texBuffer == NULL) {
			return NO;
		}
		width = header->imgSpec.imageWidth;
		height = header->imgSpec.imageHeight;
		GLTexPixel32 *texPixel = (GLTexPixel32 *)texBuffer;
		for (unsigned long i = 0; i < width * height; i++) {
			texPixel->a = tgaPixel->a;
			texPixel->r = tgaPixel->r;
			texPixel->g = tgaPixel->g;
			texPixel->b = tgaPixel->b;
			texPixel++;
			tgaPixel++;
		}
	} else {
		// NOT SUPPORT
		return NO;
	}
	// Setting for OpenGL Texture
	glGenTextures(1, &name);
	if (name == GL_INVALID_VALUE) {
		free(texBuffer);
		texBuffer = NULL;
		return NO;
	}
	GLint saveName;
	glGetIntegerv(GL_TEXTURE_BINDING_2D, &saveName);
	glBindTexture(GL_TEXTURE_2D, name);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, texBuffer);
	glBindTexture(GL_TEXTURE_2D, saveName);
	
	return YES;
}

@end
