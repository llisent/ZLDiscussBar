//
//  ZLAvatarMode.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/16.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLAvatarMode : UIViewController

/** 高质量头像对号*/
@property (weak, nonatomic) IBOutlet UIImageView *highMassImage;

/** 普通质量图片对号*/
@property (weak, nonatomic) IBOutlet UIImageView *normalMassImage;

/** 无图对号*/
@property (weak, nonatomic) IBOutlet UIImageView *noImage;

@end
