//
//  GeeUpLoadCollectionCell.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/30.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadData.h"

@interface GeeUpLoadCollectionCell : UICollectionViewCell

+ (GeeUpLoadCollectionCell *)cellForCollectionView:(UICollectionView *)collectionView forIndex:(NSIndexPath *)index;

- (void)setBackImage:(UIImage *)image isVideo:(BOOL)video;

@property(nonatomic, strong) UploadData *uploadData;

@property(nonatomic, copy) void(^longPressed)(UploadData *uploadData);

@end
