//
//  ZLPersonalCenter.m
//  ZLDisucssBar
//
//  Created by 赵新 on 16/4/28.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPersonalCenter.h"
#import "ZLPersonalCenterView.h"
#import "ZLPersonalCenterCell.h"
#import "ZLSettingViewController.h"
#import "ZLPersonalInfoViewController.h"

@interface ZLPersonalCenter ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong) ZLPersonalCenterView *header;

@property (nonatomic ,strong) UITableView          *mainTableView;

@end

@implementation ZLPersonalCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.header = [[ZLPersonalCenterView alloc]initWithFrame:CGRectMake(0, 0, ScreenHeight, 190)];

    [self initData];
    [self initHeader];
    [self creatConstomUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initHeader];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)initHeader{
    NSString *userID = [[ZLUserInfo sharedInstence] userUID];
    if (userID.length > 0) {
        //已登录
        [[ZLNetworkManager sharedInstence]getUserInfoWithUid:[ZLUserInfo sharedInstence].userUID block:^(NSDictionary *dict) {
            [self.header updateInfoWithDict:dict];
        } failure:^(NSError *error) {
            
        }];
    }else{
        //未登录
        [self.header updateInfoWithDict:nil];
    }
}

- (void)initData{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"UserLoginNotification" object:nil]subscribeNext:^(id x) {
        [self initHeader];
    }];
}

- (void)creatConstomUI{
    self.mainTableView                = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight - 29)];
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.rowHeight      = 45;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ZLPersonalCenterCell" bundle:nil] forCellReuseIdentifier:@"personalCell"];
    
    [self.mainTableView setTableHeaderView:self.header];
    [self.view addSubview:self.mainTableView];
}

#pragma mark - **************** TableViewDelegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLPersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personalCell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"个人信息";
            cell.icon.image      = [UIImage imageNamed:@"person"];
            break;
        case 1:
            cell.titleLabel.text = @"我的帖子";
            cell.icon.image      = [UIImage imageNamed:@"post"];
            break;
        case 2:
            cell.titleLabel.text = @"我的消息";
            cell.icon.image      = [UIImage imageNamed:@"message"];
            break;
        case 3:
            cell.titleLabel.text = @"我的回帖";
            cell.icon.image      = [UIImage imageNamed:@"repost"];
            break;
        case 4:
            cell.titleLabel.text = @"设置";
            cell.icon.image      = [UIImage imageNamed:@"setting"];
            break;
        case 5:
            cell.titleLabel.text = @"更多";
            cell.icon.image      = [UIImage imageNamed:@"more"];
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            ZLPersonalInfoViewController *person = [[ZLPersonalInfoViewController alloc]init];
            person.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:person animated:YES];
        }
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:{
            ZLSettingViewController *setting = [[ZLSettingViewController alloc]init];
            setting.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setting animated:YES];
        }
            
            break;
        case 5:
            
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
