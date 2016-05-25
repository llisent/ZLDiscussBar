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
    self.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth  = 1;
    self.layer.cornerRadius = 6;
    self.clipsToBounds      = YES;
    
}

@end
