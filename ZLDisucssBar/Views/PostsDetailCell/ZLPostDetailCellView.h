//
//  ZLPostDetailCellView.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/12.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPostDetailModel.h"


@interface ZLPostDetailCellView : UITableViewCell

/** 头像*/
@property (weak, nonatomic  ) IBOutlet UIImageView       *avatar;

/** 作者*/
@property (weak, nonatomic  ) IBOutlet UILabel           *author;

/** 发布时间*/
@property (weak, nonatomic  ) IBOutlet UILabel           *time;

/** 引用Label*/
@property (weak, nonatomic  ) IBOutlet TYAttributedLabel *quoteLabel;

/** 回复Label*/
@property (weak, nonatomic  ) IBOutlet TYAttributedLabel *replyLabel;

/** 图床*/
@property (weak, nonatomic  ) IBOutlet UIView            *imageBedView;

/** 底层父View*/
@property (weak, nonatomic  ) IBOutlet UIView            *floorView;


@property (nonatomic ,strong) NSArray                    *imgArr;

@property (weak, nonatomic) IBOutlet UIButton *replyBtn;

//依照数据更新布局
- (void)updateInfomationWith:(ZLPostDetailModel *)model;

@end
