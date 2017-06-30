//
//  GeeShowGifViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/27.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeShowGifViewController.h"
#import "UIImage+GIF.h"

@interface GeeShowGifViewController ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) NSMutableData *imageData;
@property(nonatomic, assign) NSInteger length;

@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation GeeShowGifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.imageData = [NSMutableData data];
    
    [self setupViewOfController];
}

- (void)setupViewOfController
{
    
    UIImageView *imaegView = [[UIImageView alloc]init];
    self.imageView = imaegView;
    [self.view addSubview:imaegView];
    imaegView.frame = self.view.bounds;
    imaegView.contentMode = UIViewContentModeScaleAspectFit;
//    imaegView.image = [UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.gifUrl]]];
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]init];
    self.indicatorView = indicatorView;
    indicatorView.frame = CGRectMake(0, 0, 40, 40);
    indicatorView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:indicatorView];
    [indicatorView startAnimating];
    
    //请求
    NSURL *url = [NSURL URLWithString:self.gifUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //连接
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    UIButton *back = [[UIButton alloc]init];
    [back setImage:[UIImage imageNamed:@"hs_last_backpic"] forState:UIControlStateNormal];
    back.frame = CGRectMake(20, 25, 46, 34);
    [self.view addSubview:back];
    [back addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
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

- (void)backButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


//响应头
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //清空图片数据
    [_imageData setLength:0];
    //强制转换
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    _length = [[resp.allHeaderFields objectForKey:@"Content-Length"] floatValue];
    //设置状态栏接收数据状态
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

//响应体
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_imageData appendData:data];//拼接响应数据
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.indicatorView stopAnimating];
    [self.indicatorView removeFromSuperview];
    self.imageView.image = [UIImage sd_animatedGIFWithData:_imageData];
    //设置状态栏
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
