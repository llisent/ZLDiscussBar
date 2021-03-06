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

- (void)getInfoWithFid:(NSString *)fid
                  page:(NSInteger)page
                 block:(void (^)(NSDictionary *dict))success
               failure:(void (^)(NSError *error))failure;

- (void)getUserInfoWithUid:(NSString *)uid
                     block:(void (^)(NSDictionary *dict))success
                   failure:(void (^)(NSError *error))failure;

#pragma mark - ****************
- (void)getDetailInfoWithPage:(NSInteger)page
                          tid:(NSString *)tid
                        block:(void (^)(NSDictionary *dict))success
                      failure:(void (^)(NSError *error))failure;

#pragma mark - **************** 回复作者
- (void)userReplyWithTid:(NSString *)tid
                formHash:(NSString *)hash
                 message:(NSString *)msg
                   block:(void (^)(NSDictionary *dict))success
                 failure:(void (^)(NSError *error))failure;

#pragma mark - **************** 收藏帖子
- (void)favouriteWithTid:(NSString *)tid
                   block:(void (^)(NSDictionary *dict))success
                 failure:(void (^)(NSError *error))failure;

#pragma mark - **************** 获取用户的收藏帖子
- (void)getFavoriteThreadWithPage:(NSString *)page
                            block:(void (^)(NSDictionary *dict))success
                           failure:(void (^)(NSError *error))failure;


#pragma mark - **************** 评分-beta1
- (void)rateSomeOneWith:(NSString *)tid
                    pid:(NSString *)pid
              faceValue:(NSString *)faceValue
                 reason:(NSString *)reason
                  block:(void (^)(NSString *str))success
                failure:(void (^)(NSError *error))failure;


//需考虑下没有问题的情况
- (void)userPurchaseWithUid:(NSString *)uid
                       type:(NSString *)type
                      block:(void (^)(NSString *str))success
                    failure:(void (^)(NSError *error))failure;


#pragma mark - **************** 通用模块访问(我的帖子 & 我的消息)
- (void)generalAccessWith:(NSString *)thread
                     page:(NSString *)page
                    block:(void (^)(NSDictionary *dict))success
                  failure:(void (^)(NSError *error))failure;


#pragma mark - **************** 自动登陆检测
- (void)autoLoginWithBlock:(void (^)(NSDictionary *dict))success
                   failure:(void (^)(NSError *error))failure;


#pragma mark - **************** 获取个人信息(Cookie)
- (void)getUserInfoWithBlock:(void (^)(NSDictionary *dict))success
                     failure:(void (^)(NSError *error))failure;











@end
