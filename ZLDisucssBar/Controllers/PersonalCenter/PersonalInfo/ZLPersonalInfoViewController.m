//
//  ZLPersonalInfoViewController.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/17.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPersonalInfoViewController.h"

@interface ZLPersonalInfoViewController ()

@end

@implementation ZLPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.title) {
        self.title = @"个人信息";
    }
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)loadUserInfomation{
    [[ZLNetworkManager sharedInstence]getUserInfoWithUid:self.uid block:^(NSDictionary *dict) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
