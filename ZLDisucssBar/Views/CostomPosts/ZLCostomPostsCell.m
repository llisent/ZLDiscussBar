//
//  ZLCostomPostsCell.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/28.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLCostomPostsCell.h"

@implementation ZLCostomPostsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - **************** 更新数据
- (void)updateInformationWithModel:(ZLPostsModel *)model{
    NSString *mass = [[ZLGlobal sharedInstence]avatarMass];
    if ([mass isEqualToString:@"big"] || [mass isEqualToString:@"small"]) {
        NSString *iconUrl      = [NSString stringWithFormat:@"http://uc.zuanke8.com/avatar.php?uid=%@&size=%@",model.authorid,mass];
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:iconUrl]];
    }else{
        self.avatarImageView.image = [UIImage imageNamed:@"noavatar_big.gif"];
    }
    
    self.author.text       = model.author;
    self.title.text        = model.subject;
    self.reportNum.text    = model.replies;
    self.lastPostTime.text = model.dateline;
    self.postsTid          = model.tid;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
