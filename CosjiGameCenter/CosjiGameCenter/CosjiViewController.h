//
//  CosjiViewController.h
//  CosjiGameCenter
//
//  Created by Darsky on 13-10-29.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CosjiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSMutableArray *gamesArray;
    NSMutableArray *newgamesArray;
    UIScrollView *sv;
    UIPageControl *page;
    UIView *updatesView;
    int TimeNum;
    int selectedIndex;
    BOOL Tend;
    int tableModel;

}
@property (strong)id viewControllerDelegate;
@property (strong,nonatomic)UITableView *mainTableView;
@property (strong,nonatomic)UISegmentedControl *segmentedControl;
@end
