//
//  ZLNodataView.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/6/6.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLNodataView.h"

@implementation ZLNodataView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self       = [[NSBundle mainBundle]loadNibNamed:@"ZLNodataView" owner:self options:nil][0];
        self.frame = frame;
    }
    return self;
}

@end
