//
//  CosjiGameListItem.m
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-21.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import "CosjiGameListItem.h"

@implementation CosjiGameListItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutWithGameInfo:(NSDictionary*)gameDic
{
    UIImageView *gameIcon=[[UIImageView alloc] initWithFrame:CGRectMake(10, (self.frame.size.height-114/2)/2, 114/2, 114/2)];
    NSString *imageURL=[NSString stringWithFormat:@"%@",[gameDic objectForKey:@"imageURL"]];
    [gameIcon setImage:[UIImage imageNamed:imageURL]];
    [self addSubview:gameIcon];
    
    
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
