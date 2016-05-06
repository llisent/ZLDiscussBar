//
//  ZLPersonalCenter.m
//  ZLDisucssBar
//
//  Created by 赵新 on 16/4/28.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPersonalCenter.h"
#import "ZLPersonalCenterView.h"

@interface ZLPersonalCenter ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong) ZLPersonalCenterView *header;

@property (nonatomic ,strong) UITableView *mainTableView;

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
    self.mainTableView.rowHeight      = 50;
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
//    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView setTableHeaderView:self.header];
    [self.view addSubview:self.mainTableView];
}

#pragma mark - **************** TableViewDelegate & DataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"个人信息";
            break;
        case 1:
            cell.textLabel.text = @"我的帖子";
            break;
        case 2:
            cell.textLabel.text = @"我的消息";
            break;
        case 3:
            cell.textLabel.text = @"我的回帖";
            break;
        case 4:
            cell.textLabel.text = @"设置";
            break;
        case 5:
            cell.textLabel.text = @"更多";
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
