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
     *  目的: 1.检出是否为回复贴(回复内容) 2.检出表情 3.检出链接(替换) 4.替出其他HTML语句 5.检出其他琐碎项
     *  检测效率 考虑加入线程组
     */
        // ------判断是否为回复贴 为Model属性赋值
    
    {
        //忽略字符
        self.message = [self.message stringByReplacingOccurrencesOfString:@"isconvert=1 " withString:@""];
    }
    
    
    
        NSRange ran = [self.message rangeOfString:@"</blockquote></div>"];
        ran.length ? (self.isReply = YES) : (self.isReply = NO);
    if (self.isReply) {
        NSLog(@"123");
    }
        NSString *allValues = self.message;
    
        // ------检出表情 & 检出网址链接 （待优化）
        NSScanner *theScannerFirst;     //scanner
        NSString  *textFirst;           //临时变量
        NSString  *img;                 //图片变量
        
        NSMutableString *replaceStr = [NSMutableString string];
        theScannerFirst             = [NSScanner scannerWithString:allValues];
        
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
                allValues = [allValues stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",replaceStr] withString:img];
                [replaceStr setString:@""];
                textFirst = @"";
            }
        }
        
        // ------处理回复与被回复串
        if (self.isReply) {
            NSRange rang1 = [allValues rangeOfString:@"</blockquote></div><br />" options:NSBackwardsSearch];
            self.message  = [allValues substringWithRange:NSMakeRange(rang1.location+rang1.length,
                                                                         allValues.length-rang1.location-rang1.length)];
        }
    
    
        //链接(被引用内容系统默认会转换 所以 只转换回复内容)1.引用 转换self.message  非引用 转allvalues
        NSScanner *theScannerSecond;
        NSString  *textSecond;           //临时变量
        NSString  *url;
        NSMutableString *urlStr = [NSMutableString string];
        if (self.isReply) {
            theScannerSecond = [NSScanner scannerWithString:self.message];
        }else{
            theScannerSecond = [NSScanner scannerWithString:allValues];
        }
    
        while ([theScannerSecond isAtEnd] == NO) {
            
            [theScannerSecond scanUpToString:@"<a href=\"" intoString:NULL];
            [theScannerSecond scanUpToString:@"\" " intoString:&textSecond];
            
            if (textSecond.length != 0) {
                
                [urlStr appendString:textSecond];
                url = [textSecond stringByReplacingOccurrencesOfString:@"<a href=\"" withString:@""];
                
                [theScannerSecond scanUpToString:@"</a>" intoString:&textSecond];
                [urlStr appendString:textSecond];
                
                NSString *result = [NSString stringWithFormat:@"%@</a>",urlStr];
                if (self.isReply) {
                    self.message = [self.message stringByReplacingOccurrencesOfString:result withString:url];
                }else{
                    allValues = [allValues stringByReplacingOccurrencesOfString:result withString:url];
                }
                [urlStr setString:@""];
                textSecond = @"";
            }
        }


        // ------处理其他HTML标签
        
        NSScanner *theScanner;
        
        NSString *text = nil;
        
        theScanner = [NSScanner scannerWithString:allValues];
        
        while ([theScanner isAtEnd] == NO) {
            
            [theScanner scanUpToString:@"<" intoString:NULL];
            
            [theScanner scanUpToString:@">" intoString:&text];
            
            allValues = [allValues stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
            if (self.isReply) {
                self.message = [self.message stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
            }
        }
        // ------处理其他废弃转义符
        allValues  = [allValues stringByReplacingOccurrencesOfString:@"&nbsp;"  withString:@" "];
        allValues  = [allValues stringByReplacingOccurrencesOfString:@"&amp;"   withString:@"&"];
    
    if (self.isReply) {
        self.message = [self.message stringByReplacingOccurrencesOfString:@"&nbsp;"  withString:@" "];
        self.message = [self.message stringByReplacingOccurrencesOfString:@"&amp;"  withString:@"&"];
    }
    
        if (self.isReply) {
            self.quoteStr = [allValues stringByReplacingOccurrencesOfString:self.message  withString:@""];
            self.container2 = [self.quoteStr makeContainerWithType:0];
            self.container1 = [self.message makeContainerWithType:1];
        }else{
            self.message    = allValues;
            self.container1 = [allValues makeContainerWithType:1];
        }

}

@end
