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
    NSLog(@"%@",self);
    if (ran.length != 0) {
        return YES;
    }
    return NO;
}

- (NSString *)handleMessage{
    NSString *message = self;
    message = [message stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    message = [message stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    message = [message stringByReplacingOccurrencesOfString:@"" withString:@""];
    return message;
}

@end
