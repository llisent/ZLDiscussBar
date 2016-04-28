//
//  ZLGlobal.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLGlobal : NSObject

@property (nonatomic ,strong) NSString *loginFormHash;

@property (nonatomic ,strong) NSString *gachincoFormHash;

+ (instancetype)sharedInstence;

#pragma mark - **************** 同步cookies
- (void)synchronizeCookies;

#pragma mark - **************** 设置cookies
- (void)setHttpCookies;

@end
