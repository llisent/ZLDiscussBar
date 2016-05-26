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
@property (weak, nonatomic  ) IBOutlet UIImageView *userImg;

/** 用户名*/
@property (weak, nonatomic  ) IBOutlet UILabel     *userName;

/** 用户组*/
@property (weak, nonatomic  ) IBOutlet UILabel     *userLevel;

/** 用户积分*/
@property (weak, nonatomic  ) IBOutlet UILabel     *userLntegral;

/** 登录点击区域*/
@property (weak, nonatomic  ) IBOutlet UIView      *contentView;

/** 头像是否加载完成*/
@property (nonatomic ,assign) BOOL        loadFinish;




@property (nonatomic, copy) void (^loginBlock)();

#pragma mark - **************** 更新数据
- (void)updateInfoWithDict:(NSDictionary *)dict;

#pragma mark - **************** 更新缓存数据
- (void)initHeaderDataWith:(NSDictionary *)dict;


@end
