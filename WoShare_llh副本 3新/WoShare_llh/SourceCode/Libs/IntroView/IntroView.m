//
//  IntroView.m
//  HappyShareSE
//
//  Created by 胡波 on 13-12-17.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "IntroView.h"

@implementation IntroView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.swipeToExit = YES;
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.swipeToExit = YES;
        _pages = [pagesArray copy];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return self;
}

- (void)buildScrollViewWithFrame:(CGRect)frame {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    
    [self addSubview:self.scrollView];
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];

    int viewCount = [self.pages count];
    int viewWidth = frame.size.width;
    float viewHeight = frame.size.height;
    self.scrollView.contentSize = CGSizeMake( viewWidth * (viewCount+1), self.frame.size.height);
    for (int i = 0; i < viewCount+1; ++i)
    {
        if (i<viewCount) {
            UIView *view = [self.pages objectAtIndex:i];
            CGRect viewRect = CGRectMake(i*viewWidth,(self.frame.size.height - viewHeight)/2  , viewWidth, viewHeight);
            view.frame = viewRect;
            [self.scrollView addSubview:view];
            if (i != viewCount-1)
            {
                UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top_line.png"]];
                line.frame = CGRectMake(viewRect.origin.x + viewRect.size.width, (self.frame.size.height - 22)/2, 1, 22);
                [self.scrollView addSubview:line];
            }
        }
        else
        {
            CGRect viewRect = CGRectMake(i*viewWidth,(self.frame.size.height - viewHeight)/2  , viewWidth, viewHeight);
            UIView *view = [[UIView alloc]init];
            view.frame = viewRect;
            view.backgroundColor = [UIColor clearColor];
            [self.scrollView addSubview:view];
        }
    }    //A running x-coordinate. This grows for every page
}

- (void)setPages:(NSArray *)pages {
    _pages = [pages copy];
    [self.scrollView removeFromSuperview];
    self.scrollView = nil;
    [self buildScrollViewWithFrame:self.frame];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentPageIndex = scrollView.contentOffset.x/self.scrollView.frame.size.width;
    
    if (self.currentPageIndex == (_pages.count)) {
        if ([(id)self.delegate respondsToSelector:@selector(introDidFinish)]) {
            [self.delegate introDidFinish];
        }
        [self hideWithFadeOutDuration:0.3];
    }
}

- (void)hideWithFadeOutDuration:(CGFloat)duration {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    } completion:nil];
}

- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration {
    self.alpha = 0;
    [self.scrollView setContentOffset:CGPointZero];
    [view addSubview:self];
    
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1;
    }];
}



@end
