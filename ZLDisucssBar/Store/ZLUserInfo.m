//
//  ZLUserInfo.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLUserInfo.h"

@implementation ZLUserInfo

+ (instancetype)sharedInstence{
    static ZLUserInfo *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[ZLUserInfo alloc]init];
    });
    return user;
}

@end
