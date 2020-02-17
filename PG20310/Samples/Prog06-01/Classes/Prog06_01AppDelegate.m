//
//  Prog06_01AppDelegate.m
//  Prog06-01
//
//  Created by SAKAI Yuji on 10/01/06.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Prog06_01AppDelegate.h"
#import "EAGLView.h"

@implementation Prog06_01AppDelegate

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
