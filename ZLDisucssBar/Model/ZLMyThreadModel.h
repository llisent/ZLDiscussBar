//
//  ZLMyThreadModel.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/25.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLMyThreadModel : NSObject

/** 作者*/
@property (nonatomic ,strong) NSString *author;

/** 作者id*/
@property (nonatomic ,strong) NSString *authorid;

/** 时间*/
@property (nonatomic ,strong) NSString *dateline;

/** 板块*/
@property (nonatomic ,strong) NSString *fid;

/** 题目*/
@property (nonatomic ,strong) NSString *subject;

/** 帖子id*/
@property (nonatomic ,strong) NSString *tid;



@end
