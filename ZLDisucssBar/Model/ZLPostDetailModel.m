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
    /**
     *  目的: 1.检出是否为回复贴(回复内容) 2.检出表情 3.检出链接(替换) 4.替出其他HTML语句
     *  检测效率 考虑加入线程组
     */
    
    // ------判断是否为回复贴 为Model属性赋值
    NSRange ran = [self.message rangeOfString:@"</blockquote></div>"];
    ran.length ? (self.isReply = YES) : (self.isReply = NO);
    
    // ------检出表情 & 检出网址链接 （待优化）
    NSScanner *theScannerFirst;     //scanner
    NSString  *textFirst;           //临时变量
    NSString  *img;                 //图片变量
    
    NSMutableString *replaceStr = [NSMutableString string];
    theScannerFirst             = [NSScanner scannerWithString:self.message];
    
    while ([theScannerFirst isAtEnd] == NO) {
        
        [theScannerFirst scanUpToString:@"<img" intoString:NULL];
        
        [theScannerFirst scanUpToString:@"smilieid=\"" intoString:&textFirst];
        
        if (textFirst.length != 0) {
            [replaceStr appendString:textFirst];
            
            [theScannerFirst scanUpToString:@"\" " intoString:&textFirst];
            img = textFirst;
            [replaceStr appendString:textFirst];
            
            [theScannerFirst scanUpToString:@">" intoString:&textFirst];
            [replaceStr appendString:textFirst];

            img          = [img stringByReplacingOccurrencesOfString:@"smilieid=\"" withString:@"[[["];
            img          = [NSString stringWithFormat:@"%@]]]",img];
            self.message = [self.message stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",replaceStr] withString:img];
            [replaceStr setString:@""];
            textFirst = @"";
        }
    }
    
//    NSLog(@"%@",self.message);

    // ------处理回复与被回复串
    if (self.isReply) {
        NSRange rang1 = [self.message rangeOfString:@"</blockquote></div><br />" options:NSBackwardsSearch];
        self.replyStr = [self.message substringWithRange:NSMakeRange(rang1.location+rang1.length,
                                                                     self.message.length-rang1.location-rang1.length)];
    }
    
    
    //链接
    NSScanner *theScannerSecond;     //scanner
    NSString  *textSecond;           //临时变量
    NSString  *url;
    NSMutableString *urlStr = [NSMutableString string];
    
    if (self.isReply) {
        theScannerSecond = [NSScanner scannerWithString:self.replyStr];
    }else{
        theScannerSecond = [NSScanner scannerWithString:self.message];
    }
    
    while ([theScannerSecond isAtEnd] == NO) {

        [theScannerSecond scanUpToString:@"<a href=\"" intoString:NULL];
        
        [theScannerSecond scanUpToString:@"\" " intoString:&textSecond];
        
        if (textSecond.length != 0) {
            [urlStr appendString:textSecond];
            url = [textSecond stringByReplacingOccurrencesOfString:@"<a href=\"" withString:@""];
            
            [theScannerSecond scanUpToString:@"</a>" intoString:&textSecond];
            [urlStr appendString:textSecond];
            
            if (self.isReply) {
                self.replyStr = [self.replyStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@</a>",urlStr] withString:[NSString stringWithFormat:@"{{{%@}}}",url]];
            }else{
                self.message = [self.message stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@</a>",urlStr] withString:[NSString stringWithFormat:@"{{{%@}}}",url]];
            }
            
            [urlStr setString:@""];
            textSecond = @"";
        }
    }
    // ------处理其他HTML标签
    
    NSScanner *theScanner;
    
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:self.message];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL];
        
        [theScanner scanUpToString:@">" intoString:&text];
        
        self.message = [self.message stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    
    
    // ------处理其他废弃转义符

    self.message = [self.message stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    self.message = [self.message stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    self.replyStr = [self.replyStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    self.replyStr = [self.replyStr stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
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
