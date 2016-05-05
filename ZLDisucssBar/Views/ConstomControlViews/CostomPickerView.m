//
//  CostomPickerView.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "CostomPickerView.h"

@implementation CostomPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self       = [[NSBundle mainBundle]loadNibNamed:@"CostomPickerView" owner:self options:nil][0];
        self.frame = frame;
    }
    return self;
}


@end
