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
        self = [[NSBundle mainBundle]loadNibNamed:@"ZLPersonalCenterView" owner:self options:nil][0];
        self.frame = frame;
        self.userImg.layer.cornerRadius = 30;
        self.userImg.clipsToBounds = YES;
    }
    return self;
}

- (void)updateInfoWithDict:(NSDictionary *)dict{
    if (!dict) {
        //未登陆
        self.userImg.image     = [UIImage imageNamed:@"noavatar_middle.gif"];
        self.userName.text     = @"未登录";
        self.userLevel.text    = @"游客";
        self.userLntegral.text = @"0果";
    }else{
        [self.userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://uc.zuanke8.com/avatar.php?uid=%@&size=small",[[ZLUserInfo sharedInstence] userUID]]]
                        placeholderImage:[UIImage imageNamed:@"noavatar_middle"]];
        self.userName.text     = [[ZLUserInfo sharedInstence] username];
        self.userLevel.text    = dict[@"space"][@"group"][@"grouptitle"];
        self.userLntegral.text = [NSString stringWithFormat:@"%@果",dict[@"space"][@"credits"]];
    }
}

@end
