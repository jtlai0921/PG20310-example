//
//  Prog02_02AppDelegate.m
//  Prog02-02
//
//  Created by SAKAI Yuji on 10/03/12.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "Prog02_02AppDelegate.h"
#import "EAGLView.h"

@implementation Prog02_02AppDelegate

@synthesize window;
@synthesize glView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [glView startAnimation];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [glView stopAnimation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [glView startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [glView stopAnimation];
}

- (void)dealloc
{
    [window release];
    [glView release];

    [super dealloc];
}

@end
