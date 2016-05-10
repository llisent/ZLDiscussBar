//
//  ZLPostDetailModel.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/9.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPostDetailModel.h"

@implementation ZLPostDetailModel

-(void)detectionModel{
    //检出信息
    NSRange ran = [self.message rangeOfString:@"</blockquote></div><br />"];
    if (ran.length != 0) {
        self.isReply = YES;
    }else{
        self.isReply = NO;
    }
//    
//    self.message = [self.message stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
//    self.message = [self.message stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
//    self.message = [self.message stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    if (self.isReply) {
        NSRange rang1 = [self.message rangeOfString:@"</blockquote></div><br />" options:NSBackwardsSearch];
        self.replyStr = [self.message substringWithRange:NSMakeRange(rang1.location+rang1.length,
                                                                            self.message.length-rang1.location-rang1.length)];
    }

    
    
    
    
    
    NSScanner *theScanner;
    
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:self.message];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL];
        
        [theScanner scanUpToString:@">" intoString:&text];
        
        self.message = [self.message stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        
    }
    
    if (self.isReply) {
        NSString *str = self.replyStr;
        self.replyStr = [self.message stringByReplacingOccurrencesOfString:self.replyStr withString:@""];
        self.message = str;
        
    }
    
    
    
    
//    
//    
//    while ([theScanner isAtEnd] == NO) {
//        
//        [theScanner scanUpToString:@"<" intoString:NULL];
//        
//        [theScanner scanUpToString:@">" intoString:&text];
//        
//        str = [str stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
//        
//    }
    
//    return str;
    
}

@end
