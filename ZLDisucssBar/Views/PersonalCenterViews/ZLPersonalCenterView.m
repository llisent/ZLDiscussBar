//
//  ZLPersonalCenterView.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/5.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPersonalCenterView.h"

@implementation ZLPersonalCenterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self                            = [[NSBundle mainBundle]loadNibNamed:@"ZLPersonalCenterView" owner:self options:nil][0];
        self.frame                      = frame;
        self.userImg.layer.cornerRadius = 30;
        self.userImg.clipsToBounds      = YES;
    }
    return self;
}

- (void)updateInfoWithDict:(NSDictionary *)dict{
    if (!dict) {
        //未登陆
        self.userImg.image     = [UIImage imageNamed:@"noavatar_middle.gif"];
        self.userName.text     = @"请点击登录";
        self.userLevel.text    = @"游客";
        self.userLntegral.text = @"0果果";
        self.contentView.userInteractionEnabled = YES;
    }else{
        // ------头像加载规则(第一次登录账号 或者 第一次启动app)
        if (self.contentView.isUserInteractionEnabled || !self.loadFinish) {
            self.loadFinish = YES;
            [self.userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://uc.zuanke8.com/avatar.php?uid=%@&size=big",[[ZLUserInfo sharedInstence] userUID]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error) {
                    // ------加载失败 放开接口
                    self.loadFinish = NO;
                }
            }];
        }
        self.userName.text                      = [[ZLUserInfo sharedInstence] username];
        self.userLevel.text                     = dict[@"space"][@"group"][@"grouptitle"];
        self.userLntegral.text                  = [NSString stringWithFormat:@"%@ 果果",dict[@"space"][@"credits"]];
        self.contentView.userInteractionEnabled = NO;
    }
}

- (void)initHeaderDataWith:(NSDictionary *)dict{
    self.userName.text     = dict[@"a"];
    self.userLevel.text    = dict[@"b"];
    self.userLntegral.text = dict[@"c"];
}

- (IBAction)clickOnView:(id)sender {
    self.loginBlock();
}


@end
