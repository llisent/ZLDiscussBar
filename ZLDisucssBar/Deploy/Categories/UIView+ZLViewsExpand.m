//
//  UIView+ZLViewsExpand.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/18.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "UIView+ZLViewsExpand.h"

@implementation UIView (ZLViewsExpand)

- (void)showLoadingWithStatus:(NSString *)status{
    [SVProgressHUD showWithStatus:status maskType:SVProgressHUDMaskTypeBlack];
}

@end
