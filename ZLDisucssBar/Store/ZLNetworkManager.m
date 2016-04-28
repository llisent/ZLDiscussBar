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
        manager = [[ZLNetworkManager alloc]init];
        manager.netManager                    = [AFHTTPRequestOperationManager manager];
        manager.netManager.responseSerializer = [AFJSONResponseSerializer serializer];
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


- (void)getInfoWithPage:(NSInteger)page
                  block:(void (^)(NSDictionary *dict))success
                failure:(void (^)(NSError *error))failure{
    NSDictionary *par = @{@"module":@"forumdisplay",
                          @"tpp":@"10",
                          @"version":@"1",
                          @"charset":@"gbk",
                          @"submodule":@"checkpost", //子模块
                          @"fid":@"15",
                          @"page":[NSString stringWithFormat:@"%ld",page]};
    
    
    [netManager GET:@"http://www.zuanke8.com/api/mobile/index.php" parameters:par success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
    
}


@end
