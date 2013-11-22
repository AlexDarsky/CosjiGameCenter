//
//  CosjiGameCollectionView.m
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-7.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import "CosjiGameCollectionView.h"
#import "CosjiJingPinViewController.h"

@implementation CosjiGameCollectionView
@synthesize collectionViewDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        itemsArray=[[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

-(void)initGameCollectionViewWith:(NSArray*)gamesArray
{
    if ([itemsArray count]>0) {
        [itemsArray removeAllObjects];
    }
    [itemsArray addObjectsFromArray:gamesArray];
    int t=0;
    t=[self getHeightF:[itemsArray count]];
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, 320, 80*t);
    for (int x=0; x<t; x++) {
        for (int y=0; y<4; y++) {
            if (x*4+y<[itemsArray count]-1) {
                NSDictionary *itemDic=[[NSDictionary alloc] initWithDictionary:[itemsArray objectAtIndex:x*4+y]];
                UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[itemDic objectForKey:@"path"]]] forState:UIControlStateNormal];
                button.tag=x*4+y;
                button.frame=CGRectMake(10+y*80, x*80+15, 60, 60);
                NSLog(@"set fram %d %d %d %d",10+y*80, x*60+15, 60, 60);
                [button addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
            }
        }
    }
}
-(int)getHeight:(int)itemNumber
{
    int a=itemNumber/4;
    float b=itemNumber/4;
    NSLog(@"itemNumer is %d,and %f",itemNumber,b);
    NSLog(@"a is %d",a);
    if (a<b) {
        return a+1;
    }else
        return a;
}
-(int)getHeightF:(float)itemNumber
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
-(void)Action:(id)sender
{
    [collectionViewDelegate pushTodDetialViewController];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
