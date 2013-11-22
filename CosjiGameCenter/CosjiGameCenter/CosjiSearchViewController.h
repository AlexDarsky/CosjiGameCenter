//
//  CosjiSearchViewController.h
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-11.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CosjiSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    BOOL searchMode;
    NSMutableArray *itemsArray;
}
@property (strong)id searchViewControllerDelegate;
@property (strong,nonatomic)UIButton *cancleBtn;
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)UIView *customSearchView;
@property (strong,nonatomic)UIImageView *searchFieldBG;
@property (strong,nonatomic)UITextField *searchTextField;
+(CosjiSearchViewController*)shareCosjiSearchViewController;

@end
