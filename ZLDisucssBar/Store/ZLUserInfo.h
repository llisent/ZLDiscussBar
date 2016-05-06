//
//  ZLUserInfo.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLUserInfo : NSObject <NSCoding>

/** 用户名*/
@property (nonatomic ,strong) NSString *userID;

/** 密码*/
@property (nonatomic ,strong) NSString *password;

/** 安全问题*/
@property (nonatomic ,strong) NSString *safetyQuestion;

/** 密码*/
@property (nonatomic ,strong) NSString *safetyAnswer;

/** UID*/
@property (nonatomic ,strong) NSString *userUID;

/** 用户昵称*/
@property (nonatomic ,strong) NSString *username;

/** 阅读权限*/
@property (nonatomic ,strong) NSString *readaccess;


+ (instancetype)sharedInstence;

@end
