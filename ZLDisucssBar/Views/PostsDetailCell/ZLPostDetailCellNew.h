//
//  ZLPostDetailCellNew.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/11.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPostDetailModel.h"

@interface ZLPostDetailCellNew : UITableViewCell

/** 用户头像*/
@property (nonatomic ,strong) UIImageView              *userIcon;

/** 用户昵称*/
@property (nonatomic ,strong) UILabel                  *userName;

/** 发表时间*/
@property (nonatomic ,strong) UILabel                  *dateLine;

/** 消息*/
@property (nonatomic ,strong) TYAttributedLabel        *message;

/** 被回复的消息*/
@property (nonatomic ,strong) TYAttributedLabel        *replyMessage;

/** 图床*/
@property (nonatomic ,strong) UIView                   *imgBed;

/** Model*/
@property (nonatomic ,strong) ZLPostDetailModel        *mainModel;

/** 图组*/
@property (nonatomic ,strong) NSArray                  *imgArr;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier userModel:(ZLPostDetailModel *)model;

- (void)updateWithModel:(ZLPostDetailModel *)model returnBlock:(void(^)(TYTextContainer *tc))block;

@end
