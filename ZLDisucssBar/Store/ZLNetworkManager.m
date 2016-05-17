//
//  ZLNetworkManager.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/26.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLNetworkManager.h"

@implementation ZLNetworkManager
@synthesize netManager;


+ (instancetype)sharedInstence{
    static ZLNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager                                              = [[ZLNetworkManager alloc]init];
        manager.netManager                                   = [AFHTTPRequestOperationManager manager];
        manager.netManager.responseSerializer                = [AFJSONResponseSerializer serializer];
        manager.netManager.requestSerializer.timeoutInterval = 10;
    });
    return manager;
}

- (void)getSeccodeWithblock:(void (^)(NSDictionary *dict))success
                    failure:(void (^)(NSError *error))failure{
    [netManager GET:@"http://www.zuanke8.com/api/mobile/index.php?secversion=3&charset=utf-8&debug=1&module=secure&mobile=no&force=1&type=login&version=1" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = responseObject[@"Variables"];
        success(dic);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)userLoginSecondWithUserID:(NSString *)userID
                         password:(NSString *)passWord
                             type:(NSString *)tp
                              asw:(NSString *)answer
                              url:(NSString *)url
                         formhash:(NSString *)hash
                            block:(void (^)(NSDictionary *dict))success
                          failure:(void (^)(NSError *error))failure{
    NSDictionary *par1 = @{@"username":userID,
                           @"charest":@"utf-8",
                           @"password":passWord,
                           @"questionid":tp,
                           @"answer":answer,
                           @"formhash":hash};
    
    [netManager POST:url parameters:par1 success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}


- (void)getInfoWithFid:(NSString *)fid
                  page:(NSInteger)page
                  block:(void (^)(NSDictionary *dict))success
                failure:(void (^)(NSError *error))failure{
    NSDictionary *par = @{@"module":@"forumdisplay",
                          @"tpp":@"10",
                          @"version":@"1",
                          @"charset":@"gbk",
                          @"submodule":@"checkpost", //子模块
                          @"fid":fid,             // 模块代码
                          @"page":[NSString stringWithFormat:@"%ld",page]};
    
    [netManager GET:@"http://www.zuanke8.com/api/mobile/index.php" parameters:par success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject[@"Variables"]);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

- (void)getUserInfoWithUid:(NSString *)uid
                     block:(void (^)(NSDictionary *dict))success
                   failure:(void (^)(NSError *error))failure{
    NSDictionary *par = @{@"module":@"profile",
                           @"uid":uid,
                           @"version":@"3",
                           @"charest":@"utf-8"};
    [netManager GET:@"http://www.zuanke8.com/api/mobile/index.php" parameters:par success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject[@"Variables"]);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

//帖子详情
- (void)getDetailInfoWithPage:(NSInteger)page
                          tid:(NSString *)tid
                        block:(void (^)(NSDictionary *dict))success
                      failure:(void (^)(NSError *error))failure{
    NSDictionary *par = @{@"module":@"viewthread",
                          @"ppp":@"10",
                          @"version":@"1",
                          @"charset":@"gbk",
                          @"image":@"1",
                          @"tid":tid,
                          @"page":[NSString stringWithFormat:@"%ld",page]};
    
    
    [netManager GET:@"http://www.zuanke8.com/api/mobile/index.php" parameters:par success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject[@"Variables"]);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
}



//回复测试
- (void)userReplyWithTid:(NSString *)tid
                formHash:(NSString *)hash
                 message:(NSString *)msg
                   block:(void (^)(NSDictionary *dict))success
                 failure:(void (^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"http://www.zuanke8.com/api/mobile/index.php?charset=utf-8&module=sendreply&mobile=no&replysubmit=yes&version=3&tid=%@",tid];
    NSDictionary *par = @{@"charset":@"utf-8",
                          @"formhash":hash,
                          @"message":msg,
                          @"mobiletype":@"2"};
    
    
    [netManager POST:url parameters:par success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
}


@end
