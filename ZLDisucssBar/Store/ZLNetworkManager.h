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
@property(nonatomic,retain) AFHTTPRequestOperationManager *netManager;

#pragma mark - **************** 单例
+ (instancetype)sharedInstence;

- (void)getSeccodeWithblock:(void (^)(NSDictionary *dict))success
                    failure:(void (^)(NSError *error))failure;

#pragma mark - **************** 
- (void)userLoginFirstWithUserID:(NSString *)userID
                        password:(NSString *)passWord
                      safetytype:(NSString *)type
                          answer:(NSString *)answer
                           block:(void (^)(NSError *error))success
                         failure:(void (^)(NSError *error))failure;


- (void)userLoginSecondWithUserID:(NSString *)userID
                         password:(NSString *)passWord
                             type:(NSString *)tp
                              asw:(NSString *)answer
                              url:(NSString *)url
                         formhash:(NSString *)hash
                            block:(void (^)(NSDictionary *dict))success
                          failure:(void (^)(NSError *error))failure;

- (void)getInfoWithPage:(NSInteger)page
                  block:(void (^)(NSDictionary *dict))success
                failure:(void (^)(NSError *error))failure;

@end
