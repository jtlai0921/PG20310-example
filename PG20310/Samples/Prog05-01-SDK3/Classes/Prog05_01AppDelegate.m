//
//  Prog05_01AppDelegate.m
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/22.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Prog05_01AppDelegate.h"
#import "EAGLView.h"

@implementation Prog05_01AppDelegate

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
