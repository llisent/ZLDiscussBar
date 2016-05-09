//
//  ZLPostDetailCellNormal.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/6.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPostDetailCellNormal.h"
#import "ZLShowImageView.h"

@implementation ZLPostDetailCellNormal

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateInfoWithDic:(ZLPostDetailModel *)model{
    [self.authorImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://uc.zuanke8.com/avatar.php?uid=%@&size=big",model.authorid]]];
    self.author.text   = model.author;
    self.time.text     = model.dateline;
    self.mainBody.text = model.message;
    
    if (self.imgViewBed.subviews.count != 0) {
        [self.imgViewBed removeAllSubviews];
    }

    NSArray *imgArr    = [model.attachments allValues];
    
    //无图 Or 用户不加载图片
    if (imgArr.count == 0 || [[ZLGlobal sharedInstence] downLoadImage]) {
        self.imgBedCons.constant = 0;
    }else{
        self.imgBedCons.constant = ((ScreenWidth - 40)/3 + 10) * ((imgArr.count % 3 == 0) ? (imgArr.count / 3) : (imgArr.count / 3) + 1);
        

        for (int i = 0; i < [imgArr count]; i++) {
            
            NSDictionary *dic      = imgArr[i];
            NSString *url          = [NSString stringWithFormat:@"http://img.zuanke8.com/forum/%@",dic[@"attachment"]];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(((ScreenWidth - 40)/3 + 10) * (i%3),
                                                                                  (i/3) * ((ScreenWidth - 40)/3 + 10),
                                                                                  (ScreenWidth-40)/3,
                                                                                  (ScreenWidth-40)/3)];
            imageView.userInteractionEnabled = YES;
            [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
            [self.imgViewBed addSubview:imageView];

            SDWebImageDownloader *dl = [SDWebImageDownloader sharedDownloader];
            [dl downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                
                UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
//                ZLShowImageView *view       = [[ZLShowImageView alloc]initWithImg:image];
//                    [[[UIApplication sharedApplication]keyWindow]addSubview:view];
                    [self.delegate showImageWith:image];
                    
                }];
                [imageView addGestureRecognizer:ges];
            }];
        }
    }
    [self updateConstraints];
    [self updateFocusIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
