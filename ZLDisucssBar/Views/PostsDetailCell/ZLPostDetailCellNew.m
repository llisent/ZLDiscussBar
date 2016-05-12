//
//  ZLPostDetailCellNew.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/11.
//  Copyright © 2016年 llisent. All rights reserved.
//

/**
 *  UI-不考虑是否含有图片画UI --- 顶部UI --- 是否有回复(1.画两个 2.画一个)
 *  最后画图片组
 */

#import "ZLPostDetailCellNew.h"

@implementation ZLPostDetailCellNew

- (void)awakeFromNib {
    [super awakeFromNib];
    [self creatConstomUI];
}

- (void)creatConstomUI{
    
}

- (void)updateWithModel:(ZLPostDetailModel *)model returnBlock:(void(^)(TYTextContainer *tc))block{
    [self removeAllSubviews];
    
    self.mainModel = model;
    self.imgArr    = model.attachments.allValues;
    
    if ([[ZLGlobal sharedInstence]downLoadImage]) {
        self.imgArr = @[];
    }
    [self initCostomTop];
    
    // ------底部
    if (![model isReply]) {
        TYTextContainer *text = [self haha];
        block(text);
    }else{
        [self initReplyBottom];
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

- (TYTextContainer *)haha{
    self.message               = [[TYAttributedLabel alloc]init];
    [self addSubview:self.message];
    
    TYTextContainer *container = [[TYTextContainer alloc]init];
    container.text             = self.mainModel.message;
    NSMutableArray *tmpArray   = [NSMutableArray array];
    
    
    // ------表情正则\[\[\[(\d+?)\]\]\]
    // ------网址正则\{\{\{[a-zA-z]+://[^\s]*\}\}\} (可优化)
    
    [self.mainModel.message enumerateStringsMatchedByRegex:@"\\[\\[\\[(\\d+?)\\]\\]\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        TYImageStorage *imageStorage    = [[TYImageStorage alloc]init];
        imageStorage.cacheImageOnMemory = YES;
        imageStorage.imageName          = [NSString stringWithFormat:@"smile%@.gif",capturedStrings[1]];
        imageStorage.range              = capturedRanges[0];
        imageStorage.size               = ([capturedStrings[1] intValue] > 30) ? CGSizeMake(60, 60) : CGSizeMake(20, 20);
        [tmpArray addObject:imageStorage];
    }];
    [container addTextStorageArray:tmpArray];
    
    [self.mainModel.message enumerateStringsMatchedByRegex:@"[a-zA-z]+://[^\\s]*" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        [container addLinkWithLinkData:capturedStrings[0]
                             linkColor:[UIColor blueColor]
                        underLineStyle:kCTUnderlineStyleSingle
                                 range:capturedRanges[0]];
    }];
    
    self.message.textContainer           = container;
    self.message.frame                   = CGRectMake(0, 60, ScreenWidth, 300);
    self.message.backgroundColor         = [UIColor cyanColor];
    self.message.preferredMaxLayoutWidth = ScreenWidth - 20;
    [self.message sizeToFit];
    
    if (self.imgArr.count == 0) {
        [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.userIcon.mas_bottom).offset(10);
            make.bottom.equalTo(self).offset(-10);
            make.left.equalTo(self.userIcon);
            make.right.equalTo(self).offset(-10);
        }];
    }else{
        self.imgBed = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self addSubview:self.imgBed];
        
        [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.userIcon.mas_bottom).offset(10);
            make.bottom.equalTo(self).offset(-10);
            make.left.equalTo(self.userIcon);
        }];
        
        [self.imgBed mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.message).offset(10);
            make.bottom.equalTo(self).offset(-10);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
        }];
    }
    return container;
}

//- (TYTextContainer *)initCostomBottom{
//    self.message               = [[TYAttributedLabel alloc]init];
//    [self addSubview:self.message];
//
//    TYTextContainer *container = [[TYTextContainer alloc]init];
//    container.text             = self.mainModel.message;
//    NSMutableArray *tmpArray   = [NSMutableArray array];
//    
//    
//    // ------表情正则\[\[\[(\d+?)\]\]\]
//    // ------网址正则\{\{\{[a-zA-z]+://[^\s]*\}\}\} (可优化)
//
//    [self.mainModel.message enumerateStringsMatchedByRegex:@"\\[\\[\\[(\\d+?)\\]\\]\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
//        
//            TYImageStorage *imageStorage    = [[TYImageStorage alloc]init];
//            imageStorage.cacheImageOnMemory = YES;
//            imageStorage.imageName          = [NSString stringWithFormat:@"smile%@.gif",capturedStrings[1]];
//            imageStorage.range              = capturedRanges[0];
//            imageStorage.size               = ([capturedStrings[1] intValue] > 30) ? CGSizeMake(60, 60) : CGSizeMake(20, 20);
//            [tmpArray addObject:imageStorage];
//    }];
//    [container addTextStorageArray:tmpArray];
//
//    [self.mainModel.message enumerateStringsMatchedByRegex:@"[a-zA-z]+://[^\\s]*" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
//        
//        [container addLinkWithLinkData:capturedStrings[0]
//                             linkColor:[UIColor blueColor]
//                        underLineStyle:kCTUnderlineStyleSingle
//                                 range:capturedRanges[0]];
//    }];
//    
//    self.message.textContainer           = container;
//    self.message.frame                   = CGRectMake(0, 60, ScreenWidth, 300);
//    self.message.backgroundColor         = [UIColor cyanColor];
//    self.message.preferredMaxLayoutWidth = ScreenWidth - 20;
//    [self.message sizeToFit];
//    
//    if (self.imgArr.count == 0) {
//        [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.userIcon.mas_bottom).offset(10);
//            make.bottom.equalTo(self).offset(-10);
//            make.left.equalTo(self.userIcon);
//            make.right.equalTo(self).offset(-10);
//        }];
//    }else{
//        self.imgBed = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//        [self addSubview:self.imgBed];
//        
//        [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.userIcon.mas_bottom).offset(10);
//            make.bottom.equalTo(self).offset(-10);
//            make.left.equalTo(self.userIcon);
//        }];
//        
//        [self.imgBed mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.message).offset(10);
//            make.bottom.equalTo(self).offset(-10);
//            make.left.equalTo(self).offset(10);
//            make.right.equalTo(self).offset(-10);
//        }];
//    }
//    
//}

- (void)initReplyBottom{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
