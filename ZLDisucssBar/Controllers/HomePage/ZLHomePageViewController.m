//
//  ZLHomePageViewController.m
//  ZLDisucssBar
//
//  Created by 赵新 on 16/4/28.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLHomePageViewController.h"

@interface ZLHomePageViewController ()

@end

@implementation ZLHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self test];
}

- (void)test{
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    [self.navigationItem setLeftBarButtonItem:left];
}

- (void)login{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ZLLogin" bundle:[NSBundle mainBundle]];
    UINavigationController *navi = [sb instantiateInitialViewController];
    [self.navigationController presentViewController:navi animated:YES completion:^{
        
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
