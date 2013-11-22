//
//  CosjiCustomerViewController.m
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-11.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import "CosjiCustomerViewController.h"
#import "CosjiJingPinViewController.h"
#import "CosjiSearchViewController.h"
#import "WPXMLRPCClient.h"

@interface CosjiCustomerViewController ()

@end
@implementation CosjiCustomerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView
{
    UIView *primaryView=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view=primaryView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"个人中心  背景图"]]];
    [self initUserInfo];
    UIButton *editBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame=CGRectMake(100, 30, 54, 54);
    [editBtn setBackgroundImage:[UIImage imageNamed:@"编辑个人资料"] forState:UIControlStateNormal];
    [self.view addSubview:editBtn];
    UIButton *loveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loveBtn.frame=CGRectMake(160, 30, 54, 54);
    [loveBtn setBackgroundImage:[UIImage imageNamed:@"个人收藏"] forState:UIControlStateNormal];
    [self.view addSubview:loveBtn];
    itemArray=[[NSArray alloc] initWithObjects:@"分享给好友",@"喜欢我们 打分鼓励",@"关于我们",@"意见反馈",@"清空缓存", nil];
    self.myTableView=[[UITableView alloc] initWithFrame:CGRectMake(10, 110, 250,[[UIScreen mainScreen] bounds].size.height-220) style:UITableViewStyleGrouped];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor clearColor];
    self.myTableView.backgroundView=nil;
    self.myTableView.scrollEnabled=NO;
    [self.view addSubview:self.myTableView];
    [self initTabBarViewController];
}
-(void)initUserInfo
{
    UIImageView *userImage=[[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 172/2, 172/2)];
    [userImage setImage:[UIImage imageNamed:@"个人头像"]];
    [self.view addSubview:userImage];
    self.userID=[[UILabel alloc] initWithFrame:CGRectMake(10, 60, 60, 20)];
    self.userID.text=@"玩家532323";
    self.userID.font=[UIFont fontWithName:@"Arial" size:8];
    self.userID.adjustsFontSizeToFitWidth=YES;
    self.userID.textAlignment=UITextAlignmentCenter;
    self.userID.backgroundColor=[UIColor clearColor];
    [userImage addSubview:self.userID];
}
-(void)initTabBarViewController
{
    childViewShow=NO;
    searchViewShow=NO;
    self.tabBarController=[[UITabBarController alloc] init];
    CosjiViewController *viewController=[[CosjiViewController alloc] init];
    viewController.tabBarItem.title=@"最新最热";
    viewController.viewControllerDelegate=self;
    [viewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"火 彩色"] withFinishedUnselectedImage:[UIImage imageNamed:@"火 灰色"]];
    CosjiJingPinViewController *jingPingViewController=[[CosjiJingPinViewController alloc] init];
    jingPingViewController.tabBarItem.title=@"周刊专题";
    jingPingViewController.jingPinViewControllerDelegate=self;
    [jingPingViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"钻石 彩色"] withFinishedUnselectedImage:[UIImage imageNamed:@"钻石 灰色"]];
    UINavigationController *jingPingNavigationController=[[UINavigationController alloc] initWithRootViewController:jingPingViewController];
    jingPingNavigationController.navigationBarHidden=YES;
    CosjiNewsViewController *newsViewController=[[CosjiNewsViewController alloc] init];
    newsViewController.tabBarItem.title=@"分来榜单";
    newsViewController.newsViewControllerDelegate=self;
    [newsViewController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"菜单 排行 彩色"] withFinishedUnselectedImage:[UIImage imageNamed:@"菜单 灰色"]];
    UINavigationController *newNavigationController=[[UINavigationController alloc] initWithRootViewController:newsViewController];
    newNavigationController.navigationBarHidden=YES;
    self.tabBarController.viewControllers=[NSArray arrayWithObjects:viewController,jingPingNavigationController,newNavigationController, nil];
    [self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"TabBarBackground"]];
    [self.tabBarController.tabBar setTintColor:[UIColor clearColor]];
    self.mainView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height)];
    [self.view addSubview:self.mainView];
    [self addChildViewController:self.tabBarController];
    self.tabBarController.view.frame=CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-20);
    [self.mainView addSubview:self.tabBarController.view];
    UIView *shadowView=[[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height+30, 320, 30)];
    shadowView.backgroundColor=[UIColor clearColor];
    [shadowView layer].shadowPath =[UIBezierPath bezierPathWithRect:shadowView.bounds].CGPath;
    shadowView.layer.shadowColor=[[UIColor blackColor] CGColor];
    shadowView.layer.shadowOffset=CGSizeMake(0,0);
    shadowView.layer.shadowRadius=15.0;
    shadowView.layer.shadowOpacity=0.3;
    [self.mainView addSubview:shadowView];
    self.searchView=[[UIView alloc] initWithFrame:CGRectMake(0, -[[UIScreen mainScreen] bounds].size.height, 320, [[UIScreen mainScreen] bounds].size.height-49)];
    [self.view addSubview:self.searchView];
    self.searchViewController=[[CosjiSearchViewController alloc] init];
    self.searchViewController.searchViewControllerDelegate=self;
    [self addChildViewController:self.searchViewController];
    [self.searchView addSubview:self.searchViewController.view];
}
-(void)showBackView:(id)sender
{
    if (childViewShow==NO) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        CGFloat translation = 225;
        self.mainView.transform=CGAffineTransformScale(CGAffineTransformMakeTranslation(translation,0), 0.7, 0.7);
        //self.mainView.transform=;
        [UIView commitAnimations];
        childViewShow=YES;
    }else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        CGFloat translation = 0;
        self.mainView.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(translation, 0), 1.0, 1.0);
        [UIView commitAnimations];
        childViewShow=NO;
    }
    
}
-(void)showSearchView
{
    if (childViewShow==NO) {
        if ( searchViewShow==NO) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            CGFloat translation = [[UIScreen mainScreen] bounds].size.height;
            self.searchView.transform=CGAffineTransformMakeTranslation(0, translation);
            //self.mainView.transform=;
            [UIView commitAnimations];
            searchViewShow=YES;
        }else
        {
            NSLog(@"OKOK");
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            CGFloat translation = 0;
            self.searchView.transform = CGAffineTransformMakeTranslation(0, translation);
            [UIView commitAnimations];
            searchViewShow=NO;
        }

    }
}
-(void)willHideSearchView
{
    if (searchViewShow) {
        [self showSearchView];
    }
}

#pragma mark UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [itemArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    cell.backgroundColor=[UIColor whiteColor];
    NSString *itemString=[NSString stringWithFormat:@"%@",[itemArray objectAtIndex:indexPath.section]];
    UIImageView *iconImage=[[UIImageView alloc] initWithFrame:CGRectMake(20, 29/2, 16, 20)];
    [iconImage setImage:[UIImage imageNamed:itemString]];
    [cell addSubview:iconImage];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(40, 10, 200, 25)];
    title.text=[NSString stringWithFormat:@"%@",itemString];
    title.font=[UIFont fontWithName:@"Arial" size:15];
    title.backgroundColor=[UIColor clearColor];
    [cell addSubview:title];
    return cell;
}
-(void)getDemoUserInfo
{
    
}
-(BOOL)canContinueAcion
{
    if (childViewShow) {
        [self showBackView:nil];
        return NO;
    }else
    {
        return YES;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
