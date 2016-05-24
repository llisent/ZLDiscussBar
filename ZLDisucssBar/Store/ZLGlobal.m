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

-(BOOL)downLoadImage{
    
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"downLoadImage"];
}

- (NSString *)avatarMass{
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"avatarMass"];
}

- (BOOL)downLoadAvatar{
    
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"downLoadAvatar"];
}

- (NSString *)shieldID{
    
    return [[NSUserDefaults standardUserDefaults]stringForKey:@"shieldID"];
}

#pragma mark - **************** 同步cookies
- (void)synchronizeCookies{
    NSData *cookiesData      = [NSKeyedArchiver archivedDataWithRootObject:[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"zuankeCookies"];
    [defaults synchronize];
}

#pragma mark - **************** 设置cookies
- (void)setHttpCookies{
    id cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"zuankeCookies"];
    if (!cookie) {
        return;
    }
    NSArray *cookies                   = [NSKeyedUnarchiver unarchiveObjectWithData: cookie];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
}

#pragma mark - **************** 归档解归档
- (void)saveModelWith:(ZLPostsModel *)model{
    NSString *docPath     = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path        = [docPath stringByAppendingPathComponent:@"userRecord.zuan"];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    if (!array) {
        array = [NSMutableArray array];
    }
    if (array.count == 25) {
        [array removeLastObject];
    }
    for (ZLPostsModel *mod in array) {
        if ([model.tid isEqualToString:mod.tid]) {
            return;
        }
    }
    [array insertObject:model atIndex:0];
    [NSKeyedArchiver archiveRootObject:array toFile:path];
}

#pragma mark - **************** 获取历史记录
- (NSArray *)readArchive{
    NSString *docPath     = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path        = [docPath stringByAppendingPathComponent:@"userRecord.zuan"];
    NSArray  *array       = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!array) {
        return [NSArray array];
    }
    return array;
}


@end
