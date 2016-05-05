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
    [self initHeader];
}

- (void)initHeader{
//    self.header = [[ZLPersonalCenterView alloc]initWithFrame:CGRectMake(0, 0, ScreenHeight, 182)];
    [[ZLNetworkManager sharedInstence]getUserInfoWithUid:[ZLUserInfo sharedInstence].userUID block:^(NSDictionary *dict) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)initData{
    
}

- (void)creatConstomUI{
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49)];
    [self.mainTableView setTableHeaderView:self.header];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
