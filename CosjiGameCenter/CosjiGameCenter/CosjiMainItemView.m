//
//  CosjiMainItemView.m
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-4.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import "CosjiMainItemView.h"

@implementation CosjiMainItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
-(void)setContentView:(NSDictionary*)itemDIC
{
    
    UIImageView *gameImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 60)];
    NSString *imageURL=[NSString stringWithFormat:@"%@",[itemDIC objectForKey:@"iconURL"]];
    [gameImage setImage:[UIImage imageNamed:imageURL]];
    [self addSubview:gameImage];
    UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(30, 65, 60, 20)];
    nameLabel.text=[NSString stringWithFormat:@"%@",[itemDIC objectForKey:@"name"]];
    nameLabel.font=[UIFont fontWithName:@"Arial" size:12];
    [self addSubview:nameLabel];
    NSString *priceType=[NSString stringWithFormat:@"%@",[itemDIC objectForKey:@"price"]];
    switch ([priceType intValue]) {
        case 0:
        {
            UILabel *tp=[[UILabel alloc] initWithFrame:CGRectMake(10, 70, 25/2, 25/2)];
            tp.backgroundColor=[UIColor redColor];
            tp.textColor=[UIColor whiteColor];
            tp.textAlignment=UITextAlignmentCenter;
            tp.adjustsFontSizeToFitWidth=YES;
            tp.text=@"免";
            [self addSubview:tp];
        }
            break;
        case 1:
        {
            UILabel *tp=[[UILabel alloc] initWithFrame:CGRectMake(10, 70, 25/2, 25/2)];
            tp.backgroundColor=[UIColor blueColor];
            tp.textColor=[UIColor whiteColor];
            tp.textAlignment=UITextAlignmentCenter;
            tp.adjustsFontSizeToFitWidth=YES;
            tp.text=@"限";
            [self addSubview:tp];
        }
            break;
        case 2:
        {
            
        }
            break;
    }
    UILabel *contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 80, 100, 20)];
    contentLabel.text=[NSString stringWithFormat:@"%@",[itemDIC objectForKey:@"info"]];
    contentLabel.backgroundColor=[UIColor clearColor];
    contentLabel.font=[UIFont fontWithName:@"Arial" size:8];
    [self addSubview:contentLabel];
    UIImageView *starImg=[[UIImageView alloc] initWithFrame:CGRectMake(110, 85, 25/2, 25/2)];
    starImg.image=[UIImage imageNamed:@"小星"];
    [self addSubview:starImg];
    UILabel *fen=[[UILabel alloc] initWithFrame:CGRectMake(130, 80, 20, 20)];
    fen.text=[NSString stringWithFormat:@"%@",[itemDIC objectForKey:@"appraise"]];
    fen.backgroundColor=[UIColor clearColor];
    fen.adjustsFontSizeToFitWidth=YES;
    [self addSubview:fen];
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
