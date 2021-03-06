//
//  Prog09_01AppDelegate.m
//  Prog09-01
//
//  Created by SAKAI Yuji on 10/03/20.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "Prog09_01AppDelegate.h"
#import "EAGLView.h"

@implementation Prog09_01AppDelegate

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
