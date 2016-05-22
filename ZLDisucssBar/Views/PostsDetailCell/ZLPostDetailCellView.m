//
//  ZLPostDetailCellView.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/12.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPostDetailCellView.h"

@implementation ZLPostDetailCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateInfomationWith:(ZLPostDetailModel *)model{
    
    // ------清除遗留值
    {
        self.author.text  = @"";
        self.time.text    = @"";
        self.avatar.image = nil;
    }
    
    // ------删除约束
    {
        [self.replyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        [self.quoteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        [self.imageBedView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
    
    // ------头像
    NSString *mass = [[ZLGlobal sharedInstence]avatarMass];
    if ([mass isEqualToString:@"big"] || [mass isEqualToString:@"small"] || [mass isEqualToString:@"no"]) {
        if ([mass isEqualToString:@"no"]) {
            self.avatar.image = [UIImage imageNamed:@"noavatar_big.gif"];
        }else{
            NSString *iconUrl      = [NSString stringWithFormat:@"http://uc.zuanke8.com/avatar.php?uid=%@&size=%@",model.authorid,mass];
            [self.avatar sd_setImageWithURL:[NSURL URLWithString:iconUrl]];
        }
    }else{
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://uc.zuanke8.com/avatar.php?uid=%@&size=small",model.authorid]]];
    }
        
    // ------用户名 & 时间
    self.author.text = model.author;
    self.time.text   = model.dateline;
    
    #warning 待修改
    if ([[ZLGlobal sharedInstence]downLoadImage]) {
        self.imgArr = @[];
    }else{
        self.imgArr = model.attachments.allValues;
    }
    
    // ------是否为回帖
    if (model.isReply) {
        self.quoteLabel.hidden             = NO;
        self.quoteLabel.layer.cornerRadius = 3;
        self.quoteLabel.clipsToBounds      = YES;

        [self.quoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.avatar.mas_bottom).offset(10);
            make.bottom.mas_equalTo(self.replyLabel.mas_top).offset(-10);
        }];
        [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.quoteLabel.mas_bottom).offset(10);
        }];
        
    }else{
        self.quoteLabel.hidden = YES;
        [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.avatar.mas_bottom).offset(10);
        }];
    }
    
    // ------是否需要显示图片
    if (self.imgArr.count != 0) {
        self.imageBedView.hidden = NO;
        [self.imageBedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.replyLabel.mas_bottom).offset(10);
            make.bottom.mas_equalTo(self.floorView.mas_bottom).offset(-10);
        }];
    }else{
        self.imageBedView.hidden = YES;
        [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.floorView.mas_bottom).offset(-10);
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
