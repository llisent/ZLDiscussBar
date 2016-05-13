//
//  ZLPersonalCenterView.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/5.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLPersonalCenterView : UIView

/** 头像*/
@property (weak, nonatomic) IBOutlet UIImageView *userImg;

/** 用户名*/
@property (weak, nonatomic) IBOutlet UILabel     *userName;

/** 用户组*/
@property (weak, nonatomic) IBOutlet UILabel     *userLevel;

/** 用户积分*/
@property (weak, nonatomic) IBOutlet UILabel     *userLntegral;


- (void)updateInfoWithDict:(NSDictionary *)dict;

@end
