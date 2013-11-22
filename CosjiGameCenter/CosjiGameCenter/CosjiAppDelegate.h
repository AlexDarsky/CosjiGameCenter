//
//  CosjiAppDelegate.h
//  CosjiGameCenter
//
//  Created by Darsky on 13-10-29.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CosjiCustomerViewController.h"

@class CosjiViewController;

@interface CosjiAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)CosjiCustomerViewController *viewController;
@end
