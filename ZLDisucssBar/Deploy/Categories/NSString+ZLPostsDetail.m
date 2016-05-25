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
    container.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    
    // ------处理表情
    NSMutableArray *tmpArray   = [NSMutableArray array];
    [self enumerateStringsMatchedByRegex:@"\\[\\[\\[(\\d+?)\\]\\]\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        TYImageStorage *imageStorage    = [[TYImageStorage alloc]init];
        imageStorage.cacheImageOnMemory = YES;
        imageStorage.image              = [UIImage imageNamed:[NSString stringWithFormat:@"smile%@.gif",capturedStrings[1]]];
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


- (NSString *)checkRateResult{
    NSRange ran1 = [self rangeOfString:@"感谢您的参与"];
    if (ran1.length != 0) {
        return @"评分成功";
    }
    NSRange ran2 = [self rangeOfString:@"评分数超过限制"];
    if (ran2.length != 0) {
        return @"24小时内评分超过限制";
    }
    NSRange ran3 = [self rangeOfString:@"后才能对该用户评分"];
    if (ran3.length != 0) {
        return @"最近给他评过分咯";
    }
    NSRange ran4 = [self rangeOfString:@"您所在的用户组"];
    if (ran4.length != 0) {
        return @"用户级别不足";
    }
    return @"评分失败";
}

- (NSString *)checkExchangeResult{
    return self;
}


#pragma mark - **************** 检出出售信息 待优化
- (ZLPurchaseModel *)checkOutPurchaseInfo{
    ZLPurchaseModel *model = [[ZLPurchaseModel alloc]init];
    NSString *sourceStr    = [self stringByReplacingOccurrencesOfString:@"\\\\\\" withString:@"\\"];
    NSRange rangPrice      = [self rangeOfString:@"price\\\";i:"];
    
    sourceStr = [sourceStr substringWithRange:NSMakeRange(rangPrice.location + rangPrice.length, sourceStr.length - rangPrice.location - rangPrice.length)];
    
    NSMutableString *num = [NSMutableString string];
    for (int i = 0; i <sourceStr.length - 1; i++) {
        NSString *sub = [sourceStr substringWithRange:NSMakeRange(i, 1)];
        if (![sub isEqualToString:@";"]) {
            [num appendString:sub];
        }else{
            break;
        }
    }
    model.price = num;
    return model;
}

- (NSString *)filtrationHtml{
    NSString *returnStr;
    returnStr = [self stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    return returnStr;
}

















@end
