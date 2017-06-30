//
//  IntroView.h
//  HappyShareSE
//
//  Created by 胡波 on 13-12-17.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroDelegate
@optional
- (void)introDidFinish;
@end

@interface IntroView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) id<IntroDelegate> delegate;

@property (nonatomic, assign) bool swipeToExit;

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UIImageView *pageBgBack;
@property (nonatomic, retain) UIImageView *pageBgFront;
@property (nonatomic, retain) NSArray *pages;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray;

- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration;

@end
