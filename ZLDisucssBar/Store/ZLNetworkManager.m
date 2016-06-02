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
        failure(error);
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
                          @"mobiletype":@"1"};
    
    
    [netManager POST:url parameters:par success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)favouriteWithTid:(NSString *)tid block:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    NSString *url = [NSString stringWithFormat:@"http://www.zuanke8.com/api/mobile/index.php?charset=utf-8&module=favthread&mobile=no&favoritesubmit=true&id=%@&version=3",tid];
    
//    
//    
//    NSDictionary *par = @{@"charset":@"utf-8",
//                          @"mobile":@"no",
//                          @"favouritesubmit":@"true",
//                          @"id":tid,
//                          @"version":@"3",
//                          @"module":@"favthread"};
    NSDictionary *par = @{@"formhash":[ZLGlobal sharedInstence].gachincoFormHash};
    
    [netManager POST:url parameters:par success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject[@"Message"]);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
}


- (void)getFavoriteThreadWithPage:(NSString *)page
                            block:(void (^)(NSDictionary *dict))success
                          failure:(void (^)(NSError *error))failure{

    NSString *url = [NSString stringWithFormat:@"http://www.zuanke8.com/api/mobile/index.php?charset=utf-8&module=myfavthread&mobile=no&version=3&page=%@",page];
    [netManager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject[@"Variables"]);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)rateSomeOneWith:(NSString *)tid
                    pid:(NSString *)pid
              faceValue:(NSString *)faceValue
                 reason:(NSString *)reason
                  block:(void (^)(NSString *str))success
                failure:(void (^)(NSError *error))failure{
    NSString *refrer = [NSString stringWithFormat:@"http://www.zuanke8.com/forum.php?mod=viewthread&tid=%@&page=0#pid%@",tid,pid];
    NSDictionary *par = @{@"formhash":[ZLGlobal sharedInstence].gachincoFormHash,
                          @"tid":tid,
                          @"pid":pid,
                          @"refrer":refrer,
                          @"handlekey":@"rate",
                          @"score1":[NSString stringWithFormat:@"+%@",faceValue],
                          @"reason":@""};
    
    AFHTTPRequestOperationManager *rateManager    = [AFHTTPRequestOperationManager manager];
    rateManager.responseSerializer                = [AFHTTPResponseSerializer serializer];
    rateManager.requestSerializer.timeoutInterval = 10;
    
    [rateManager POST:@"http://www.zuanke8.com/forum.php?mod=misc&action=rate&ratesubmit=yes&infloat=yes&inajax=1" parameters:par success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        NSString *rawString=[[NSString alloc]initWithData:responseObject encoding:enc];
        success(rawString);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)userPurchaseWithUid:(NSString *)uid type:(NSString *)type block:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    
    AFHTTPRequestOperationManager *purManager    = [AFHTTPRequestOperationManager manager];
    purManager.responseSerializer                = [AFHTTPResponseSerializer serializer];
    purManager.requestSerializer.timeoutInterval = 10;
    [purManager.requestSerializer setValue:[NSString stringWithFormat:@"http://www.zuanke8.com/thread-%@-1-1.html",uid] forHTTPHeaderField:@"Referer"];
    
    NSDictionary *par = @{@"formhash":[ZLGlobal sharedInstence].gachincoFormHash,
                          @"quickforward":@"yes",
                          @"handlekey":@"ls",
                          @"questionid":@"5",
                          @"answer":@"acer",
                          @"confirmsubmit":@"true"};
    NSString *url = [NSString stringWithFormat:@"http://www.zuanke8.com/plugin.php?id=ejew_auction%@:buy&tid=%@&confirmsubmit=yes&infloat=yes&inajax=1",type,uid];
    
    [purManager POST:url parameters:par success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        NSString *rawString=[[NSString alloc]initWithData:responseObject encoding:enc];
        success(rawString);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
    
}


#pragma mark - **************** 通用模块访问(我的帖子 & 我的消息)
- (void)generalAccessWith:(NSString *)thread
                     page:(NSString *)page
                    block:(void (^)(NSDictionary *dict))success
                  failure:(void (^)(NSError *error))failure{
    
    NSString *urlStr;
    if ([page isEqualToString:@"1"]) {
        urlStr = [NSString stringWithFormat:@"http://www.zuanke8.com/api/mobile/index.php?charset=utf-8&module=%@&mobile=no&version=3",thread];
    }else{
        urlStr = [NSString stringWithFormat:@"http://www.zuanke8.com/api/mobile/index.php?charset=utf-8&module=%@&mobile=no&version=3&page=%@",thread,page];
    }
    
    [netManager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject[@"Variables"]);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
}


- (void)autoLoginWithBlock:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    [netManager GET:@"http://www.zuanke8.com/api/mobile/index.php?loginsubmit=yes&charset=utf-8&loginfield=auto&module=login&mobile=no&version=3" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}


- (void)getUserInfoWithBlock:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    [netManager GET:@"http://www.zuanke8.com/api/mobile/index.php?version=3&module=profile" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject[@"Variables"]);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}
























@end
