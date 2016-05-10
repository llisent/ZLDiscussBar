//
//  ZLPostDetailCell.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/10.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPostDetailModel.h"

@protocol ZLPostDetailCellDelegate <NSObject>

- (void)showImage:(UIImage *)img;

@end


@interface ZLPostDetailCell : UITableViewCell

/** 用户头像*/
@property (nonatomic ,strong) UIImageView              *userIcon;

/** 用户昵称*/
@property (nonatomic ,strong) UILabel                  *userName;

/** 发表时间*/
@property (nonatomic ,strong) UILabel                  *dateLine;

/** 消息床*/
@property (nonatomic ,strong) UIView                   *messageView;

/** 消息*/
@property (nonatomic ,strong) YYLabel                  *message;

/** 被回复的消息*/
@property (nonatomic ,strong) YYLabel                  *replyMessage;

/** 图床*/
@property (nonatomic ,strong) UIView                   *imgBed;

/** 代理*/
@property (nonatomic ,weak  ) id<ZLPostDetailCellDelegate> delegate;

/** Model*/
@property (nonatomic ,strong) ZLPostDetailModel        *mainModel;

/** 图组*/
@property (nonatomic ,strong) NSArray                  *imgArr;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier userModel:(ZLPostDetailModel *)model;


- (void)updateWithModel:(ZLPostDetailModel *)model;


@end
