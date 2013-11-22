//
//  CosjiGameDetialViewController.h
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-15.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CosjiGameDetialViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    int displayMode;
    NSMutableArray *listArray;
    int demo;
}
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)UISegmentedControl *mySegmentedControl;

+(CosjiGameDetialViewController*)shareCosjiGameDetialViewController;
@end
