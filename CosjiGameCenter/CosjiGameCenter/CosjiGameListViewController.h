//
//  CosjiGameListViewController.h
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-12.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CosjiGameListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    int searchMode;
    NSMutableArray *itemsArray;
}
+(CosjiGameListViewController*)shareCosjiGameListViewController;
@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UISegmentedControl *searchModeSC;
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)UIView *customNavBar;

@end
