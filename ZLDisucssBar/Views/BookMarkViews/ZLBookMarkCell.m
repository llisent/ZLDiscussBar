//
//  ZLBookMarkCell.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/20.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLBookMarkCell.h"

@implementation ZLBookMarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateFavoriteWith:(ZLFavuriteModel *)model{
    self.dateline.text = model.author;
    self.title.text    = model.title;
    self.tid           = model.id;
    self.replies.text  = model.replies;
}

- (void)updateRecordWith:(ZLPostsModel *)model{
    self.dateline.text = model.author;
    self.title.text    = model.subject;
    self.tid           = model.tid;
}

- (void)updateMythreadWith:(ZLMyThreadModel *)model{
    self.dateline.text = model.dateline;
    self.title.text    = model.subject;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
