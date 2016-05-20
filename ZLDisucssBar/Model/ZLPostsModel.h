//
//  ZLPostsModel.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/5.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLPostsModel : NSObject <NSCoding>

/** 作者*/
@property (nonatomic ,strong) NSString *author;

/** 作者ID*/
@property (nonatomic ,strong) NSString *authorid;

/** 题目*/
@property (nonatomic ,strong) NSString *subject;

/** 帖子ID*/
@property (nonatomic ,strong) NSString *tid;

/** 回复数*/
@property (nonatomic ,strong) NSString *replies;

/** 查看数*/
@property (nonatomic ,strong) NSString *views;

/** 发帖时间*/
@property (nonatomic ,strong) NSString *dateline;

/** 最后回复时间*/
@property (nonatomic ,strong) NSString *lastpost;

/** 最后回复作者*/
@property (nonatomic ,strong) NSString *lastposter;

/** 查看权限*/
@property (nonatomic ,strong) NSString *readperm;




@end
