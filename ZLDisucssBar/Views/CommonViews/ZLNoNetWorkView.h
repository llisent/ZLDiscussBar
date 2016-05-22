//
//  ZLNoNetWorkView.h
//  ZLDisucssBar
//
//  Created by 赵新 on 16/5/20.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZLNoNetWorkViewDelegate <NSObject>

- (void)refreshCurrentVc;

@end

@interface ZLNoNetWorkView : UIView

@property (nonatomic ,weak) id<ZLNoNetWorkViewDelegate> delegate;

@end
