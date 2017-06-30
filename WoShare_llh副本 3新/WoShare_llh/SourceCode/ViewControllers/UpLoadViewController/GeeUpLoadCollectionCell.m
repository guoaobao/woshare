//
//  GeeUpLoadCollectionCell.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/30.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeUpLoadCollectionCell.h"

@interface GeeUpLoadCollectionCell ()

@property(nonatomic, strong) UIImageView *backImageView;
@property(nonatomic, strong) UIImageView *playImageView;

@end

@implementation GeeUpLoadCollectionCell


+ (GeeUpLoadCollectionCell *)cellForCollectionView:(UICollectionView *)collectionView forIndex:(NSIndexPath *)index
{
    static NSString *reuseid = @"GeeUpLoadCollectionCell";
    GeeUpLoadCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseid forIndexPath:index];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        self.backImageView = imageView;
        [self.contentView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UIImageView *play = [[UIImageView alloc]init];
        play.frame = CGRectMake(0, 0, 40, 40);
        play.image = [UIImage imageNamed:@"icon-playbutton"];
        play.center = CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2);
        play.contentMode = UIViewContentModeScaleAspectFit;
        self.playImageView = play;
        [imageView addSubview:play];
        
        UILongPressGestureRecognizer *ges = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longGesPressed:)];
        ges.minimumPressDuration = 1;
        [self addGestureRecognizer:ges];
    }
    return self;
}

- (void)setBackImage:(UIImage *)image isVideo:(BOOL)video
{
    self.backImageView.image = image;
    if (!video) {
        self.playImageView.hidden = YES;
    } else {
        self.playImageView.hidden = NO;
    }
}

- (void)longGesPressed:(UILongPressGestureRecognizer *)ges
{
    
    if (ges.state == UIGestureRecognizerStateBegan) {
        if (self.longPressed) {
            self.longPressed(self.uploadData);
        }
    }
}


@end
