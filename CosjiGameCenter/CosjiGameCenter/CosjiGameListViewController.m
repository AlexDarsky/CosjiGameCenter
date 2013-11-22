//
//  CosjiGameListViewController.m
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-12.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import "CosjiGameListViewController.h"

@interface CosjiGameListViewController ()

@end

@implementation CosjiGameListViewController
@synthesize titleLabel;
static CosjiGameListViewController *shareCosjiGameListViewController=nil;

+(CosjiGameListViewController*)shareCosjiGameListViewController
{
    if (shareCosjiGameListViewController == nil) {
        shareCosjiGameListViewController = [[super allocWithZone:NULL] init];
    }
    return shareCosjiGameListViewController;

}
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
    UIView *view=[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor=[UIColor whiteColor];
    self.view=view;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 74, 320, [[UIScreen mainScreen] bounds].size.height-123)];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    [self.view addSubview:self.myTableView];
    itemsArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.customNavBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.customNavBar.backgroundColor=[UIColor lightTextColor];
    [self.view addSubview:self.customNavBar];
    self.titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(100,2,100, 40)];
    self.titleLabel.font=[UIFont fontWithName:@"Arial" size:16];
    self.titleLabel.textAlignment=UITextAlignmentCenter;
    self.titleLabel.backgroundColor=[UIColor clearColor];
    [self.customNavBar addSubview:self.titleLabel];
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(20,15, 21/2, 35/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToView) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:backBtn];
}
#pragma mark UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       return [itemsArray count];
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
    return cell;
    
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)backToView
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
