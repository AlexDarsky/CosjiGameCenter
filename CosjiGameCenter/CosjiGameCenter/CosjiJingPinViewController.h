//
//  CosjiJingPinViewController.h
//  CosjiGameCenter
//
//  Created by Darsky on 13-10-29.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface CosjiJingPinViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,iCarouselDataSource,iCarouselDelegate>
{
    NSMutableArray *topGamesArray;
    NSMutableArray *weekGamesArray;
}
@property (strong,nonatomic) UITableView *JPTableView;
@property (strong,nonatomic) iCarousel *carousel;
@property (strong)id jingPinViewControllerDelegate;
-(void)pushTodDetialViewController;
@end
