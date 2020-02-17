//
//  Prog03_04AppDelegate.m
//  Prog03-04
//
//  Created by SAKAI Yuji on 09/10/21.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Prog03_04AppDelegate.h"
#import "EAGLView.h"

@implementation Prog03_04AppDelegate

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
