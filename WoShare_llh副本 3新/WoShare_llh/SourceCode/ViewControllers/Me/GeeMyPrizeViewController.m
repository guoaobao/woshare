//
//  GeeMyPrizeViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/27.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeMyPrizeViewController.h"
#import "GeeMyPrizeTableViewCell.h"

@interface GeeMyPrizeViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation GeeMyPrizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的奖品";
    [self setupViewOfController];
    [self setNavBackButton];
}

- (void)setupViewOfController
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
}

#pragma mark -- UITableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeeMyPrizeTableViewCell *cell = [GeeMyPrizeTableViewCell cellForTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 143.3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

@end
