//
//  ZLNetworkManager.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/26.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLNetworkManager.h"

@implementation ZLNetworkManager


+ (instancetype)sharedInstence{
    static ZLNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZLNetworkManager alloc]init];
        manager.netManager                    = [AFHTTPRequestOperationManager manager];
        manager.netManager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.netManager.requestSerializer.timeoutInterval = 10;
    });
    return manager;
}



@end
