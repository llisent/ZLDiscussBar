//
//  ZLPostDetailModel.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/9.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLPostDetailModel : NSObject

@property (nonatomic ,strong) NSString     *pid;

@property (nonatomic ,strong) NSString     *tid;

@property (nonatomic ,strong) NSString     *authorid;

@property (nonatomic ,strong) NSString     *author;

@property (nonatomic ,strong) NSString     *dateline;

@property (nonatomic ,strong) NSString     *message;

@property (nonatomic ,strong) NSDictionary *attachments;

@property (nonatomic ,strong) NSString     *replyStr;

@property (nonatomic ,assign) BOOL         isReply;


- (void)detectionModel;



@end
