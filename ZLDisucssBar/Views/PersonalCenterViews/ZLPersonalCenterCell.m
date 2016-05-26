//
//  ZLPersonalCenterCell.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/13.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPersonalCenterCell.h"

@implementation ZLPersonalCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.valueLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
