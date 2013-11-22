//
//  CosjiGameCollectionView.h
//  CosjiGameCenter
//
//  Created by Darsky on 13-11-7.
//  Copyright (c) 2013年 Cosji. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CosjiGameCollectionView : UIView
{
    NSMutableArray *itemsArray;
}
-(void)initGameCollectionViewWith:(NSArray*)gamesArray;
@property (strong)id collectionViewDelegate;
@end
