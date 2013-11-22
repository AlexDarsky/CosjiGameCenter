//
//  CosjiViewController.m
//  CosjiGameCenter
//
//  Created by Darsky on 13-10-29.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import "CosjiViewController.h"
#import "CosjiMainItemView.h"
#import "CosjiCustomerViewController.h"
@interface CosjiViewController ()

@end

@implementation CosjiViewController
@synthesize viewControllerDelegate;

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
	// Do any additional setup after loading the view, typically from a nib.
    self.mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 77, 320, [[UIScreen mainScreen] bounds].size.height-77) style:UITableViewStyleGrouped];
    self.mainTableView.delegate=self;
    self.mainTableView.dataSource=self;
    self.mainTableView.backgroundColor=[UIColor clearColor];
    self.mainTableView.backgroundView=nil;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.mainTableView setSeparatorColor:[UIColor clearColor]];
    [self.mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.mainTableView];
    gamesArray=[[NSMutableArray alloc] initWithCapacity:0];
    newgamesArray=[[NSMutableArray alloc] initWithCapacity:0];
    
    UIView *customNavBar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    customNavBar.backgroundColor=[UIColor lightTextColor];
    [self.view addSubview:customNavBar];
    UIButton *menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"菜单 默认1"] forState:UIControlStateNormal];
    menuBtn.frame=CGRectMake(15, 10, 20, 20);
    [menuBtn addTarget:self action:@selector(showBack) forControlEvents:UIControlEventTouchUpInside];
    [customNavBar addSubview:menuBtn];
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 0, 100, 40)];
    titleLabel.textAlignment=UITextAlignmentCenter;
    titleLabel.text=@"发现游戏";
    titleLabel.textColor=[UIColor grayColor];
    titleLabel.backgroundColor=[UIColor clearColor];
    [customNavBar addSubview:titleLabel];
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(285, 10, 20, 20);
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"搜索ing"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(showSearch) forControlEvents:UIControlEventTouchUpInside];
    [customNavBar addSubview:searchBtn];
    self.segmentedControl=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"热门游戏",@"最新游戏", nil]];
    self.segmentedControl.frame=CGRectMake(0, 44, 320, 33);
    self.segmentedControl.selectedSegmentIndex=0;
    self.segmentedControl.backgroundColor=[UIColor clearColor];
    [self.segmentedControl setImage:[UIImage imageNamed:@"按钮 左默认"] forSegmentAtIndex:0];
    [self.segmentedControl setImage:[UIImage imageNamed:@"按钮 右默认"] forSegmentAtIndex:1];
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl addTarget:self action:@selector(changeModel:) forControlEvents:UIControlEventValueChanged];
    updatesView=[[UIView alloc] initWithFrame:CGRectMake(265, -5, 20, 20)];
    updatesView.backgroundColor=[UIColor greenColor];
    updatesView.layer.cornerRadius = 10;
    UILabel *uplabel=[[UILabel alloc] initWithFrame:CGRectMake(2.5, 2.5, 15, 15)];
    uplabel.text=@"2";
    uplabel.textColor=[UIColor whiteColor];
    uplabel.font=[UIFont fontWithName:@"Arial" size:12];
    uplabel.textAlignment=NSTextAlignmentCenter;
    uplabel.backgroundColor=[UIColor clearColor];
    [updatesView addSubview:uplabel];
    [self.segmentedControl addSubview:updatesView];
    tableModel=0;
    [self initSV];
}
-(void)initSV
{
    sv=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, 320, 150)];
   sv.delegate=self;
    sv.showsHorizontalScrollIndicator=NO;
    sv.backgroundColor=[UIColor clearColor];
    NSArray *topImage=[[NSArray alloc] initWithObjects:@"DEAD_TRIGGER_1.jpg", @"DEAD_TRIGGER_2.jpg",@"DEAD_TRIGGER_3.jpg",@"DEAD_TRIGGER_4.jpg",@"DEAD_TRIGGER_5.jpg",nil];
    page=[[UIPageControl alloc] initWithFrame:CGRectMake(240, 160, 38,36)];
    
    [sv setContentSize:CGSizeMake(320*[topImage count], 150)];
    page.numberOfPages=[topImage count];
    page.hidden=NO;
    [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
    for ( int i=0; i<[topImage count]; i++) {
        
        UIButton *img=[[UIButton alloc]initWithFrame:CGRectMake(320*i, 0, 320, 150)];
        [img addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
        [sv addSubview:img];
        [img setBackgroundImage:[UIImage imageNamed:[topImage objectAtIndex:i]] forState:UIControlStateNormal];
    }
    [self setCurrentPage:page.currentPage];
    [self.mainTableView addSubview:page];

}
-(void)showBack
{
    [viewControllerDelegate showBackView:nil];
}
-(void)showSearch
{
    [viewControllerDelegate showSearchView];
}
- (void) handleTimer: (NSTimer *) timer
{
    if (TimeNum % 5 == 0 ) {
        //Tend 默认值为No
        if (!Tend) {
            NSLog(@"curretn page is %d",page.currentPage);
            page.currentPage++;
            if (page.currentPage==page.numberOfPages-1) {
                Tend=YES;
            }
        }else{
            NSLog(@"curretn page is %d",page.currentPage);
            page.currentPage--;
            if (page.currentPage==0) {
                Tend=NO;
            }
        }
        
        [UIView animateWithDuration:0.7 //速度0.7秒
                         animations:^{//修改坐标
                             sv.contentOffset = CGPointMake(page.currentPage*320,0);
                         }];
        
        
    }
    TimeNum ++;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView class]==[sv class]) {
        page.currentPage=scrollView.contentOffset.x/320;
        [self setCurrentPage:page.currentPage];
    }

}
- (void) setCurrentPage:(NSInteger)secondPage {
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [page.subviews count]; subviewIndex++) {
        page.currentPageIndicatorTintColor=[UIColor redColor];
    }
}
-(void)Action
{
    if ([viewControllerDelegate canContinueAcion]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"享受" message:@"还木有广告君" delegate:nil cancelButtonTitle:@"我去" otherButtonTitles: nil];
        [alert show];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [viewControllerDelegate willHideSearchView];
    if ([gamesArray count]>0) {
        
    }else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [gamesArray addObjectsFromArray:[self creatDemoInfo]];
            NSLog(@"get Store %d",[gamesArray count]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainTableView reloadData];
            });
            
        });

    }
}
-(void)getGameList
{
    
}
#pragma mark UITableViewDataSource

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=nil;
    switch (tableModel) {
        case 1:
        {
            NSDictionary *item=[NSDictionary dictionaryWithDictionary:[newgamesArray objectAtIndex:section]];
            headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
            headerView.backgroundColor=[UIColor clearColor];
            UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(35, 2, 20, 20)];
            image.image=[UIImage imageNamed:@"时间"];
            [headerView addSubview:image];
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(60, -5, 96, 33)];
            label.font=[UIFont fontWithName:@"Arial" size:14];
            label.text=[NSString stringWithFormat:@"%@",[item objectForKey:@"title"]];
            label.backgroundColor=[UIColor clearColor];
            label.textColor=[UIColor greenColor];
            [headerView addSubview:label];
            return headerView;
        }
            break;
    }
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    float height;
    switch (tableModel) {
        case 1:
        {
            height=25;
        }
            break;
    }
    return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height;
    switch (tableModel) {
        case 0:
        {
            if (indexPath.section==0) {
                height=160.0;
            }else
                height=110.0;

        }
            break;
        case 1:
        {

            height=70;
        }
            break;
    }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger integer = 0;
    switch (tableModel) {
        case 0:
        {
            integer=1;
        }
            break;
            
        default:
        {
            NSDictionary *newGamesDic=[NSDictionary dictionaryWithDictionary:[newgamesArray objectAtIndex:section]];
            NSArray *tmpArray=[NSArray arrayWithArray:[newGamesDic objectForKey:@"newGames"]];
            integer=[tmpArray count];
        }
            break;
    }
    return integer;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (tableModel) {
        case 0:
            return [gamesArray count]/2+1;
            break;
        default:
            return [newgamesArray count];
            break;
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    switch (tableModel) {
        case 0:
        {
            cell.backgroundColor=[UIColor clearColor];
            if (indexPath.section>0) {
                if ([gamesArray count]%2==0)
                {
                    NSDictionary *gameItem1=[gamesArray objectAtIndex:indexPath.row*2];
                    NSDictionary *gameItem2=[gamesArray objectAtIndex:indexPath.row*2+1];
                    //左
                    CosjiMainItemView *game1View=[[CosjiMainItemView alloc] initWithFrame:CGRectMake(5, 0, 150, 100)];
                    [game1View setContentView:gameItem1];
                    [cell addSubview:game1View];
                    //右
                    CosjiMainItemView *game2View=[[CosjiMainItemView alloc] initWithFrame:CGRectMake(165, 0, 150, 100)];
                    [game2View setContentView:gameItem2];
                    [cell addSubview:game2View];
                    
                }else
                {
                    NSDictionary *gameItem1=[gamesArray objectAtIndex:indexPath.row*2];
                    //左
                    CosjiMainItemView *game1View=[[CosjiMainItemView alloc] initWithFrame:CGRectMake(5, 0, 150, 100)];
                    [game1View setContentView:gameItem1];
                    [cell addSubview:game1View];
                    if ([gamesArray count]<indexPath.row*2+1)
                    {
                        NSDictionary *gameItem2=[gamesArray objectAtIndex:indexPath.row*2+1];
                        //右
                        CosjiMainItemView *game2View=[[CosjiMainItemView alloc] initWithFrame:CGRectMake(165, 0, 150, 100)];
                        [game2View setContentView:gameItem2];
                        [cell addSubview:game2View];
                    }
                }
            }else
            {
                [cell addSubview:sv];

            }
            

        }
            break;
        default:
        {

            cell.backgroundColor=[UIColor clearColor];
            NSDictionary *newGamesDic=[NSDictionary dictionaryWithDictionary:[newgamesArray objectAtIndex:indexPath.section]];
            NSArray *tmpArray=[NSArray arrayWithArray:[newGamesDic objectForKey:@"newGames"]];
            UIImageView *lineImageView=[[UIImageView alloc] initWithFrame:CGRectMake(45, 0, 2, 70)];
            lineImageView.image=[UIImage imageNamed:@"线条块"];
            [cell addSubview:lineImageView];
            NSDictionary *gameDic=[NSDictionary dictionaryWithDictionary:[tmpArray objectAtIndex:indexPath.row]];
            UIImageView *iconImage=[[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 50, 50)];
            iconImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",[gameDic objectForKey:@"path"]]];
            [cell addSubview:iconImage];
            UIView *infoView=[[UIView alloc] initWithFrame:CGRectMake(80, 0, 220, 50)];
            infoView.backgroundColor=[UIColor whiteColor];
            infoView.layer.cornerRadius = 10;
            UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
            nameLabel.text=[NSString stringWithFormat:@"%@",[gameDic objectForKey:@"name"]];
            nameLabel.backgroundColor=[UIColor clearColor];
            [infoView addSubview:nameLabel];
            UILabel *typeLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 200, 20)];
            typeLabel.text=[NSString stringWithFormat:@"%@",[gameDic objectForKey:@"type"]];
            typeLabel.backgroundColor=[UIColor clearColor];
            typeLabel.textColor=[UIColor grayColor];
            typeLabel.font=[UIFont fontWithName:@"Arial" size:11];
            [infoView addSubview:typeLabel];
            [cell addSubview:infoView];
            
        }
            break;
    }
    return cell;
    
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Action:(id)sender
{

}
-(void)changeModel:(UISegmentedControl *)Seg{
    

    NSInteger Index = Seg.selectedSegmentIndex;
    
    NSLog(@"Index %i", Index);
    switch (Index) {
        case 0:
        {
            tableModel=Index;
            page.hidden=NO;
            updatesView.hidden=NO;
            [self.mainTableView reloadData];
        }
            break;
            
        default:
        {
            tableModel=Index;
            page.hidden=YES;
            updatesView.hidden=YES;
            if ([newgamesArray count]==0) {
                [newgamesArray addObjectsFromArray:[self creatDemo2Info]];
            }
            NSLog(@" count is %d",[newgamesArray count]);
            [self.mainTableView reloadData];
        }
            break;
    }

    
}
#pragma mark creatDemoInfo
-(NSArray*)creatDemoInfo
{
    NSString *icon1path=[NSString stringWithFormat:@"DEAD_TRIGGER_5.jpg"];
    NSString *game1name=[NSString stringWithFormat:@"死亡扳机"];
    NSString *game1Info=[NSString stringWithFormat:@"身穿超短裙，戴着博士镜，丝袜美腿不逊于"];
    NSString *game1appraise=[NSString stringWithFormat:@"4.3"];
    NSString *game1priceType=[NSString stringWithFormat:@"0"];
    NSDictionary *game1Dic=[[NSDictionary alloc] initWithObjectsAndKeys:icon1path,@"iconURL",game1name,@"name",game1Info,@"info",game1appraise,@"appraise",game1priceType,@"price",nil];
    NSString *icon2path=[NSString stringWithFormat:@"wujinzhijian.jpg"];
    NSString *game2name=[NSString stringWithFormat:@"无尽之剑2"];
    NSString *game2Info=[NSString stringWithFormat:@"史诗画面的鸿篇巨制"];
    NSString *game2appraise=[NSString stringWithFormat:@"5.0"];
    NSString *game2priceType=[NSString stringWithFormat:@"1"];
    NSDictionary *game2Dic=[[NSDictionary alloc] initWithObjectsAndKeys:icon2path,@"iconURL",game2name,@"name",game2Info,@"info",game2appraise,@"appraise",game2priceType,@"price",nil];
    
    NSArray *demoSource=[[NSArray alloc] initWithObjects:game1Dic,game2Dic, nil];
    return demoSource;
}
-(NSArray*)creatDemo2Info
{
    //DEMO1
    NSString *ng1path=[NSString stringWithFormat:@"TW1"];
    NSString *ng1name=[NSString stringWithFormat:@"死亡扳机2"];
    NSString *ng1type=[NSString stringWithFormat:@"射击游戏|射击，僵尸"];
    NSDictionary *ng1Dic=[NSDictionary dictionaryWithObjectsAndKeys:ng1path,@"path",ng1name,@"name",ng1type,@"type", nil];
    NSString *ng2path=[NSString stringWithFormat:@"TW2"];
    NSString *ng2name=[NSString stringWithFormat:@"植物大战僵尸2"];
    NSString *ng2type=[NSString stringWithFormat:@"休闲益智|益智，僵尸"];
    NSDictionary *ng2Dic=[NSDictionary dictionaryWithObjectsAndKeys:ng2path,@"path",ng2name,@"name",ng2type,@"type", nil];
    NSArray *ngs1array=[NSArray arrayWithObjects:ng1Dic,ng2Dic, nil];
    NSString *ng1title=[NSString stringWithFormat:@"2小时前"];
    NSDictionary *section1=[NSDictionary dictionaryWithObjectsAndKeys:ng1title,@"title",ngs1array,@"newGames", nil];
    
    NSString *ng3path=[NSString stringWithFormat:@"TW1"];
    NSString *ng3name=[NSString stringWithFormat:@"死亡扳机2"];
    NSString *ng3type=[NSString stringWithFormat:@"射击游戏|射击，僵尸"];
    NSDictionary *ng3Dic=[NSDictionary dictionaryWithObjectsAndKeys:ng3path,@"path",ng3name,@"name",ng3type,@"type", nil];
    NSArray *ngs2array=[NSArray arrayWithObjects:ng3Dic, nil];
    NSString *ng2title=[NSString stringWithFormat:@"昨天"];
    NSDictionary *section2=[NSDictionary dictionaryWithObjectsAndKeys:ng2title,@"title",ngs2array,@"newGames", nil];
    
    NSArray *demoArray=[NSArray arrayWithObjects:section1,section2, nil];
    return demoArray;
    
}
-(void)viewDidUnload
{
    self.segmentedControl=nil;
}
@end
