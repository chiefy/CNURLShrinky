//
//  CNAppDelegate.h
//  iOS-Demo
//
//  Created by Christopher Najewicz on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CNViewController;

@interface CNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CNViewController *viewController;

@end
