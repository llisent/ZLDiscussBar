//
//  ZLNoNetWorkView.m
//  ZLDisucssBar
//
//  Created by 赵新 on 16/5/20.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLNoNetWorkView.h"

@implementation ZLNoNetWorkView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"NoNetWorkView" owner:self options:nil][0];
        self.frame = frame;
    }
    return self;
}


- (IBAction)refreshNow:(id)sender {
    [self.delegate refreshCurrentVc];
}

@end
