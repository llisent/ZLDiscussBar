//
//  ZLImageCollectionCell.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/24.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLImageCollectionCell.h"

@implementation ZLImageCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

@end
