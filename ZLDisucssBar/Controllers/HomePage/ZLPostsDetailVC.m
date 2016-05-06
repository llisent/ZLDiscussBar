//
//  ZLPostsDetailVC.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/6.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPostsDetailVC.h"

@interface ZLPostsDetailVC ()

@property (nonatomic ,strong) UITableView *mainTableView;

@end

@implementation ZLPostsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)creatConstomUI{
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
