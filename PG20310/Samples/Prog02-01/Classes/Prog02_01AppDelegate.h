//
//  Prog02_01AppDelegate.h
//  Prog02-01
//
//  Created by SAKAI Yuji on 10/03/11.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;

@interface Prog02_01AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    EAGLView *glView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EAGLView *glView;

@end

