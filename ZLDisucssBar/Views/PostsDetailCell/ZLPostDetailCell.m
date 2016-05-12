//
//  ZLPostDetailCell.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/10.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPostDetailCell.h"

@implementation ZLPostDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier userModel:(ZLPostDetailModel *)model{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self updateWithModel:model];
    }
    return self;
}

- (void)updateWithModel:(ZLPostDetailModel *)model{
    
    [self removeAllSubviews];
    self.mainModel = model;
    self.imgArr    = model.attachments.allValues;
    #warning 待修改
    if ([[ZLGlobal sharedInstence]downLoadImage]) {
        self.imgArr = @[];
    }
    [self initTop];
    
    // ------底部
    if (![model isReply]) {
        [self initBottomNormal];
    }else{
        [self initBottomReply];
        
    }
    if (self.imgBed) {
        [self initImgBed];
    }
}


- (void)initTop{
    // ------顶部基本控件
    self.userIcon     = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    self.userName     = [[UILabel alloc]init];
    self.dateLine     = [[UILabel alloc]init];

    [self addSubview:self.userIcon];
    [self addSubview:self.userName];
    [self addSubview:self.dateLine];
    
    // ------基本控件UI
    self.userName.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    self.dateLine.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    
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

//非回复贴
- (void)initBottomNormal{
    self.message               = [[YYLabel alloc]init];
    self.message.text          = self.mainModel.message;
    self.message.numberOfLines = 0;
    self.message.font          = [UIFont fontWithName:@"HelveticaNeue" size:15];
    [self addSubview:self.message];

    if (self.imgArr.count == 0) {
        //无图
        [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.userIcon.mas_bottom).offset(10);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self).offset(-10);
        }];
    }else{
        //有图
        self.imgBed = [[UIView alloc]init];
        [self addSubview:self.imgBed];
        [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.mas_equalTo(self.userIcon.mas_bottom).offset(10);
        }];
        
        [self.imgBed mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.message.mas_bottom).offset(10);
            make.bottom.equalTo(self).offset(-10);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.mas_equalTo(((ScreenWidth - 40)/3 + 10) * ((self.imgArr.count % 3 == 0) ? (self.imgArr.count / 3) : (self.imgArr.count / 3) + 1));
        }];
        
        
    }
}

//回复贴
- (void)initBottomReply{
    
    self.messageView                  = [[UIView alloc]init];
    self.message                      = [[YYLabel alloc]init];
    self.replyMessage                 = [[YYLabel alloc]init];

    [self addSubview:self.messageView];
    [self.messageView addSubview:self.message];
    [self.messageView addSubview:self.replyMessage];


    self.messageView.backgroundColor  = [UIColor cyanColor];
    self.replyMessage.backgroundColor = [UIColor purpleColor];
    self.message.backgroundColor = [UIColor lightGrayColor];
    self.replyMessage.font            = [UIFont fontWithName:@"HelveticaNeue" size:15];
    self.message.font                 = [UIFont fontWithName:@"HelveticaNeue" size:15];
    self.replyMessage.numberOfLines   = 0;
    self.message.numberOfLines        = 0;

    self.replyMessage.text            = self.mainModel.quoteStr;
    self.message.text                 = self.mainModel.message;
    
    if (self.imgArr.count == 0) {
        //无图
        [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.mas_equalTo(self.userIcon.mas_bottom).offset(10);
            make.bottom.equalTo(self).offset(-10);
        }];
        
    }else{
        //有图
        self.imgBed = [[UIView alloc]init];
        [self addSubview:self.imgBed];
        [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.mas_equalTo(self.userIcon.mas_bottom).offset(10);
        }];
        [self.imgBed mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self).offset(-10);
            make.top.mas_equalTo(self.messageView.mas_bottom).offset(10);
            make.height.mas_equalTo(((ScreenWidth - 40)/3 + 10) * ((self.imgArr.count % 3 == 0) ? (self.imgArr.count / 3) : (self.imgArr.count / 3) + 1));
        }];
    }
    [self.replyMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageView).offset(10);
        make.left.equalTo(self.messageView).offset(10);
        make.right.equalTo(self.messageView).offset(-10);
        make.bottom.mas_equalTo(self.message.mas_top).offset(-10);
        make.height.equalTo(@100);
    }];
    
    
    
    [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.replyMessage.mas_bottom).offset(10);
        make.left.equalTo(self.messageView).offset(10);
        make.right.equalTo(self.messageView).offset(-10);
        make.bottom.equalTo(self.messageView).offset(-10);
    }];

}

//图床
- (void)initImgBed{
    for (int i = 0; i < [self.imgArr count]; i++) {
        NSDictionary *dic      = self.imgArr[i];
        NSString *url          = [NSString stringWithFormat:@"http://img.zuanke8.com/forum/%@",dic[@"attachment"]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(((ScreenWidth - 40)/3 + 10) * (i%3),
                                                                              (i/3) * ((ScreenWidth - 40)/3 + 10),
                                                                              (ScreenWidth-40)/3,
                                                                              (ScreenWidth-40)/3)];
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        [self.imgBed addSubview:imageView];
        
        SDWebImageDownloader *dl = [SDWebImageDownloader sharedDownloader];
        [dl downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            
            UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                
                //                [self.delegate showImageWith:image];
                
            }];
            [imageView addGestureRecognizer:ges];
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}














@end
