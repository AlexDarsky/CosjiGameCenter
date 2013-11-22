//
//  CosjiNewsViewController.m
//  CosjiGameCenter
//
//  Created by Darsky on 13-10-29.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import "CosjiNewsViewController.h"
#import "CosjiCustomerViewController.h"
#import "CosjiGameListViewController.h"

@interface CosjiNewsViewController ()

@end

@implementation CosjiNewsViewController
@synthesize newsViewControllerDelegate;

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
    primaryView.backgroundColor=[UIColor whiteColor];
    self.view=primaryView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, [[UIScreen mainScreen] bounds].size.height-44)];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    kindsArray=[[NSMutableArray alloc] initWithCapacity:0];
    [self.view addSubview:self.myTableView];
    [self getDemoResource];
    UIView *customNavBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    customNavBar.backgroundColor=[UIColor lightTextColor];
    [self.view addSubview:customNavBar];
    UIButton *menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"菜单 默认1"] forState:UIControlStateNormal];
    menuBtn.frame=CGRectMake(15, 10, 20, 20);
    [menuBtn addTarget:self action:@selector(showBack) forControlEvents:UIControlEventTouchUpInside];
    [customNavBar addSubview:menuBtn];
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(285, 10, 20, 20);
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"搜索ing"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(showSearch) forControlEvents:UIControlEventTouchUpInside];
    [customNavBar addSubview:searchBtn];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    [newsViewControllerDelegate willHideSearchView];

}
-(void)showBack
{
    [newsViewControllerDelegate showBackView:nil];
}
-(void)showSearch
{
    [newsViewControllerDelegate showSearchView];
}
#pragma mark UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 107.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [kindsArray count]/2;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //左
    UIView *element1View=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 150, 107)];
    element1View.layer.borderWidth=1;
    element1View.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    NSString *name1=[NSString stringWithFormat:@"%@",[kindsArray objectAtIndex:indexPath.row*2]];
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:[UIImage imageNamed:name1] forState:UIControlStateNormal];
    button1.frame=CGRectMake(7/2, 5/2, 143, 80);
    button1.tag=indexPath.row*2;
    [button1 addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(7/3, 85, 100, 20)];
    label1.text=[NSString stringWithFormat:@"%@",name1];
    label1.backgroundColor=[UIColor clearColor];
    [element1View addSubview:button1];
    [element1View addSubview:label1];
    [cell addSubview:element1View];
    
    
    //右
    UIView *element2View=[[UIView alloc] initWithFrame:CGRectMake(160, 0, 150, 107)];
    element2View.layer.borderWidth=1;
    element2View.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    NSString *name2=[NSString stringWithFormat:@"%@",[kindsArray objectAtIndex:indexPath.row*2+1]];
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundImage:[UIImage imageNamed:name2] forState:UIControlStateNormal];
    button2.frame=CGRectMake(7/2, 5/2, 143, 80);
    button2.tag=indexPath.row*2+1;
    [button2 addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(7/3, 85, 100, 20)];
    label2.text=[NSString stringWithFormat:@"%@",name2];
    label2.backgroundColor=[UIColor clearColor];
    [element2View addSubview:button2];
    [element2View addSubview:label2];
    [cell addSubview:element2View];
    
    return cell;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)Action:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    CosjiGameListViewController *gameListViewController=[CosjiGameListViewController shareCosjiGameListViewController];
    [self.navigationController pushViewController:gameListViewController animated:YES];
    [gameListViewController.titleLabel setText:[NSString stringWithFormat:@"%@",[kindsArray objectAtIndex:btn.tag]]];
    
}
-(void)getDemoResource
{
    if ([kindsArray count]==0)
    {
        NSArray *nameArray=[NSArray arrayWithObjects:@"冒险解密",@"动作格斗",@"赛车竞速",@"设计空战",@"休闲益智",@"网络游戏",@"即时战略",@"模拟经营", nil];
        [kindsArray addObjectsFromArray:nameArray];
        [self.myTableView reloadData];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
