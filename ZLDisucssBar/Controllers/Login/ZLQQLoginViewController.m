//
//  ZLQQLoginViewController.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/6/3.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLQQLoginViewController.h"

@interface ZLQQLoginViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ZLQQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebView];
    
}

#pragma mark - **************** 初始化WebView
- (void)initWebView{
    self.webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.zuanke8.com/connect.php?mod=login&op=init&referer=forum.php%3Fmobile%3Dyes&statfrom=login_simple"]];
    [self.webView loadRequest:request];
}

- (IBAction)alreadyLogin:(id)sender {
    
    ZLUserInfo *user = [ZLUserInfo sharedInstence];
    
    [[ZLNetworkManager sharedInstence]autoLoginWithBlock:^(NSDictionary *dict) {
        
        NSString *message = dict[@"Message"][@"messageval"];
        
        if ([message rangeOfString:@"succeed"].length != 0) {
            user.userUID    = dict[@"Variables"][@"member_uid"];
            user.username   = dict[@"Variables"][@"member_username"];
            user.readaccess = dict[@"Variables"][@"readaccess"];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isLogin"];
            
            //归档存储用户信息
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
            NSString *path    = [docPath stringByAppendingPathComponent:@"user.info"];
            [NSKeyedArchiver archiveRootObject:user toFile:path];
            
            //发送通知
            [[NSNotificationCenter defaultCenter]postNotificationName:UserLogin object:nil];
            
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
                [self.view showSuccessWithStatus:@"登陆成功"];
                
                SaveCookies
            }];

        }else{
            [self.view showJGErrorWithStatus:dict[@"Message"][@"messagestr"]];
        }
    } failure:^(NSError *error) {
        [self.view showJGErrorWithStatus:@"网络错误,请重试"];
    }];
}

#pragma mark - **************** 返回登陆页面
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - **************** WebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [self.view showJGErrorWithStatus:@"加载失败"];
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
