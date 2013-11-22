//
//  CosjiGameDetailInfo.m
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-15.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import "CosjiGameDetailInfo.h"
#import <QuartzCore/QuartzCore.h>

@implementation CosjiGameDetailInfo

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setGameDetialInfo:(NSDictionary*)gameSimpleInfo isHot:(BOOL)hot
{
    UIImageView *iconImage=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 85, 85)];
    [iconImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[gameSimpleInfo objectForKey:@"imageURL"]]]];
    [self addSubview:iconImage];
    UILabel *gameName=[[UILabel alloc] initWithFrame:CGRectMake(105, 10, 110, 25)];
    gameName.text=[NSString stringWithFormat:@"%@",[gameSimpleInfo objectForKey:@"gameName"]];
    gameName.backgroundColor=[UIColor clearColor];
    gameName.font=[UIFont fontWithName:@"Arial" size:16];
    [self addSubview:gameName];
    if (hot) {
        UILabel *hotLabel=[[UILabel alloc] initWithFrame:CGRectMake(210, 15, 15, 15)];
        hotLabel.layer.borderColor=[[UIColor redColor]CGColor];
        hotLabel.layer.borderWidth=1;
        hotLabel.textColor=[UIColor redColor];
        hotLabel.adjustsFontSizeToFitWidth=YES;
        hotLabel.textAlignment=NSTextAlignmentCenter;
        hotLabel.backgroundColor=[UIColor clearColor];
        hotLabel.text=@"热";
        [self addSubview:hotLabel];
    }
    UIButton *downLoadBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    downLoadBtn.frame=CGRectMake(105, 60, 122/2, 46/2);
    [downLoadBtn setBackgroundImage:[UIImage imageNamed:@"下载按钮"] forState:UIControlStateNormal];
    [downLoadBtn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
    [downLoadBtn setTitle:@"     下载" forState:UIControlStateNormal];
    [self addSubview:downLoadBtn];
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
