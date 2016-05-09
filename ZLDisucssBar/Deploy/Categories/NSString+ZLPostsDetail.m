//
//  NSString+ZLPostsDetail.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/9.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "NSString+ZLPostsDetail.h"

@implementation NSString (ZLPostsDetail)

- (BOOL)isReplyPosts{
    NSRange ran = [self rangeOfString:@"blockquote"];
    if (ran.length != 0) {
        return YES;
    }
    return NO;
}

@end
