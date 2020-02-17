//
//  EAGLView.m
//  Prog02-01
//
//  Created by SAKAI Yuji on 10/03/11.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "EAGLView.h"

#import "ES1Renderer.h"
#import "ES2Renderer.h"

#import "Vector2.h"

#define DEBUG_LOG

@implementation EAGLView

@synthesize animating;
@dynamic animationFrameInterval;

// You must implement this method
+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

//The EAGL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder
{    
    if ((self = [super initWithCoder:coder]))
    {
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;

        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];

        renderer = [[ES2Renderer alloc] init];
#if 0
        if (!renderer)
        {
            renderer = [[ES1Renderer alloc] init];

            if (!renderer)
            {
                [self release];
                return nil;
            }
        }
#else
		renderer = [[ES1Renderer alloc] init];
		
		if (!renderer)
		{
			[self release];
			return nil;
		}
#endif
        animating = FALSE;
        displayLinkSupported = FALSE;
        animationFrameInterval = 1;
        displayLink = nil;
        animationTimer = nil;
		currFingers = 0;

        // A system version of 3.1 or greater is required to use CADisplayLink. The NSTimer
        // class is used as fallback when it isn't available.
        NSString *reqSysVer = @"3.1";
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
            displayLinkSupported = TRUE;
    }

    return self;
}

- (void)drawView:(id)sender
{
    [renderer render];
}

- (void)layoutSubviews
{
    [renderer resizeFromLayer:(CAEAGLLayer*)self.layer];
    [self drawView:nil];
}

- (NSInteger)animationFrameInterval
{
    return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    // Frame interval defines how many display frames must pass between each time the
    // display link fires. The display link will only fire 30 times a second when the
    // frame internal is two on a display that refreshes 60 times a second. The default
    // frame interval setting of one will fire 60 times a second when the display refreshes
    // at 60 times a second. A frame interval setting of less than one results in undefined
    // behavior.
    if (frameInterval >= 1)
    {
        animationFrameInterval = frameInterval;

        if (animating)
        {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

- (void)startAnimation
{
    if (!animating)
    {
        if (displayLinkSupported)
        {
            // CADisplayLink is API new to iPhone SDK 3.1. Compiling against earlier versions will result in a warning, but can be dismissed
            // if the system version runtime check for CADisplayLink exists in -initWithCoder:. The runtime check ensures this code will
            // not be called in system versions earlier than 3.1.

            displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(drawView:)];
            [displayLink setFrameInterval:animationFrameInterval];
            [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        }
        else
            animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0) * animationFrameInterval) target:self selector:@selector(drawView:) userInfo:nil repeats:TRUE];

        animating = TRUE;
    }
}

- (void)stopAnimation
{
    if (animating)
    {
        if (displayLinkSupported)
        {
            [displayLink invalidate];
            displayLink = nil;
        }
        else
        {
            [animationTimer invalidate];
            animationTimer = nil;
        }

        animating = FALSE;
    }
}

- (void)dealloc
{
    [renderer release];

    [super dealloc];
}

#pragma mark -
#pragma mark touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	int tcount = [touches count];
	currFingers += tcount;
	if (tcount == 1) {
		// 
		UITouch *tch;
		tch = [touches anyObject];
		prevPt[currFingers - 1] = [tch locationInView:self];
#ifdef DEBUG_LOG
		NSLog(@"touchesBegan with 1 finger");
#endif
	} else if (tcount == 2) {
		// 
		int i = 0;
		NSEnumerator *enumerator = [touches objectEnumerator];
		UITouch *tch;
		while (tch = [enumerator nextObject]) {
			prevPt[i] = [tch locationInView:self];
			i++;
			if (i > tcount - 1) {
				break;
			}
		}
#ifdef DEBUG_LOG
		NSLog(@"touchesBegan with 2 finger");
#endif
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	int tcount = [touches count];
	if (tcount != currFingers) {
		return;
	}
	if (tcount == 1) {
		// 
		UITouch *tch;
		tch = [touches anyObject];
		currPt[0] = [tch locationInView:self];
		float diffx, diffy;
		diffx = currPt[0].x - prevPt[0].x;
		diffy = currPt[0].y - prevPt[0].y;
		if (fabs(diffx) > fabs(diffy)) {
			float brot = [renderer getBaseRot];
			brot += diffx * 0.5f;
			[renderer setBaseRot:brot];
		} else {
			float arm = [renderer getArmParam];
			arm += diffy;
			if (arm < -70.0f) {
				arm = -70.0f;
			} else if (arm > 70.0f) {
				arm = 70.0f;
			}
			[renderer setArmParam:arm];
		}
		prevPt[0] = currPt[0];
#ifdef DEBUG_LOG
		NSLog(@"base rot");
#endif
	} else if (tcount == 2) {
		// 
		int i = 0;
		NSEnumerator *enumerator = [touches objectEnumerator];
		UITouch *tch;
		while (tch = [enumerator nextObject]) {
			currPt[i] = [tch locationInView:self];
			i++;
			if (i > 1) {
				break;
			}
		}
		Vector2 v[2];
		setVector2(&v[0], currPt[0].x - prevPt[0].x, currPt[0].y - prevPt[0].y);
		setVector2(&v[1], currPt[1].x - prevPt[1].x, currPt[1].y - prevPt[1].y);
		normalizeVector2(&v[0]);
		normalizeVector2(&v[1]);
		GLfloat dot;
		dot = dotVector2(&v[0], &v[1]);
		if (dot < -0.5f) {
			// 
			setVector2(&v[0], prevPt[1].x - prevPt[0].x, prevPt[1].y - prevPt[0].y);
			setVector2(&v[1], currPt[1].x - currPt[0].x, currPt[1].y - currPt[0].y);
			float len0, len1;
			len0 = getLengthVector2(&v[0]);
			len1 = getLengthVector2(&v[1]);
			if ((len0 < 1.0f) || (len1 < 1.0f)) {
				return;
			}
			float finger, diff;
			diff = (len0 - len1) * 0.5f;
			finger = [renderer getFingerParam];
			finger += diff;
			if (finger < -90.0f) {
				finger = -90.0f;
			} else if (finger > -45.0f) {
				finger = -45.0f;
			}
			[renderer setFingerParam:finger];
#ifdef DEBUG_LOG
			if (len0 > len1) {
				NSLog(@"Pinch in %f", finger);
			} else {
				NSLog(@"Pinch out %f", finger);
			}
#endif
		} else if (dot > 0.5f) {
			// 
#ifdef DEBUG_LOG
			NSLog(@"Twin drag");
#endif
			float diffy = currPt[0].y - prevPt[0].y;
			float diffx = currPt[0].x - prevPt[0].x;
			if (fabs(diffy) > fabs(diffx)) {
				diffy += currPt[1].y - prevPt[1].y;
				diffy *= 0.5f;
				float arm = [renderer getArmParam];
				arm -= diffy;
				if (arm < -70.0f) {
					arm = -70.0f;
				} else if (arm > 70.0f) {
					arm = 70.0f;
				}
				[renderer setArmParam:arm];
			} else if (fabs(diffx) > fabs(diffy)) {
				diffx += currPt[1].x - prevPt[1].x;
				diffx *= 0.5f;
				float palm = [renderer getPalmParam];
				palm += diffx;
				[renderer setPalmParam:palm];
			}
		}
		prevPt[0] = currPt[0];
		prevPt[1] = currPt[1];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	int tcount = [touches count];
	if ((currFingers == 2) && (tcount == 1)) {
		UITouch *tch;
		tch = [touches anyObject];
		CGPoint endPt;
		endPt = [tch locationInView:self];
		Vector2 v0, v1;
		setVector2(&v0, endPt.x - currPt[0].x, endPt.y - currPt[0].y);
		setVector2(&v1, endPt.x - currPt[1].x, endPt.y - currPt[1].y);
		float len0, len1;
		len0 = getLengthVector2(&v0);
		len1 = getLengthVector2(&v1);
		if (len0 < len1) {
			prevPt[0] = prevPt[1];
			currPt[0] = currPt[1];
		}
	}
	currFingers -= tcount;
#ifdef DEBUG_LOG
	NSLog(@"touchesEnded with %d finger", tcount);
#endif
}

@end
