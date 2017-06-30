//
//  GeeActDetailSegmentView.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/24.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeActDetailSegmentView.h"

@interface GeeActDetailSegmentView ()

@property(nonatomic, strong) NSMutableArray *buttonArray;
@property(nonatomic, strong) NSMutableArray *linesArray;
@property(nonatomic, strong) UIView *bLine;

@end

@implementation GeeActDetailSegmentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (NSMutableArray *)linesArray
{
    if (_linesArray == nil) {
        _linesArray = [NSMutableArray array];
    }
    return _linesArray;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    
    [self removeAllSubviews];
    [self.buttonArray removeAllObjects];
    [self.linesArray removeAllObjects];
    
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        NSString *title = [titleArray objectAtIndex:i];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorFromHexRGB:@"646464"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateSelected];
//        [button setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttonArray addObject:button];
        
        if (i < titleArray.count - 1) {
            UIView *line = [[UIView alloc]init];
            line.backgroundColor = [UIColor colorFromHexRGB:@"c8c8c8"];
            [self addSubview:line];
            line.tag = i;
            [self.linesArray addObject:line];
        }
    }
    
    UIView *line = [[UIView alloc]init];
    self.bLine = line;
    line.backgroundColor = [UIColor colorFromHexRGB:@"c8c8c8"];
    [self addSubview:line];
}

- (void)buttonClicked:(UIButton *)button
{
    static UIButton *lastbtn = nil;
    
    if (lastbtn == button) {
        return;
    }
    
    button.selected = YES;
    lastbtn.selected = NO;
    
    if (self.buttonClickedAtIndex) {
        self.buttonClickedAtIndex(button.tag);
    }
    
    lastbtn = button;
}

- (void)layoutSubviews
{
    CGFloat width = (self.frame.size.width-(self.buttonArray.count-1)*0.5)/self.buttonArray.count;
    for (int i = 0; i < self.buttonArray.count; i++) {
        
        UIButton *button = [self.buttonArray objectAtIndex:i];
        button.frame = CGRectMake(i*width+i*0.5, 0, width, self.frame.size.height);
        
        if (i == 0) {
            [self buttonClicked:button];
            button.selected = YES;
        }
    }
    
    for (int i = 0; i < self.linesArray.count; i++) {
        UIView *line = [self.linesArray objectAtIndex:i];
        line.frame = CGRectMake((i+1)*width+i*0.5, 0, 0.5, self.frame.size.height);
    }
    
    self.bLine.frame = CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5);
    
}

@end
