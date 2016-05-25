//
//  ZLSettingViewController.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/16.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLSettingViewController.h"
#import "ZLPictureMode.h"
#import "ZLAvatarMode.h"

@interface ZLSettingViewController ()

@end

@implementation ZLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self performSelectorInBackground:@selector(checkMemory) withObject:nil];
    [self checkNotice];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)checkMemory{
    NSUInteger a = [[SDImageCache sharedImageCache]getSize] / 1024 / 1024;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.memorySizeLabel.text = [NSString stringWithFormat:@"%ldM",a];
    });
}

- (void)checkNotice{
    BOOL notice = [[NSUserDefaults standardUserDefaults]boolForKey:@"notice"];
    if (!notice) {
        self.noticeSwitch.on = YES;
    }else{
        self.noticeSwitch.on = NO;
    }
}

- (IBAction)pictureType:(id)sender {
    ZLPictureMode *mode = [[ZLPictureMode alloc]init];
    [self.navigationController pushViewController:mode animated:YES];
}

- (IBAction)avatarType:(id)sender {
    ZLAvatarMode *mode = [[ZLAvatarMode alloc]init];
    [self.navigationController pushViewController:mode animated:YES];
}

//清理缓存效果 -- 仿Weibo清理缓存
- (IBAction)cleanCache:(id)sender {
    
    UIView *cleanView          = [[UIView alloc]initWithFrame:ScreenBonds];
    cleanView.backgroundColor  = [UIColor clearColor];
    UIView *hiddenView         = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 100)];
    hiddenView.backgroundColor = [UIColor colorWithWhite:0.871 alpha:1.000];
    UIButton *sureBtn          = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 48)];
    sureBtn.backgroundColor    = [UIColor whiteColor];
    UIButton *cancalBtn        = [[UIButton alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, 48)];
    cancalBtn.backgroundColor  = [UIColor whiteColor];
    
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [cancalBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    sureBtn.titleLabel.font   = [UIFont fontWithName:@"HelveticaNeue" size:15];
    cancalBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [sureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [UIView animateWithDuration:0.3 animations:^{
            cleanView.backgroundColor  = [UIColor clearColor];
            hiddenView.top             = ScreenHeight;
            
        } completion:^(BOOL finished) {
            if (cleanView.superview) {
                [cleanView removeFromSuperview];
            }
            __weak typeof(self)weakSelf = self;
            [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
                [SVProgressHUD showSuccessWithStatus:@"清理完毕" maskType:SVProgressHUDMaskTypeBlack];
                [weakSelf checkMemory];
            }];
        }];
        
    }];
    [cancalBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [UIView animateWithDuration:0.3 animations:^{
            cleanView.backgroundColor  = [UIColor clearColor];
            hiddenView.top             = ScreenHeight;
            
        } completion:^(BOOL finished) {
            if (cleanView.superview) {
                [cleanView removeFromSuperview];
            }
        }];
    }];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
        [UIView animateWithDuration:0.3 animations:^{
            cleanView.backgroundColor  = [UIColor clearColor];
            hiddenView.top             = ScreenHeight;
            
        } completion:^(BOOL finished) {
            if (cleanView.superview) {
                [cleanView removeFromSuperview];
            }
        }];
    }];
    [cleanView addGestureRecognizer:ges];
    [hiddenView addSubview:sureBtn];
    [hiddenView addSubview:cancalBtn];
    [cleanView addSubview:hiddenView];

    [[[UIApplication sharedApplication]keyWindow]addSubview:cleanView];
    [UIView animateWithDuration:0.3 animations:^{
        cleanView.backgroundColor  = [UIColor colorWithWhite:0.000 alpha:0.300];
        hiddenView.top             = ScreenHeight - 100;
    }];
}

//退出
- (IBAction)dropOut:(id)sender {
    /*
     退出登录 更改islogin状态
     发送通知 更新个人中心状态
     删除cookies
     删除历史记录
     删除一些配置
     */
    //发送通知
    
    http://www.zuanke8.com//connect.php?mod=login&op=init&mobile=no&oauth_style=mobile&referer=Mobile_Android
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UserLoginNotification" object:nil];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
        [self.view showSuccessWithStatus:@"登陆成功"];
        
        SaveCookies
    }];

    
}
- (IBAction)clickNotice:(id)sender {
    if (!self.noticeSwitch.isOn) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"notice"];
    }else{
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"notice"];
    }
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
