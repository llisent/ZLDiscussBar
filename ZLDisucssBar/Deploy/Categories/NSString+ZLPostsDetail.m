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

- (TYTextContainer *)makeContainerWithType:(NSInteger)type{
    TYTextContainer *container = [[TYTextContainer alloc]createTextContainerWithTextWidth:ScreenWidth - 20];
    container.text             = self;
    
    // ------处理表情
    NSMutableArray *tmpArray   = [NSMutableArray array];
    [self enumerateStringsMatchedByRegex:@"\\[\\[\\[(\\d+?)\\]\\]\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        TYImageStorage *imageStorage    = [[TYImageStorage alloc]init];
        imageStorage.cacheImageOnMemory = YES;
        imageStorage.imageName          = [NSString stringWithFormat:@"smile%@.gif",capturedStrings[1]];
        imageStorage.range              = capturedRanges[0];
        imageStorage.size               = ([capturedStrings[1] intValue] > 30) ? CGSizeMake(60, 60) : CGSizeMake(20, 20);
        [tmpArray addObject:imageStorage];
    }];
    [container addTextStorageArray:tmpArray];
    
    // ------处理网址
    if (type == 1) {
        [self enumerateStringsMatchedByRegex:@"[a-zA-z]+://[^\\s]*" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
            
            [container addLinkWithLinkData:capturedStrings[0]
                                      linkColor:[UIColor blueColor]
                                 underLineStyle:kCTUnderlineStyleSingle
                                          range:capturedRanges[0]];
        }];
    }
    return container;
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
