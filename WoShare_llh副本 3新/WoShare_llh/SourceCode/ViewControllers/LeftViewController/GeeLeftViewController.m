//
//  GeeLeftViewController.m
//  woshare
//
//  Created by 陆利刚 on 16/6/20.
//  Copyright © 2016年 胡波. All rights reserved.
//

#import "GeeLeftViewController.h"
#import "GeeLeftTableViewCell.h"

#import "GeeMeViewController.h"
#import "AppDelegate.h"
#import "GeeActivitySquareViewController.h"
#import "GeeSettingViewController.h"
#import "RequestManager.h"
#import "GeeLoginViewController.h"
#import "GeeBaseShareSquareViewController.h"

#import "GeeMyVedioViewController.h"
#import "GeeMyPictureViewController.h"
#import "HnUnicomSelectedViewController.h"

@interface GeeLeftViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *contentNameArray;
@property(nonatomic, strong) NSArray *contentIconArray;

@end

@implementation GeeLeftViewController

static GeeLeftViewController *manager = nil;

+ (GeeLeftViewController *)shareManager
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [[GeeLeftViewController alloc]init];
    });
    return manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.contentNameArray = @[@"F4沃拍",@"我的视频",@"我的图片",@"精选",/*@"活动广场",*/@"我",@"设置"];
    self.contentIconArray = @[@"icon-searching",@"icon-myVedio",@"icon-myPic",@"icon-hnltSelect",/*@"icon-actSqure",*/@"icon-me",@"icon-setting"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViewOfController];
}



- (void)setupViewOfController
{
    UITableView *tableview = [[UITableView alloc]init];
    self.tableView = tableview;
    [self.view addSubview:tableview];
    tableview.frame = self.view.bounds;
    tableview.backgroundColor = [UIColor colorFromHexRGB:@"314159"];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark -- tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentIconArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeeLeftTableViewCell *cell = [GeeLeftTableViewCell cellForTableView:tableView];
    
    cell.cellName = [self.contentNameArray objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell.rightCellIcon = [self.contentIconArray objectAtIndex:indexPath.row];
    } else {
        cell.leftCellIcon = [self.contentIconArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 64;
    } else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        
        GeeMyVedioViewController *myvedio = [[GeeMyVedioViewController alloc]init];
        
        
        if (![RequestManager sharedManager].isLogined) {
            
            [[AppDelegate sharedAppDelegate] showLoginFrom:[AppDelegate sharedAppDelegate].rootNavController successToViewController:myvedio];
            [[AppDelegate sharedAppDelegate].sideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
            return;
        }
        
        [[AppDelegate sharedAppDelegate].rootNavController pushViewController:myvedio animated:YES];
        [[AppDelegate sharedAppDelegate].sideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
        
    } else if (indexPath.row == 2) {
        
        GeeMyPictureViewController *mypic = [[GeeMyPictureViewController alloc]init];
        
        if (![RequestManager sharedManager].isLogined) {
            
            [[AppDelegate sharedAppDelegate] showLoginFrom:[AppDelegate sharedAppDelegate].rootNavController successToViewController:mypic];
            [[AppDelegate sharedAppDelegate].sideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
            return;
        }
        
        [[AppDelegate sharedAppDelegate].rootNavController pushViewController:mypic animated:YES];
        [[AppDelegate sharedAppDelegate].sideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];

        
    } else if (indexPath.row == 3) {
        
        HnUnicomSelectedViewController *vc = [[HnUnicomSelectedViewController alloc]init];
        
        [[AppDelegate sharedAppDelegate].rootNavController pushViewController:vc animated:YES];
        [[AppDelegate sharedAppDelegate].sideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];

    } /*else if (indexPath.row == 4) {
        
        GeeActivitySquareViewController *square = [[GeeActivitySquareViewController alloc]init];
        [[AppDelegate sharedAppDelegate].rootNavController pushViewController:square animated:YES];
        [[AppDelegate sharedAppDelegate].sideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
        
    } */else if (indexPath.row == 5-1) {
        
        GeeMeViewController *me = [[GeeMeViewController alloc]init];
        
        if (![RequestManager sharedManager].isLogined) {
            
            [[AppDelegate sharedAppDelegate] showLoginFrom:[AppDelegate sharedAppDelegate].rootNavController successToViewController:me];
            [[AppDelegate sharedAppDelegate].sideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
            return;
        }
        
        [[AppDelegate sharedAppDelegate].rootNavController pushViewController:me animated:YES];
        [[AppDelegate sharedAppDelegate].sideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
        
    } else if (indexPath.row == 6-1) {
        
        GeeSettingViewController *setting = [[GeeSettingViewController alloc]init];
        [[AppDelegate sharedAppDelegate].rootNavController pushViewController:setting animated:YES];
        [[AppDelegate sharedAppDelegate].sideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
        
    }
}

@end
