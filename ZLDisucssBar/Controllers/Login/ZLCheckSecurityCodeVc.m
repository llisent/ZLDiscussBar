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
    [self creatCostomUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getSeccode];
}

- (void)creatCostomUI{
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.clipsToBounds      = YES;
}

#pragma mark - **************** 获取验证码(无参 待添加默认验证码图片)
- (void)getSeccode{

    [[ZLNetworkManager sharedInstence]getSeccodeWithblock:^(NSDictionary *dict) {
        
        SDWebImageDownloader *dl = [SDWebImageDownloader sharedDownloader];
        [dl setValue:@"http://www.zuanke8.com/api/mobile/index.php" forHTTPHeaderField:@"Referer"];
        self.sechash = dict[@"sechash"];
        [ZLGlobal sharedInstence].gachincoFormHash = dict[@"formhash"];
        [dl downloadImageWithURL:[NSURL URLWithString:dict[@"seccode"]] options:SDWebImageDownloaderHandleCookies progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.securityCodeImageView.image = image;
            });
        }];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - **************** 登陆
- (IBAction)loginNow:(id)sender {
    // ------存储此次登陆信息
    #warning 存储时机待修改
    ZLUserInfo *user        = [ZLUserInfo sharedInstence];
    NSDictionary *loginIngo = @{@"a":user.userID,
                                @"b":user.password,
                                @"c":user.safetyQuestion,
                                @"d":user.safetyAnswer};
    
    [[NSUserDefaults standardUserDefaults]setValue:loginIngo forKey:@"loginInfo"];
    
    // ------将编码转换
    NSString *codStr = [self.securityCodeTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = [NSString stringWithFormat:@"http://www.zuanke8.com/api/mobile/index.php?loginsubmit=yes&charset=utf-8&secqaahash=%@&loginfield=auto&seccodehash=%@&seccodeverify=%@&sechash=%@&module=login&mobile=no&version=3",self.sechash,self.sechash,codStr,self.sechash];
    
    [[ZLNetworkManager sharedInstence]userLoginSecondWithUserID:user.userID
                                                      password:user.password
                                                          type:user.safetyQuestion
                                                           asw:user.safetyAnswer
                                                           url:url
                                                      formhash:[ZLGlobal sharedInstence].gachincoFormHash block:^(NSDictionary *dic) {
                                                          //登陆信息
                                                          NSString *messageval = dic[@"Message"][@"messageval"];
                                                          NSLog(@"登陆信息---%@",messageval);
                                                          if ([messageval isEqualToString:@"login_succeed"]) {
                                                              // ------登陆成功
                                                          }else if ([messageval isEqualToString:@"login_question_empty"]){
                                                              // ------答案缺失
                                                              
                                                          }else if ([messageval isEqualToString:@"login_invalid"]){
                                                              // 账户或密码错误
                                                          }

                                                          user.userUID    = dic[@"Variables"][@"member_uid"];
                                                          user.username   = dic[@"Variables"][@"member_username"];
                                                          user.readaccess = dic[@"Variables"][@"readaccess"];
                                                          
                                                          //归档存储用户信息
                                                          NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
                                                              NSString *path=[docPath stringByAppendingPathComponent:@"user.info"];
                                                               NSLog(@"path=%@",path);
                                                         [NSKeyedArchiver archiveRootObject:user toFile:path];
                                                          
                                                          //发送通知
                                                          [[NSNotificationCenter defaultCenter]postNotificationName:@"UserLoginNotification" object:nil];
                                                          
                                                          
                                                          [self.navigationController dismissViewControllerAnimated:YES completion:^{
                                                              
                                                              [SVProgressHUD showSuccessWithStatus:@"登陆成功" maskType:SVProgressHUDMaskTypeBlack];
                                                                                                                            
                                                              SaveCookies
                                                          }];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - **************** 更换验证码
- (IBAction)changeImg:(id)sender {
    
    [self getSeccode];
}

#pragma mark - **************** 回到登陆页
- (IBAction)backOnClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - **************** 点击屏幕
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
