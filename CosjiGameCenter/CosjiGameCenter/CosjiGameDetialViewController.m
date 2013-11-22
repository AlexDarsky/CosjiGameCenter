//
//  CosjiGameDetialViewController.m
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-15.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import "CosjiGameDetialViewController.h"
#import "CosjiGameDetailInfo.h"
@interface CosjiGameDetialViewController ()

@end

@implementation CosjiGameDetialViewController
static CosjiGameDetialViewController *shareCosjiGameDetialViewController=nil;
+(CosjiGameDetialViewController*)shareCosjiGameDetialViewController
{
    if (shareCosjiGameDetialViewController == nil) {
        shareCosjiGameDetialViewController = [[super allocWithZone:NULL] init];
    }
    return shareCosjiGameDetialViewController;

}
-(void)loadView
{
    UIView *primaryView=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [primaryView setBackgroundColor:[UIColor whiteColor]];
    self.view=primaryView;
    UIView *customNarBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    customNarBar.backgroundColor=[UIColor lightTextColor];
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 0, 100, 40)];
    titleLabel.textAlignment=UITextAlignmentCenter;
    titleLabel.text=@"游戏详情";
    titleLabel.textColor=[UIColor grayColor];
    titleLabel.backgroundColor=[UIColor clearColor];
    [customNarBar addSubview:titleLabel];
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(20,15, 21/2, 35/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToView) forControlEvents:UIControlEventTouchUpInside];
    [customNarBar addSubview:backBtn];
    [self.view addSubview:customNarBar];
    self.mySegmentedControl=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"游戏介绍",@"游戏评价",@"相关游戏", nil]];
    self.mySegmentedControl.backgroundColor=[UIColor clearColor];
    self.mySegmentedControl.frame=CGRectMake(0, 44, 320, 35);
    [self.mySegmentedControl setSelectedSegmentIndex:0];
    [self.view addSubview:self.mySegmentedControl];
    [self.mySegmentedControl addTarget:self action:@selector(changeModel:) forControlEvents:UIControlEventValueChanged];
    self.myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 80, 320, [UIScreen mainScreen].bounds.size.height-80)style:UITableViewStylePlain];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor whiteColor];
    self.myTableView.backgroundView=nil;
    [self.view addSubview:self.myTableView];
    demo=0;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    listArray=[[NSMutableArray alloc] initWithCapacity:0];
    [self getA:0 :1];
}
#pragma mark UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=100;
    switch (displayMode) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    height=210/2;
                }
                    break;
                case 1:
                {
                    height=378/2;

                }
                    break;
                case 2:
                {
                    height=124/2;

                }
                    break;
                case 3:
                {
                    height=130/2;

                }
                    break;
            }
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
    }
    
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int number=0;
    switch (displayMode) {
        case 0:
        {
            number=4;
        }
            break;
        case 1:
        {
            number=[listArray count];
        }
            break;
        case 2:
        {
            number=[listArray count];
        }
            break;
    }
    return number;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)getA:(int)x
{
    x=3;
}
-(void)getA:(int)x :(int)y
{
    NSLog(@"demo is %d",x);
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    switch (displayMode) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [cell setBackgroundColor:[UIColor whiteColor]];
                    NSDictionary *simpleInfoDic=[NSDictionary dictionaryWithObjectsAndKeys:@"TW2",@"imageURL",@"植物大战僵尸2",@"gameName", nil];
                    CosjiGameDetailInfo *gameDetialInfo=[[CosjiGameDetailInfo alloc] initWithFrame:CGRectMake(0, 0, 320, 210/2)];
                    [gameDetialInfo setGameDetialInfo:simpleInfoDic isHot:YES];
                    [cell addSubview:gameDetialInfo];
                }
                    break;
                case 1:
                {
                    [cell setBackgroundColor:[UIColor lightGrayColor]];
                    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 300, 360/2)];
                    [image setImage:[UIImage imageNamed:@"TOP1.jpg"]];
                    [cell addSubview:image];
                }
                    break;
                case 2:
                {

                    UITextView *introduceTV=[[UITextView alloc] initWithFrame:CGRectMake(10, 0, 300, 124/2)];
                    introduceTV.editable=NO;
                    introduceTV.text=@"简介：   达拉斯开会大量的教案课件卡卡拉是发生了客服哈李开复哈伦裤弗拉开始疯狂拉黑vakshbakvhakvakvavfka达拉斯开会大量的教案课件卡卡拉是发生了客服哈李开复哈伦裤弗拉开始疯狂拉黑vakshbakvhakvakvavfka";
                    introduceTV.backgroundColor=[UIColor lightGrayColor];
                    [cell addSubview:introduceTV];
                }
                    break;
                case 3:
                {

                    UITextView *introduceTV=[[UITextView alloc] initWithFrame:CGRectMake(10, 0, 300, 124/2)];
                    introduceTV.editable=NO;
                    introduceTV.text=@"达拉斯开会大量的教案课件卡卡拉是发生了客服哈李开复哈伦裤弗拉开始疯狂拉黑vakshbakvhakvakvavfka达拉斯开会大量的教案课件卡卡拉是发生了客服哈李开复哈伦裤弗拉开始疯狂拉黑vakshbakvhakvakvavfka";
                    introduceTV.backgroundColor=[UIColor lightGrayColor];
                    [cell addSubview:introduceTV];
                }
                    break;
            }

            
        }
            break;
            
        default:
            break;
    }
    return cell;
    
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)changeModel:(UISegmentedControl *)Seg{
    
    
    NSInteger Index = Seg.selectedSegmentIndex;
    displayMode=Index;
    [self.myTableView reloadData];
    
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
