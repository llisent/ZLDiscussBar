//
//  ZLCostomPostsCell.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/28.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLCostomPostsCell : MGSwipeTableCell

/** 头像*/
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

/** 作者*/
@property (weak, nonatomic) IBOutlet UILabel     *author;

/** 最后回复时间*/
@property (weak, nonatomic) IBOutlet UILabel     *lastPostTime;

/** 标题*/
@property (weak, nonatomic) IBOutlet UILabel     *title;

/** 回复数*/
@property (weak, nonatomic) IBOutlet UILabel     *reportNum;



#pragma mark - **************** 更新数据
- (void)updateInformationWithModel:(ZLPostsModel *)model;


@end