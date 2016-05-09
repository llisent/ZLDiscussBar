//
//  ZLPostDetailCellNormal.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/6.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPostDetailModel.h"

@protocol ZLPostDetailCellNormalDelegate <NSObject>

- (void)showImageWith:(UIImage *)img;

@end


@interface ZLPostDetailCellNormal : UITableViewCell

/** 头像*/
@property (weak, nonatomic) IBOutlet UIImageView *authorImg;

/** 作者*/
@property (weak, nonatomic) IBOutlet UILabel     *author;

/** 时间*/
@property (weak, nonatomic) IBOutlet UILabel     *time;

/** 正文*/
@property (weak, nonatomic) IBOutlet UILabel     *mainBody;

/** 图床*/
@property (weak, nonatomic) IBOutlet UIView      *imgViewBed;

/** 图床高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgBedCons;

/** 代理*/
@property (weak, nonatomic) id<ZLPostDetailCellNormalDelegate> delegate;

- (void)updateInfoWithDic:(ZLPostDetailModel *)model;

@end
