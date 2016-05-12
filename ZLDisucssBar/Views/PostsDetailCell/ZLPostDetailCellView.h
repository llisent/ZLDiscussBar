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

@property (weak, nonatomic) IBOutlet UIImageView       *avatar;
@property (weak, nonatomic) IBOutlet UILabel           *author;
@property (weak, nonatomic) IBOutlet UILabel           *time;
@property (weak, nonatomic) IBOutlet TYAttributedLabel *quoteLabel;
@property (weak, nonatomic) IBOutlet TYAttributedLabel *replyLabel;
@property (weak, nonatomic) IBOutlet UIView            *imageBedView;

@property (nonatomic ,strong) NSArray *imgArr;

- (void)updateInfomationWith:(ZLPostDetailModel *)model;

@end
