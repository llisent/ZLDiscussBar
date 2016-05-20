//
//  ZLFavuriteModel.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/20.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLFavuriteModel : NSObject

/** 作者*/
@property (nonatomic ,strong) NSString *author;

/** 时间差*/
@property (nonatomic ,strong) NSString *dateline;

/** 收藏ID*/
@property (nonatomic ,strong) NSString *favid;

/** 帖子ID*/
@property (nonatomic ,strong) NSString *id;

/** 帖子类型*/
@property (nonatomic ,strong) NSString *idtype;

/** 回复数*/
@property (nonatomic ,strong) NSString *replies;

/** 标题*/
@property (nonatomic ,strong) NSString *title;

/** 作者id*/
@property (nonatomic ,strong) NSString *uid;

@end
