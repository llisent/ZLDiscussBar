//
//  ZLGlobal.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLGlobal.h"

@implementation ZLGlobal

+ (instancetype)sharedInstence{
    static ZLGlobal *global = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        global = [[ZLGlobal alloc]init];
    });
    return global;
}

- (BOOL)isLogin{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"];
}

- (BOOL)autoFill{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"autoFill"];
}

- (BOOL)autoLogin{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"autoLogin"];
}

#pragma mark - **************** 同步cookies
- (void)synchronizeCookies{
    NSData *cookiesData      = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"zuankeCookues"];
    [defaults synchronize];
}

#pragma mark - **************** 设置cookies
- (void)setHttpCookies{
    id cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"zuankeCookues"];
    if (!cookie) {
        return;
    }
    NSArray *cookies                   = [NSKeyedUnarchiver unarchiveObjectWithData: cookie];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
}

@end
