//
//  CosjiJingPinViewController.m
//  CosjiGameCenter
//
//  Created by Darsky on 13-10-29.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import "CosjiJingPinViewController.h"
#import "CosjiGameCollectionView.h"
#import "CosjiCustomerViewController.h"
#import "CosjiGameDetialViewController.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define NUMBER_OF_ITEMS (IS_IPAD? 19: 12)
#define NUMBER_OF_VISIBLE_ITEMS 25
#define ITEM_SPACING 210.0f
#define INCLUDE_PLACEHOLDERS YES

@interface CosjiJingPinViewController ()<UIActionSheetDelegate>
@property (nonatomic, assign) BOOL wrap;
@end

@implementation CosjiJingPinViewController
@synthesize jingPinViewControllerDelegate;
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
    topGamesArray=[[NSMutableArray alloc] initWithCapacity:0];
    weekGamesArray=[[NSMutableArray alloc] initWithCapacity:0];
    self.JPTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, 320, [[UIScreen mainScreen] bounds].size.height-50) style:UITableViewStyleGrouped];
    self.JPTableView.delegate=self;
    self.JPTableView.dataSource=self;
    self.JPTableView.backgroundColor=[UIColor clearColor];
    self.JPTableView.backgroundView=nil;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.JPTableView setSeparatorColor:[UIColor clearColor]];
    [self.JPTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:self.JPTableView];
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
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 10, 100, 40)];
    titleLabel.textAlignment=UITextAlignmentCenter;
    titleLabel.text=@"发现游戏";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor=[UIColor clearColor];
    [customNavBar addSubview:titleLabel];
    [self initTopArray];
    [self initWeekArray];
    self.carousel=[[iCarousel alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    self.carousel.delegate=self;
    self.carousel.dataSource=self;
    self.carousel.type =1;
    self.wrap = YES;


}
-(void)viewWillAppear:(BOOL)animated
{
    [self.JPTableView reloadData];
    [jingPinViewControllerDelegate willHideSearchView];
}
-(void)showBack
{
    [jingPinViewControllerDelegate showBackView:nil];
}
-(void)showSearch
{
    [jingPinViewControllerDelegate showSearchView];
}
#pragma mark UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 150;
    }else
    {
        NSArray *tmpArray=[NSArray arrayWithArray:[weekGamesArray objectAtIndex:indexPath.section-1]];
        return 85*[self getHeight:[tmpArray count]];
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=nil;
    if (section>0) {
        headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        headerView.backgroundColor=[UIColor clearColor];
        NSArray *tmpArray=[NSArray arrayWithArray:[weekGamesArray objectAtIndex:section-1]];
        UILabel *numberLabel=[[UILabel alloc] initWithFrame:CGRectMake(260, 2.5, 50, 40)];
        numberLabel.backgroundColor=[UIColor clearColor];
        numberLabel.text=[NSString stringWithFormat:@"共%d款",[tmpArray count]];
        numberLabel.font=[UIFont fontWithName:@"Arial" size:13];
        [headerView addSubview:numberLabel];
        return headerView;
    }else
        return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section>0) {
        return 45;
    }else
        return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [weekGamesArray count]+1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor=[UIColor clearColor];
    if (indexPath.section==0) {
        [cell addSubview:self.carousel];
    }else
    {
        NSArray *tmpArray=[NSArray arrayWithArray:[weekGamesArray objectAtIndex:indexPath.section-1]];
        CosjiGameCollectionView *gameCollection=[[CosjiGameCollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        gameCollection.collectionViewDelegate=self;
        [gameCollection initGameCollectionViewWith:tmpArray];
        gameCollection.backgroundColor=[UIColor clearColor];
        [cell addSubview:gameCollection];
    }
    return cell;
    
}


- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [topGamesArray count];
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    //this also affects the appearance of circular-type carousels
    return NUMBER_OF_VISIBLE_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	
	//create new view if no view is available for recycling
	if (view == nil)
	{
		view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[topGamesArray objectAtIndex:index]]]];
        view.frame=CGRectMake(0, 0, 250, 110);
	}
	
	
    //set label
    
	
	return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	//note: placeholder views are only displayed on some carousels if wrapping is disabled
	return INCLUDE_PLACEHOLDERS? 2: 0;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	
	//create new view if no view is available for recycling
	if (view == nil)
	{
		view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[topGamesArray objectAtIndex:index]]]];
        view.frame=CGRectMake(0, 0, 260, 110);
	}
    //set label
	
	return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    NSLog(@"carouselItemWidth");
    return ITEM_SPACING;
}

- (CGFloat)carousel:(iCarousel *)carousel itemAlphaForOffset:(CGFloat)offset
{
	//set opacity based on distance from camera
    return 1.0f - fminf(fmaxf(offset, 0.0f), 1.0f);
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return self.wrap;
}

-(void)initTopArray
{
    if ([topGamesArray count]==0) {
        [topGamesArray addObjectsFromArray:[NSArray arrayWithObjects:@"TOP1.jpg",@"TOP2.jpg",@"TOP3.jpg",@"TOP4.jpg", nil]];

    }
}
-(void)initWeekArray
{
    if ([weekGamesArray count]==0)
    {
        NSMutableArray *arry1=[[NSMutableArray alloc] initWithCapacity:0];
        for (int x=1; x<=10; x++)
        {
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"TW%d",x],@"path", nil];
            [arry1 addObject:dic];
        }
        NSMutableArray *arry2=[[NSMutableArray alloc] initWithCapacity:0];
        for (int x=1; x<7; x++)
        {
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"TW%d",x],@"path", nil];
            [arry2 addObject:dic];
        }
        [weekGamesArray addObjectsFromArray:[NSArray arrayWithObjects:arry1,arry2, nil]];
    }
}
-(void)pushTodDetialViewController
{
    CosjiGameDetialViewController *gameDetialViewController=[CosjiGameDetialViewController shareCosjiGameDetialViewController];
    [self.navigationController pushViewController:gameDetialViewController animated:YES];
}
-(int)getHeight:(float)itemNumber
{
    int a=itemNumber/4;
    float b=itemNumber/4;
    NSLog(@"itemNumer is %f,and %f",itemNumber,b);
    NSLog(@"a is %d",a);
    if (a<itemNumber/4) {
        return a+1;
    }else
        return a;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
