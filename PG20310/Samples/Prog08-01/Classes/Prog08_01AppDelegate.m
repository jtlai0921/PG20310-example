//
//  Prog08_01AppDelegate.m
//  Prog08-01
//
//  Created by SAKAI Yuji on 10/02/16.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Prog08_01AppDelegate.h"
#import "EAGLView.h"

@implementation Prog08_01AppDelegate

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
