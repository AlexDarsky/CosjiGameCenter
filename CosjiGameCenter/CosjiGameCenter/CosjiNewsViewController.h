//
//  CosjiNewsViewController.h
//  CosjiGameCenter
//
//  Created by Darsky on 13-10-29.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CosjiNewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray *kindsArray;
}
@property (strong)id newsViewControllerDelegate;
@property (strong,nonatomic)UITableView *myTableView;

@end
