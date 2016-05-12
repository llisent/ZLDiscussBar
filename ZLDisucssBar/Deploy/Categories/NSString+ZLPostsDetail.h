//
//  NSString+ZLPostsDetail.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/9.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZLPostsDetail)

/** 判断是否为回复贴 条件待添加*/
- (BOOL)isReplyPosts;

- (NSString *)handleMessage;

- (NSString *)flattenHTML:(NSString *)str;

- (TYTextContainer *)makeContainerWithType:(NSInteger)type;

@end
