//
//  ZLGlobal.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLGlobal : NSObject

/** 最新formhash*/
@property (nonatomic ,strong) NSString *gachincoFormHash;

/** 是否登陆*/
@property (nonatomic ,assign) BOOL     isLogin;


+ (instancetype)sharedInstence;



#pragma mark - **************** 同步cookies
- (void)synchronizeCookies;

#pragma mark - **************** 设置cookies
- (void)setHttpCookies;


@end
