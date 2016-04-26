//
//  ZLNetworkManager.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/26.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLNetworkManager : NSObject

/** manager*/
@property(nonatomic,retain)AFHTTPRequestOperationManager *netManager;

#pragma mark - **************** 单例
+ (instancetype)sharedInstence;

#pragma mark - **************** 


@end
