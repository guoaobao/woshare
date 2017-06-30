//
//  GeeBaseShareSquareTableHeaderView.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/27.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeBaseShareSquareTableHeaderView.h"

#import "UIImage+UIColor.h"

@interface GeeBaseShareSquareTableHeaderView ()

@property(nonatomic, strong) UIButton *hotVedio;
@property(nonatomic, strong) UIButton *hotPicture;
@property(nonatomic, strong) UIButton *uploadRecently;

@property(nonatomic, strong) UIButton *lastButton;

@end

@implementation GeeBaseShareSquareTableHeaderView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.hotVedio = [[UIButton alloc]init];
        [self.hotVedio setTitle:@"热视频" forState:UIControlStateNormal];
        [self.hotVedio setTitleColor:[UIColor colorFromHexRGB:@"a0a0a0"] forState:UIControlStateNormal];
        [self.hotVedio setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.hotVedio.layer setMasksToBounds:YES];
        self.hotVedio.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.hotVedio];
        [self.hotVedio.layer setBorderWidth:1];
        [self.hotVedio.layer setBorderColor:[UIColor colorFromHexRGB:@"d0d0d0"].CGColor];
        [self.hotVedio setBackgroundImage:[UIImage createImageWithColor:[UIColor colorFromHexRGB:@"f0f0f0"]] forState:UIControlStateNormal];
        [self.hotVedio setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateSelected];
        [self.hotVedio addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.hotVedio.tag = 0;
        
        self.hotPicture = [[UIButton alloc]init];
        [self.hotPicture setTitle:@"热图片" forState:UIControlStateNormal];
        [self.hotPicture setTitleColor:[UIColor colorFromHexRGB:@"a0a0a0"] forState:UIControlStateNormal];
        [self.hotPicture setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.hotPicture.layer setMasksToBounds:YES];
        self.hotPicture.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.hotPicture];
        [self.hotPicture.layer setBorderWidth:1];
        [self.hotPicture.layer setBorderColor:[UIColor colorFromHexRGB:@"d0d0d0"].CGColor];
        [self.hotPicture setBackgroundImage:[UIImage createImageWithColor:[UIColor colorFromHexRGB:@"f0f0f0"]] forState:UIControlStateNormal];
        [self.hotPicture setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateSelected];
        [self.hotPicture addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.hotPicture.tag = 1;
        
        self.uploadRecently = [[UIButton alloc]init];
        [self.uploadRecently setTitle:@"最新" forState:UIControlStateNormal];//gab最近上传
        [self.uploadRecently setTitleColor:[UIColor colorFromHexRGB:@"a0a0a0"] forState:UIControlStateNormal];
        [self.uploadRecently setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.uploadRecently.layer setMasksToBounds:YES];
        self.uploadRecently.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.uploadRecently];
        [self.uploadRecently.layer setBorderWidth:1];
        [self.uploadRecently.layer setBorderColor:[UIColor colorFromHexRGB:@"d0d0d0"].CGColor];
        [self.uploadRecently setBackgroundImage:[UIImage createImageWithColor:[UIColor colorFromHexRGB:@"f0f0f0"]] forState:UIControlStateNormal];
        [self.uploadRecently setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateSelected];
        [self.uploadRecently addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.uploadRecently.tag = 2;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self buttonClicked:self.hotVedio];
    }
    return self;
}

- (void)buttonClicked:(UIButton *)button
{
    if (self.lastButton == button) {
        
    } else {
        button.selected = !button.selected;
    }
    
    
    if (button.selected) {
        [button.layer setBorderWidth:0];
    } else {
        [button.layer setBorderWidth:1];
    }
    
    if (self.lastButton != button) {
        self.lastButton.selected = NO;
        [self.lastButton.layer setBorderWidth:1];
    }
    
    if (self.headerViewChangged) {
        self.headerViewChangged(button.tag);
    }
    
    self.lastButton = button;
}

- (void)layoutSubviews
{
    self.hotVedio.frame = CGRectMake(10, 5, (self.frame.size.width-10*6)/3, self.frame.size.height-10);
    self.hotPicture.frame = CGRectMake(CGRectGetMaxX(self.hotVedio.frame)+20, 5, (self.frame.size.width-10*6)/3, self.frame.size.height-10);
    self.uploadRecently.frame = CGRectMake(CGRectGetMaxX(self.hotPicture.frame)+20, 5, (self.frame.size.width-10*6)/3, self.frame.size.height-10);
    
    [self.hotVedio.layer setCornerRadius:self.hotVedio.frame.size.height/2];
    [self.hotPicture.layer setCornerRadius:self.hotPicture.frame.size.height/2];
    [self.uploadRecently.layer setCornerRadius:self.uploadRecently.frame.size.height/2];
}


- (void)setSelectedIndex:(NSInteger)index
{
    if (self.uploadRecently.tag == index) {
        [self buttonClicked:self.uploadRecently];
    } else if (self.hotPicture.tag == index) {
        [self buttonClicked:self.hotPicture];
    } else {
        [self buttonClicked:self.hotVedio];
    }
}

- (NSInteger)getSelectedIndex
{
    if (self.uploadRecently.selected) {
        return 2;
    } else if (self.hotPicture.selected) {
        return 1;
    } else {
        return 0;
    }
}

@end
