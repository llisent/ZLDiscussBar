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
    NSLog(@"%@---",self);
    if (ran.length != 0) {
        return YES;
    }
    return NO;
}

- (NSString *)handleMessage{
    NSString *message = self;
    message = [message stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    message = [message stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    message = [message stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    return message;
}

- (NSString *)flattenHTML:(NSString *)str{
    
    NSScanner *theScanner;
    
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:str];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL];
        
        [theScanner scanUpToString:@">" intoString:&text];
        
        str = [str stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        
    }
    
    return str;
    
}

@end
