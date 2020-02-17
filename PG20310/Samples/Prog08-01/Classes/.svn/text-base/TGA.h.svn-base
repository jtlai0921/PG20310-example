/*
 *  TGA.h
 *  Prog08-01
 *
 *  Created by SAKAI Yuji on 10/02/16.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#pragma pack(push, TGA_HEADER, 1)
typedef struct {
    unsigned short firstEntryIndex;
    unsigned short colorMapLength;
    unsigned char  colorMapEntrySize;
} TGAColorMapSpec;

typedef struct {
    unsigned short xOriginOfImage;
    unsigned short yOriginOfImage;
    unsigned short imageWidth;
    unsigned short imageHeight;
    unsigned char  imageDepth;
    unsigned char  imageDesc;
} TGAImageSpec;

typedef struct {
    unsigned char   idLength;
    unsigned char   colorMapType;
    unsigned char   imageType;
    TGAColorMapSpec colorMapSpec;
    TGAImageSpec    imgSpec;
} TGAFileHeader;

typedef struct {
    unsigned char r;
    unsigned char g;
    unsigned char b;
    unsigned char a;
} TGAPixel32;

typedef struct {
    unsigned long extensionAreaOffset;
    unsigned long developerDirectoryOffset;
    char signature[18];
} TGAFileFooter;
#pragma pack(pop, TGA_HEADER)
