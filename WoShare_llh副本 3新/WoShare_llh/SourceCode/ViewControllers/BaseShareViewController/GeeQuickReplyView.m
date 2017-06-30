//
//  GeeQuickReplyView.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/28.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeQuickReplyView.h"

@interface GeeQuickReplyView () <UITextFieldDelegate>

@property(nonatomic, strong) UIView *replyBackView;
@property(nonatomic, strong) UITextField *replyTextField;

@end

@implementation GeeQuickReplyView



- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIView *back = [[UIView alloc]init];
        [self addSubview:back];
        back.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
        self.replyBackView = back;
        
        UITextField *replyField = [[UITextField alloc]init];
        [back addSubview:replyField];
        [replyField.layer setMasksToBounds:YES];
        [replyField.layer setCornerRadius:5];
        [replyField.layer setBorderColor:[UIColor colorFromHexRGB:@"7f7f7f"].CGColor];
        [replyField.layer setBorderWidth:1];
        replyField.backgroundColor = [UIColor whiteColor];
        self.replyTextField = replyField;
        replyField.placeholder = @"作者这么辛苦，给他留句话呗!";
        replyField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 1)];
        replyField.leftViewMode = UITextFieldViewModeAlways;
        replyField.returnKeyType = UIReturnKeySend;
        replyField.delegate = self;
        
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureTapped)];
        [self addGestureRecognizer:tap];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}


- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.replyBackView.frame = CGRectMake(0, ScreenHeight-keyBoardFrame.size.height-40, ScreenWidth, 40);
    }];
}


-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self removeFromSuperview];
}


- (void)tapGestureTapped
{
    [self removeFromSuperview];
}


- (void)layoutSubviews
{
    self.frame = [UIScreen mainScreen].bounds;
    
    self.replyBackView.frame = CGRectMake(0, self.frame.size.height+40, ScreenWidth, 40);
    self.replyTextField.frame = CGRectMake(10, 5, self.replyBackView.frame.size.width-2*10, 30);
    
    [self.replyTextField becomeFirstResponder];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        if (self.sendButtonClicked) {
            self.sendButtonClicked(textField.text);
        }
    }
    
    [self removeFromSuperview];
    return YES;
}

@end
