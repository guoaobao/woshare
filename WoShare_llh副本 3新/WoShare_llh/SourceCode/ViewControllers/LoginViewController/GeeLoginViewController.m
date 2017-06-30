//
//  GeeLoginViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/21.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeLoginViewController.h"
#import "GeeRegisterViewController.h"
#import "GeeFindPwdViewController.h"
#import "RequestManager.h"
#import "AppDelegate.h"
#import "GeeMeViewController.h"

#define GeeLoginAccountKey              @"GeeLoginAccountKey"
#define GeeLoginPassWordKey             @"GeeLoginPassWordKey"

@interface GeeLoginViewController () <RequestManagerDelegate>

@property(nonatomic, strong) UITextField *accountField;
@property(nonatomic, strong) UITextField *pswField;

@end

@implementation GeeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupViewOfController];
}

- (void)setupViewOfController
{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.view addSubview:imageView];
    imageView.frame = self.view.bounds;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.image = [UIImage imageNamed:@"back-login"];
    
    UIButton *backButton = [[UIButton alloc]init];
    [backButton setImage:[UIImage imageNamed:@"back-arrow"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(20, 27, 30, 30);
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *logoView = [[UIImageView alloc]init];
    logoView.frame = CGRectMake(ScreenWidth/2-100/2, 64, 100, 100);
    logoView.image = [UIImage imageNamed:@"gab"];
    [self.view addSubview:logoView];
    
    UIView *inputBackView = [[UIView alloc]init];
    inputBackView.frame = CGRectMake(20, CGRectGetMaxY(logoView.frame)+30, ScreenWidth-2*20, 100);
    inputBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:inputBackView];
    [inputBackView.layer setMasksToBounds:YES];
    [inputBackView.layer setCornerRadius:3];
    
    UITextField *mobileField = [[UITextField alloc]init];
    mobileField.frame = CGRectMake(0, 0, inputBackView.frame.size.width, inputBackView.frame.size.height/2);
    [inputBackView addSubview:mobileField];
    UIView *mobileLeftView = [[UIView alloc]init];
    mobileLeftView.frame = CGRectMake(0, 0, 40, 20);
    UIImageView *mobileImage = [[UIImageView alloc]init];
    mobileImage.image = [UIImage imageNamed:@"login_icon_accounts"];
    mobileImage.contentMode = UIViewContentModeScaleAspectFit;
    mobileImage.frame = CGRectMake(10, 0, 20, 20);
    [mobileLeftView addSubview:mobileImage];
    mobileField.leftView = mobileLeftView;
    mobileField.leftViewMode = UITextFieldViewModeAlways;
    mobileField.placeholder = @"输入手机号";
    mobileField.keyboardType = UIKeyboardTypePhonePad;
    self.accountField = mobileField;
    mobileField.text = [[NSUserDefaults standardUserDefaults]objectForKey:GeeLoginAccountKey]?:@"";
    
    UITextField *passwordField = [[UITextField alloc]init];
    passwordField.frame = CGRectMake(0, inputBackView.frame.size.height/2, inputBackView.frame.size.width, inputBackView.frame.size.height/2);
    [inputBackView addSubview:passwordField];
    UIView *passwordLeftView = [[UIView alloc]init];
    passwordLeftView.frame = CGRectMake(0, 0, 40, 20);
    UIImageView *passwordImage = [[UIImageView alloc]init];
    passwordImage.image = [UIImage imageNamed:@"login_icon_password"];
    passwordImage.contentMode = UIViewContentModeScaleAspectFit;
    passwordImage.frame = CGRectMake(10, 0, 20, 20);
    [passwordLeftView addSubview:passwordImage];
    passwordField.leftView = passwordLeftView;
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    passwordField.placeholder = @"输入密码";
    self.pswField = passwordField;
    passwordField.secureTextEntry = YES;
    passwordField.text = [[NSUserDefaults standardUserDefaults]objectForKey:GeeLoginPassWordKey]?:@"";
    
    UIView *line = [[UIView alloc]init];
    line.frame = CGRectMake(0, inputBackView.frame.size.height/2, inputBackView.frame.size.width, 0.5);
    line.backgroundColor = [UIColor lightGrayColor];
    [inputBackView addSubview:line];
    
    
    UIButton *loginButton = [[UIButton alloc]init];
    loginButton.frame = CGRectMake(20, CGRectGetMaxY(inputBackView.frame)+40, ScreenWidth-2*20, 40);
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:3];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateHighlighted];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *registerButton = [[UIButton alloc]init];
    registerButton.frame = CGRectMake(20, CGRectGetMaxY(loginButton.frame)+10, 100, 30);
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:registerButton];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerButton addTarget:self action:@selector(registerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *forgetButton = [[UIButton alloc]init];
    forgetButton.frame = CGRectMake(CGRectGetMaxX(loginButton.frame)-100, CGRectGetMaxY(loginButton.frame)+10, 100, 30);
    [forgetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:forgetButton];
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [forgetButton addTarget:self action:@selector(findPwdButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)registerButtonClicked
{
    GeeRegisterViewController *vc = [[GeeRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)findPwdButtonClicked
{
    GeeFindPwdViewController *vc = [[GeeFindPwdViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backButtonClicked
{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}



- (void)loginButtonClicked
{
    [[RequestManager sharedManager]addDelegate:self];//添加代理
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"mobile"] = self.accountField.text;
    dict[@"password"] = self.pswField.text;
    [[RequestManager sharedManager] startRequestWithType:kRequestTypeLogin withData:dict];
    
    [self showIndicator];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:self.accountField.text forKey:GeeLoginAccountKey];
    [[NSUserDefaults standardUserDefaults] setObject:self.pswField.text forKey:GeeLoginPassWordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)webServiceRequest:(RequestType)requestType response:(id)response userData:(id)userData originalData:(id)data
{
    if (requestType == kRequestTypeLogin) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogin object:nil];
        [self dismissViewControllerAnimated:YES completion:^{
            
            if (self.objViewController) {
                [[AppDelegate sharedAppDelegate].rootNavController pushViewController:self.objViewController animated:YES];
            }
            
        }];
        
        
    }
    
    [self hideIndicator];
}
- (void)webServiceRequest:(RequestType)requestType error:(NSError *)error userData:(id)userData
{
    [self hideIndicator];
    
    [self toast:@"登录失败"];
}

- (void)webServiceRequest:(RequestType)requestType errorString:(NSString *)errorString userData:(id)userData
{
    [self hideIndicator];
    [self toast:errorString];
}

@end
