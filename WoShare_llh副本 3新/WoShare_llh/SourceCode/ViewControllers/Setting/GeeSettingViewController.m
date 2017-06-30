//
//  GeeSettingViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/24.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeSettingViewController.h"
#import "SDImageCache.h"

@interface GeeSettingViewController () <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property(nonatomic, strong) NSArray *settingsArray;

@end

@implementation GeeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.settingsArray = @[@"版本信息",@"清理缓存",@"关于"];
    
    [self setupViewOfController];
    [self setNavBackButton];
    self.title = @"设置";
}

- (void)setupViewOfController
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    tableView.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark -- UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.settingsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text = [self.settingsArray objectAtIndex:indexPath.section];
    
    if (indexPath.section == 0) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"V1.0";
        label.frame = CGRectMake(0, 0, 40, 40);
        label.textColor = [UIColor colorFromHexRGB:@"646464"];
        
        cell.accessoryView = label;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.textColor = [UIColor colorFromHexRGB:@"646464"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清理" otherButtonTitles:nil];
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
        
    }
}

#pragma mark -- UIActionSheet代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDisk];
        
        [self showIndicator];
        [self performSelector:@selector(hideClearAnimate) withObject:nil afterDelay:1];
    }
}

- (void)hideClearAnimate
{
    [self hideIndicator];
    [self toast:@"清理完成"];
}
@end
