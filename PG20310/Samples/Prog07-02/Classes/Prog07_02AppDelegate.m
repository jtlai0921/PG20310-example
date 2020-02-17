//
//  Prog07_02AppDelegate.m
//  Prog07-02
//
//  Created by SAKAI Yuji on 10/02/05.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Prog07_02AppDelegate.h"
#import "EAGLView.h"

@implementation Prog07_02AppDelegate

@synthesize window;
@synthesize glView;

- (void) applicationDidFinishLaunching:(UIApplication *)application
{
	[glView startAnimation];
}

- (void) applicationWillResignActive:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
	[glView startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) dealloc
{
	[window release];
	[glView release];
	
	[super dealloc];
}

@end
