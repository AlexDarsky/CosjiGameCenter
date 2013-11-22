//
//  CosjiSearchViewController.m
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-11.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import "CosjiSearchViewController.h"
#import "CosjiCustomerViewController.h"

@interface CosjiSearchViewController ()

@end

@implementation CosjiSearchViewController
@synthesize searchViewControllerDelegate;
static CosjiSearchViewController *shareCosjiSearchViewController = nil;
+(CosjiSearchViewController*)shareCosjiSearchViewController
{
    
    if (shareCosjiSearchViewController == nil) {
        shareCosjiSearchViewController = [[super allocWithZone:NULL] init];
    }
    return shareCosjiSearchViewController;
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"搜索栏目  背景图"]]];
    self.view.frame=CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height-49);
    self.customSearchView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    self.customSearchView.backgroundColor=[UIColor clearColor];
    self.searchFieldBG=[[UIImageView alloc] initWithFrame:CGRectMake(19/2,34, 301, 87/2)];
    [self.searchFieldBG setImage:[UIImage imageNamed:@"搜索框"]];
    [self.customSearchView addSubview:self.searchFieldBG];
    self.searchTextField=[[UITextField alloc] initWithFrame:CGRectMake(19/2,44, 301, 87/2)];
    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //[self.searchTextField setBackground:[UIImage imageNamed:@"搜索框"]];
    [self.searchTextField setBackgroundColor:[UIColor clearColor]];
    [self.searchTextField setTextAlignment:NSTextAlignmentCenter];
    [self.customSearchView addSubview:self.searchTextField];
    self.searchTextField.delegate=self;
    self.searchTextField.borderStyle=UITextBorderStyleNone;
    [self.view addSubview:self.customSearchView];
    searchMode=NO;
    self.myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 80, 320, [[UIScreen mainScreen] bounds].size.height-129)];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    [self.myTableView setBackgroundColor:[UIColor clearColor]];
    [self.myTableView setBackgroundView:nil];
    [self.myTableView setSeparatorColor:[UIColor clearColor]];
    [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.myTableView];
    self.cancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancleBtn.frame=CGRectMake(243, 40, 132/2, 62/2);
    [self.cancleBtn setBackgroundImage:[UIImage imageNamed:@"灰色的按钮"] forState:UIControlStateNormal];
    [self.cancleBtn addTarget:self action:@selector(cancelSelf) forControlEvents:UIControlEventTouchUpInside];
    [self.customSearchView addSubview:self.cancleBtn];
    self.cancleBtn.hidden=YES;
    
    
}
-(void)search
{
    if (searchMode) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        CGFloat translation = -30;
        self.customSearchView.transform=CGAffineTransformMakeTranslation(0,translation);
        self.customSearchView.backgroundColor=[UIColor whiteColor];
        [self.searchFieldBG setImage:[UIImage imageNamed:@"搜索框2"]];
        self.searchTextField.frame=CGRectMake(19/2,46, 434/2, 62/2);
        self.searchFieldBG.frame=CGRectMake(19/2,40, 434/2, 62/2);
        self.cancleBtn.hidden=NO;
        [self.myTableView setBackgroundColor:[UIColor whiteColor]];
        self.myTableView.frame=CGRectMake(0, 50, 320, [[UIScreen mainScreen] bounds].size.height-89);
        [self.myTableView setSeparatorColor:[UIColor lightGrayColor]];
        [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [UIView commitAnimations];

    }else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        CGFloat translation = 0;
        self.customSearchView.transform=CGAffineTransformMakeTranslation(0,translation);
        self.customSearchView.backgroundColor=[UIColor clearColor];
        [self.searchFieldBG setImage:[UIImage imageNamed:@"搜索框"]];
        self.searchTextField.frame=CGRectMake(19/2,44, 301, 87/2);
        self.searchFieldBG.frame=CGRectMake(19/2,34, 301, 87/2);
        [self.myTableView setBackgroundColor:[UIColor clearColor]];
        self.myTableView.frame=CGRectMake(0, 80, 320, [[UIScreen mainScreen] bounds].size.height-129);
        [self.myTableView setSeparatorColor:[UIColor clearColor]];
        [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.cancleBtn.hidden=YES;
        [UIView commitAnimations];
    }
}
-(void)cancelSelf
{
    [searchViewControllerDelegate showSearchView];
}
#pragma mark UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 107.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    cell.textLabel.text=@"DEMO";
    return cell;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void) textFieldDidChange:(UITextField*) TextField
{
    if ([self.searchTextField.text isEqualToString:@""]) {
        [TextField resignFirstResponder];
        searchMode=NO;
        [self search];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    searchMode=YES;
    [self search];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
