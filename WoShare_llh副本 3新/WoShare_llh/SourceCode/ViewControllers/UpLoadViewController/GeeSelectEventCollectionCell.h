//
//  GeeSelectEventCollectionCell.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/18.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventResponse.h"

@interface GeeSelectEventCollectionCell : UICollectionViewCell

+ (GeeSelectEventCollectionCell *)cellForCollection:(UICollectionView *)collection forIndex:(NSIndexPath *)indexPath;

@property(nonatomic, strong) EventResponse *eventinfo;

@end
