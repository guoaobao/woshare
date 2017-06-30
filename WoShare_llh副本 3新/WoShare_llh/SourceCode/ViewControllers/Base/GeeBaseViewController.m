//
//  GeeBaseViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/21.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeBaseViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface GeeBaseViewController ()

@property(nonatomic, assign) CGFloat offectValue;

@property(nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation GeeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavBackButton
{
    UIButton *back = [[UIButton alloc]init];
    [back setImage:[UIImage imageNamed:@"back-arrow"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(navBackButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    back.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = item;
    
    
}

- (void)navBackButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [self hideIndicator];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIView *view = [self.view findFirstResponder];
    if (view != nil) {
        
        
        CGRect viewRect = [view convertRect:view.bounds toView:nil];
        BOOL ishidden = self.navigationController.navigationBar.hidden || self.navigationController == nil;
        
        CGFloat maxY = (viewRect.origin.y+viewRect.size.height);
        if (maxY > CGRectGetMaxY(self.view.frame)) {
            maxY = CGRectGetMaxY(self.view.frame);
        }
        
        CGFloat oy = self.view.frame.origin.y-(maxY+keyBoardFrame.size.height-ScreenHeight);
        if (oy > (ishidden?0:64)) {
            oy = (ishidden?0:64);
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.frame = CGRectMake(self.view.frame.origin.x, oy, self.view.frame.size.width, self.view.frame.size.height);
        }];
        
    }
}




-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.3 animations:^{
        BOOL ishidden = self.navigationController.navigationBar.hidden || self.navigationController == nil;
        self.view.frame = CGRectMake(self.view.frame.origin.x, ishidden?0:64, self.view.frame.size.width, self.view.frame.size.height);
    }];
    self.offectValue = 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)showIndicator
{
    if (!_HUD)
    {
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[AppDelegate sharedAppDelegate].window];
        self.HUD = HUD;
    }
    
    [[AppDelegate sharedAppDelegate].window addSubview:_HUD];
    [_HUD show:YES];
    [_HUD setUserInteractionEnabled:NO];
}

- (void)hideIndicator
{
    [self.HUD hide:YES];
    [self.HUD removeFromSuperview];
    self.HUD = nil;
}

- (void)toast:(NSString *)string
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.labelText = string;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}


@end
