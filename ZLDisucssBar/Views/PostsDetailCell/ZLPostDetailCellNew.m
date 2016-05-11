//
//  ZLPostDetailCellNew.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/11.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPostDetailCellNew.h"

@implementation ZLPostDetailCellNew

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateWithModel:(ZLPostDetailModel *)model{
    [self removeAllSubviews];
    
    self.mainModel = model;
    self.imgArr    = model.attachments.allValues;
    
    if ([[ZLGlobal sharedInstence]downLoadImage]) {
        self.imgArr = @[];
    }
    [self initCostomTop];
    
    // ------底部
    if (![model isReply]) {
        [self initCostomBottom];
    }else{
        
    }
}

- (void)initCostomTop{
    // ------顶部基本控件
    self.userIcon     = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    self.userName     = [[UILabel alloc]init];
    self.dateLine     = [[UILabel alloc]init];
    
    [self addSubview:self.userIcon];
    [self addSubview:self.userName];
    [self addSubview:self.dateLine];
    
    // ------基本控件UI
    self.userName.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    self.dateLine.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    
    // ------顶部约束
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userIcon.mas_right).offset(12);
        make.top.equalTo(self.userIcon);
    }];
    [self.dateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName);
        make.bottom.equalTo(self.userIcon);
    }];
    
    // ------顶部赋值
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://uc.zuanke8.com/avatar.php?uid=%@&size=big",self.mainModel.authorid]]];
    self.userName.text = self.mainModel.author;
    self.dateLine.text = self.mainModel.dateline;
}

- (void)initCostomBottom{
    self.message               = [[TYAttributedLabel alloc]init];
    [self addSubview:self.message];

    TYTextContainer *container = [[TYTextContainer alloc]init];
    container.text             = self.mainModel.message;
    NSMutableArray *tmpArray   = [NSMutableArray array];
    
//    表情正则
//    \[\[\[(\d+?)\]\]\]
//    网址正则
//    \{\{\{(\d+?)\}\}\}
    [self.mainModel.message enumerateStringsMatchedByRegex:@"\\[\\[\\[(\\d+?)\\]\\]\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        if (captureCount > 3) {
            // 图片信息储存
            TYImageStorage *imageStorage = [[TYImageStorage alloc]init];
            imageStorage.cacheImageOnMemory = YES;
            imageStorage.imageName = capturedStrings[1];
            imageStorage.range = capturedRanges[0];
            imageStorage.size = CGSizeMake([capturedStrings[2]intValue], [capturedStrings[3]intValue]);
            
            [tmpArray addObject:imageStorage];
        }
    }];

    
}


































- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
