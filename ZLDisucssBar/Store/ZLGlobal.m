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

@end
