//
//  UIView+ZLViewsExpand.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/18.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZLViewsExpand)

- (void)showLoadingWithStatus:(NSString *)status;

- (void)showSuccessWithStatus:(NSString *)status;

- (void)showErrorWithStatus:(NSString *)status;

- (void)showJGErrorWithStatus:(NSString *)status;

- (void)dismissLoading;

- (void)showJGSuccessWithStatus:(NSString *)status;



@end
