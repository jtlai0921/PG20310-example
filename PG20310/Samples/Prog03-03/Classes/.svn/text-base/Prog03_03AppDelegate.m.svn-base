//
//  Prog03_03AppDelegate.m
//  Prog03-03
//
//  Created by SAKAI Yuji on 09/10/19.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Prog03_03AppDelegate.h"
#import "EAGLView.h"

@implementation Prog03_03AppDelegate

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
