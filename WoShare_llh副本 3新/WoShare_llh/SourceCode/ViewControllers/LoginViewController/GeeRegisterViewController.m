//
//  GeeRegisterViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/22.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeRegisterViewController.h"
#import "NSString+CaculateSize.h"
#import "GeeLoginViewController.h"

#import "RequestManager.h"
#import "MBProgressHUD.h"

@interface GeeRegisterViewController () <RequestManagerDelegate>

@property(nonatomic, strong) UIButton *getcaptchaButton;
@property(nonatomic, assign) int timeCount;

@property(nonatomic, strong) UITextField *accountField;
@property(nonatomic, strong) UITextField *pswField;
@property(nonatomic, strong) UITextField *captchaField;

@end

@implementation GeeRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    self.timeCount = 0;
    [self setNavBackButton];
    [self setupViewOfController];
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
}



- (void)setupViewOfController
{
    UIView *inputBackView = [[UIView alloc]init];
    inputBackView.frame = CGRectMake(20, 20, ScreenWidth-2*20, 100);
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
    
    UIView *line = [[UIView alloc]init];
    line.frame = CGRectMake(0, inputBackView.frame.size.height/2, inputBackView.frame.size.width, 0.5);
    line.backgroundColor = [UIColor lightGrayColor];
    [inputBackView addSubview:line];
    
    UITextField *captchaField = [[UITextField alloc]init];
    captchaField.frame = CGRectMake(20, CGRectGetMaxY(inputBackView.frame)+10, (inputBackView.frame.size.width-10)*0.6, 40);
    [self.view addSubview:captchaField];
    [captchaField.layer setMasksToBounds:YES];
    [captchaField.layer setCornerRadius:2];
    captchaField.placeholder = @"输入验证码";
    captchaField.backgroundColor = [UIColor whiteColor];
    captchaField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 1)];
    captchaField.leftViewMode = UITextFieldViewModeAlways;
    self.captchaField = captchaField;
    captchaField.keyboardType = UIKeyboardTypePhonePad;
    
    UIButton *getCaptchaButton = [[UIButton alloc]init];
    getCaptchaButton.frame = CGRectMake(CGRectGetMaxX(captchaField.frame)+10, captchaField.frame.origin.y, (inputBackView.frame.size.width-10)*0.4, 40);
    [getCaptchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCaptchaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCaptchaButton.backgroundColor = [UIColor colorFromHexRGB:@"fda72e"];
    [getCaptchaButton.layer setMasksToBounds:YES];
    [getCaptchaButton.layer setCornerRadius:2];
    [self.view addSubview:getCaptchaButton];
    [getCaptchaButton addTarget:self action:@selector(getCaptcha) forControlEvents:UIControlEventTouchUpInside];
    getCaptchaButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.getcaptchaButton = getCaptchaButton;
    
    UIButton *registerButton = [[UIButton alloc]init];
    registerButton.frame = CGRectMake(20, CGRectGetMaxY(captchaField.frame)+40, ScreenWidth-2*20, 40);
    [registerButton setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateHighlighted];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:2];
    [registerButton addTarget:self action:@selector(registerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    UILabel *tipsLabel = [[UILabel alloc]init];
    tipsLabel.text = @"已有账户？";
    tipsLabel.font = [UIFont systemFontOfSize:15];
    CGSize labelsize = [tipsLabel.text caculateSizeByFont:tipsLabel.font];
    tipsLabel.textColor = [UIColor blackColor];
    [self.view addSubview:tipsLabel];
    
    UIButton *loginButton = [[UIButton alloc]init];
    NSString *loginText = @"登录";
    [loginButton setTitle:loginText forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_barbackground"]] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    CGSize loginsize = [loginText caculateSizeByFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:loginButton];
    [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat length = labelsize.width+loginsize.width+10;
    tipsLabel.frame = CGRectMake(ScreenWidth/2-length/2, CGRectGetMaxY(registerButton.frame)+20, labelsize.width, labelsize.height);
    loginButton.frame = CGRectMake(CGRectGetMaxX(tipsLabel.frame), tipsLabel.frame.origin.y, loginsize.width+10, loginsize.height);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)loginButtonClicked
{
    GeeLoginViewController *vc = [[GeeLoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getCaptcha
{
    if (self.accountField.text.length==0) {
        [self toast:@"请输入手机号"];
        return;
    }
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"mobile"] = self.accountField.text;
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeSendCaptcha withData:dict];
    
    [self showIndicator];
    
    self.getcaptchaButton.enabled = NO;
    [self performSelector:@selector(getCaptchaEnable) withObject:nil afterDelay:1];
    self.timeCount = 30;
    
    NSString *str = [NSString stringWithFormat:@"%ds后重发",self.timeCount];
    [self.getcaptchaButton setTitle:str forState:UIControlStateNormal];
    
    [self.view endEditing:YES];
}

- (void)getCaptchaEnable
{
    if (self.timeCount > 1) {
        self.timeCount--;
        
        NSString *str = [NSString stringWithFormat:@"%ds后重发",self.timeCount];
        [self.getcaptchaButton setTitle:str forState:UIControlStateNormal];
        
        [self performSelector:@selector(getCaptchaEnable) withObject:nil afterDelay:1];
    } else {
        [self.getcaptchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getcaptchaButton.enabled = YES;
    }
    
}

- (void)exitRegister
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- RequestManager代理

#pragma mark request callback
-(void)webServiceRequest:(RequestType)requestType response:(id)response userData:(id)userData originalData:(id)data
{
    if (requestType == kRequestTypeSendCaptcha) {
        [self toast:@"验证码发送成功"];
    } else if (requestType == kRequestTypeRegister) {
        [self toast:@"注册成功"];
        
        [self performSelector:@selector(exitRegister) withObject:nil afterDelay:1];
    }
    
    [self hideIndicator];
}


- (void)webServiceRequest:(RequestType)requestType error:(NSError *)error userData:(id)userData
{
    [self hideIndicator];
    
    if (requestType == kRequestTypeSendCaptcha) {
        [self toast:@"获取验证码失败"];
        self.timeCount = 1;
    } else if (requestType == kRequestTypeRegister) {
        [self toast:@"注册失败"];
        
    }
    
}

- (void)webServiceRequest:(RequestType)requestType errorString:(NSString *)errorString userData:(id)userData
{
    [self hideIndicator];
    
    [self toast:errorString];
    
    if (requestType == kRequestTypeSendCaptcha) {
        
        self.timeCount = 1;
    } else if (requestType == kRequestTypeRegister) {
        
    }
}

- (void)registerBtnClicked
{
    if (self.accountField.text.length == 0) {
        [self toast:@"请输入账号"];
        return;
    }
    
    if (self.pswField.text.length == 0) {
        [self toast:@"请输入密码"];
        return;
    }
    
    if (self.captchaField.text.length == 0) {
        [self toast:@"请输入验证码"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"mobile"] = self.accountField.text;
    dict[@"password"] = self.pswField.text;
    dict[@"captcha"] = self.captchaField.text;
    
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeRegister withData:dict];
    
    [self showIndicator];
    
    [self.view endEditing:YES];
}

@end
