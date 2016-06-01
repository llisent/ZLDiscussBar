//
//  ZLPostDetailModel.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/9.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLPostDetailModel : NSObject

@property (nonatomic ,strong) NSString        *pid;

@property (nonatomic ,strong) NSString        *tid;

@property (nonatomic ,strong) NSString        *authorid;

@property (nonatomic ,strong) NSString        *author;

@property (nonatomic ,strong) NSString        *dateline;

/** 本贴回复*/
@property (nonatomic ,strong) NSString        *message;

@property (nonatomic ,strong) NSDictionary    *attachments;

/** 引用信息*/
@property (nonatomic ,strong) NSString        *quoteStr;

@property (nonatomic ,assign) BOOL            isReply;

@property (nonatomic ,strong) TYTextContainer *container1;

@property (nonatomic ,strong) TYTextContainer *container2;


- (void)detectionModel;



@end
