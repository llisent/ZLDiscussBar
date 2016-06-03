//
//  ZLPlateCell.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/25.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPlateCell.h"

@implementation ZLPlateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // ------加边框
    self.layer.borderColor  = [UIColor colorWithRed:0.901 green:0.507 blue:0.208 alpha:1.000].CGColor;
    self.layer.borderWidth  = 1;
    self.layer.cornerRadius = 6;
    self.clipsToBounds      = YES;
    
}

@end
