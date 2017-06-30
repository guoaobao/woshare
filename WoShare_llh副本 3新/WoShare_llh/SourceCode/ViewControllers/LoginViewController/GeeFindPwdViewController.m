//
//  GeeFindPwdViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/22.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeFindPwdViewController.h"
#import "RequestManager.h"


@interface GeeFindPwdViewController () <RequestManagerDelegate>

@property(nonatomic, strong) UITextField *accountField;
@property(nonatomic, strong) UITextField *passwordField;
@property(nonatomic, strong) UITextField *surepswField;
@property(nonatomic, strong) UITextField *captchaField;
@property(nonatomic, strong) UIButton *getcaptchaButton;

@property(nonatomic, assign) int timeCount;

@end

@implementation GeeFindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"找回密码";
    
    [self setNavBackButton];
    [self setupViewOfController];
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
}



- (void)setupViewOfController
{
    UIView *inputBackView = [[UIView alloc]init];
    inputBackView.frame = CGRectMake(20, 20, ScreenWidth-2*20, 150);
    inputBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:inputBackView];
    [inputBackView.layer setMasksToBounds:YES];
    [inputBackView.layer setCornerRadius:3];
    
    UITextField *mobileField = [[UITextField alloc]init];
    mobileField.frame = CGRectMake(0, 0, inputBackView.frame.size.width, inputBackView.frame.size.height/3);
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
    passwordField.frame = CGRectMake(0, inputBackView.frame.size.height/3, inputBackView.frame.size.width, inputBackView.frame.size.height/3);
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
    passwordField.placeholder = @"新密码";
    self.passwordField = passwordField;
    passwordField.secureTextEntry = YES;
    
    UIView *line = [[UIView alloc]init];
    line.frame = CGRectMake(0, inputBackView.frame.size.height/3, inputBackView.frame.size.width, 0.5);
    line.backgroundColor = [UIColor lightGrayColor];
    [inputBackView addSubview:line];
    
    UITextField *passwordField2 = [[UITextField alloc]init];
    passwordField2.frame = CGRectMake(0, inputBackView.frame.size.height/3*2, inputBackView.frame.size.width, inputBackView.frame.size.height/3);
    [inputBackView addSubview:passwordField2];
    UIView *passwordLeftView2 = [[UIView alloc]init];
    passwordLeftView2.frame = CGRectMake(0, 0, 40, 20);
    UIImageView *passwordImage2 = [[UIImageView alloc]init];
    passwordImage2.image = [UIImage imageNamed:@"login_icon_password"];
    passwordImage2.contentMode = UIViewContentModeScaleAspectFit;
    passwordImage2.frame = CGRectMake(10, 0, 20, 20);
    [passwordLeftView2 addSubview:passwordImage2];
    passwordField2.leftView = passwordLeftView2;
    passwordField2.leftViewMode = UITextFieldViewModeAlways;
    passwordField2.placeholder = @"确认新密码";
    self.surepswField = passwordField2;
    passwordField2.secureTextEntry = YES;
    
    UIView *line2 = [[UIView alloc]init];
    line2.frame = CGRectMake(0, inputBackView.frame.size.height/3*2, inputBackView.frame.size.width, 0.5);
    line2.backgroundColor = [UIColor lightGrayColor];
    [inputBackView addSubview:line2];
    
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
    
    UIButton *getCaptchaButton = [[UIButton alloc]init];
    getCaptchaButton.frame = CGRectMake(CGRectGetMaxX(captchaField.frame)+10, captchaField.frame.origin.y, (inputBackView.frame.size.width-10)*0.4, 40);
    [getCaptchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCaptchaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCaptchaButton.backgroundColor = [UIColor colorFromHexRGB:@"fda72e"];
    [getCaptchaButton.layer setMasksToBounds:YES];
    [getCaptchaButton.layer setCornerRadius:2];
    [self.view addSubview:getCaptchaButton];
    getCaptchaButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.getcaptchaButton = getCaptchaButton;
    [getCaptchaButton addTarget:self action:@selector(getCaptcha) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registerButton = [[UIButton alloc]init];
    registerButton.frame = CGRectMake(20, CGRectGetMaxY(captchaField.frame)+40, ScreenWidth-2*20, 40);
    [registerButton setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateHighlighted];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:2];
    [registerButton addTarget:self action:@selector(registerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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

- (void)registerButtonClicked
{
    if (self.accountField.text.length == 0) {
        [self toast:@"请输入手机号"];
        return;
    }
    
    if (self.passwordField.text.length == 0) {
        [self toast:@"请输入密码"];
        return;
    }
    
    if (![self.surepswField.text isEqualToString:self.passwordField.text]) {
        [self toast:@"两次输入密码不一致"];
        return;
    }
    
    if (self.captchaField.text.length == 0) {
        [self toast:@"请输入验证码"];
        return;
    }
    
    [self.view endEditing:YES];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"mobile"] = self.accountField.text;
    dict[@"newpassword"] = self.passwordField.text;
    dict[@"captcha"] = self.captchaField.text;
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeFindPassWord withData:dict];
    
    [self showIndicator];
}


#pragma mark -- RequestManager代理
- (void)webServiceRequest:(RequestType)requestType errorString:(NSString *)errorString userData:(id)userData
{
    [self hideIndicator];
    [self toast:errorString];
}

- (void)webServiceRequest:(RequestType)requestType error:(NSError *)error userData:(id)userData
{
    [self hideIndicator];
    
    if (requestType == kRequestTypeSendCaptcha) {
        [self toast:@"获取验证码失败"];
        self.timeCount = 1;
    } else if (requestType == kRequestTypeFindPassWord) {
        [self toast:@"找回密码失败"];
        
    }
}

- (void)webServiceRequest:(RequestType)requestType response:(id)response userData:(id)userData originalData:(id)data
{
    [self hideIndicator];
    
    if (requestType == kRequestTypeSendCaptcha) {

    } else if (requestType == kRequestTypeFindPassWord) {
        [self toast:@"找回密码成功"];
        
        [self performSelector:@selector(exitFindPassword) withObject:nil afterDelay:1];
    }
}


- (void)exitFindPassword
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
