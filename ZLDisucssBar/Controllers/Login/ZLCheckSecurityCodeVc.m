//
//  ZLCheckSecurityCodeVc.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLCheckSecurityCodeVc.h"

@interface ZLCheckSecurityCodeVc ()

@end

@implementation ZLCheckSecurityCodeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatConstomUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)creatConstomUI{
    self.securityCodeImageView.image = self.securityImg;
}

- (IBAction)loginNow:(id)sender {
    NSString *codStr = [self.securityCodeTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = [NSString stringWithFormat:@"http://www.zuanke8.com/api/mobile/index.php?loginsubmit=yes&charset=utf-8&secqaahash=%@&loginfield=auto&seccodehash=%@&seccodeverify=%@&sechash=%@&module=login&mobile=no&version=3",self.sechash,self.sechash,codStr,self.sechash];
    
    ZLUserInfo *user = [ZLUserInfo sharedInstence];
    
    [[ZLNetworkManager sharedInstence]userLoginSecondWithUserID:user.userID
                                                      password:user.password
                                                          type:user.safetyQuestion
                                                           asw:user.safetyAnswer
                                                           url:url
                                                      formhash:[ZLGlobal sharedInstence].loginFormHash block:^(NSDictionary *dic) {
                                                          user.userUID    = dic[@"member_uid"];
                                                          user.username   = dic[@"member_username"];
                                                          user.readaccess = dic[@"readaccess"];
        
    } failure:^(NSError *error) {
        
    }];
}
- (IBAction)testData:(id)sender {
    [[ZLNetworkManager sharedInstence]getInfoWithPage:1 block:^(NSDictionary *dict) {
        
    } failure:^(NSError *error) {
        
    }];
}
- (IBAction)changeImg:(id)sender {
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
