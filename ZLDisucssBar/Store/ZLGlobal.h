//
//  ZLGlobal.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLPostsModel.h"

@interface ZLGlobal : NSObject

/** 最新formhash*/
@property (nonatomic ,strong) NSString     *gachincoFormHash;

/** 是否登陆*/
@property (nonatomic ,assign) BOOL         isLogin;

/** 自动填写登陆信息*/
@property (nonatomic ,assign) BOOL         autoFill;

/** 是否自动登陆*/
@property (nonatomic ,assign) BOOL         autoLogin;

/** 是否下载图片*/
@property (nonatomic ,assign) BOOL         downLoadImage;

/** 加载头像质量*/
@property (nonatomic ,strong) NSString     *avatarMass;

/** 是否加载头像*/
@property (nonatomic ,assign) BOOL         downLoadAvatar;

/** 屏蔽ID*/
@property (nonatomic ,strong) NSString     *shieldID;

+ (instancetype)sharedInstence;


#pragma mark - **************** 同步cookies
- (void)synchronizeCookies;


#pragma mark - **************** 设置cookies
- (void)setHttpCookies;


#pragma mark - **************** 归档解归档
- (void)saveModelWith:(ZLPostsModel *)model;

#pragma mark - **************** 获取历史记录
- (NSArray *)readArchive;


#pragma mark - **************** 退出登陆
- (void)cleanUserInfo;


@end
