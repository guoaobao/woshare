//
//  GeeMeViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/23.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeMeViewController.h"
#import "GeeMeHeaderView.h"
#import "GeeMeTableViewCell.h"
#import "GeeMyPrizeViewController.h"
#import "UserInfoResponse.h"
#import "UIImageView+WebCache.h"
#import "RequestManager.h"

#import "GeeMyVedioViewController.h"
#import "GeeMyPictureViewController.h"
#import "GeeMyCollectionViewController.h"

@interface GeeMeViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSArray *iconArray;


@end

@implementation GeeMeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleArray = @[@"我的视频",@"我的图片",/*@"我的奖品",*/@"我的收藏"];
        self.iconArray = @[@"icon我的视频",@"icon我的图片",/*@"icon我的奖品",*/@"icon-我的收藏"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我";
    [self setNavBackButton];
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
    
    [self setupViewOfController];
}

- (void)setupViewOfController
{
    UITableView *tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
    
    GeeMeHeaderView *header = [[GeeMeHeaderView alloc]init];
    tableView.tableHeaderView = header;
    
    UIView *footBack = [[UIView alloc]init];
    footBack.frame = CGRectMake(0, 0, ScreenWidth, 140);
    UIButton *exitButton = [[UIButton alloc]init];
    exitButton.backgroundColor = [UIColor colorFromHexRGB:@"fc0d1b"];
    [exitButton.layer setMasksToBounds:YES];
    [exitButton.layer setCornerRadius:2];
    exitButton.frame = CGRectMake(10, 60, ScreenWidth-2*10, 40);
    [footBack addSubview:exitButton];
    [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    exitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [exitButton addTarget:self action:@selector(exitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    exitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    tableView.tableFooterView = footBack;
}

- (void)exitButtonClicked
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出" otherButtonTitles:nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark -- AcitonSheet代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //退出
        NSLog(@"退出");
        
        [self.navigationController popViewControllerAnimated:YES];
        [[RequestManager sharedManager] logout];
        [Config removeLocToken];
    } else {
        
    }
}


#pragma mark -- UITableViewDelegate代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeeMeTableViewCell *cell = [GeeMeTableViewCell cellForTableView:tableView];
    cell.imageName = [self.iconArray objectAtIndex:indexPath.row];
    cell.functionName = [self.titleArray objectAtIndex:indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        GeeMyVedioViewController *myvedio = [[GeeMyVedioViewController alloc]init];
        [self.navigationController pushViewController:myvedio animated:YES];
    } else if (indexPath.row == 1) {
        GeeMyPictureViewController *mypicture = [[GeeMyPictureViewController alloc]init];
        [self.navigationController pushViewController:mypicture animated:YES];
    }/* else if (indexPath.row == 2) {
        GeeMyPrizeViewController *vc = [[GeeMyPrizeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } */else if (indexPath.row == 3-1) {
        GeeMyCollectionViewController *vc = [[GeeMyCollectionViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
