//
//  CosjiCustomerViewController.h
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-11.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CosjiViewController.h"
#import "CosjiJingPinViewController.h"
#import "CosjiNewsViewController.h"
#import "CosjiSearchViewController.h"
@interface CosjiCustomerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL Tend;
    BOOL childViewShow;
    BOOL searchViewShow;
    NSArray *itemArray;
}
@property (strong,nonatomic)UILabel *userID;
@property (strong,nonatomic)UIView *mainView;
@property (strong,nonatomic)UIView *searchView;
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic) UITabBarController *tabBarController;
@property (strong,nonatomic) CosjiSearchViewController *searchViewController;
-(void)showBackView:(id)sender;
-(void)showSearchView;
-(void)willHideSearchView;
-(BOOL)canContinueAcion;
@end
