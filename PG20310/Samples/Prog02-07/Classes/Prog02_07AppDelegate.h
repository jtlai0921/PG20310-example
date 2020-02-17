//
//  Prog02_07AppDelegate.h
//  Prog02-07
//
//  Created by SAKAI Yuji on 10/03/12.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;

@interface Prog02_07AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    EAGLView *glView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EAGLView *glView;

@end

