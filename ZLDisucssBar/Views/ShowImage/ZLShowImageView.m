//
//  ZLShowImageView.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/9.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLShowImageView.h"

@implementation ZLShowImageView


- (instancetype)initWithImg:(UIImage *)img{
    self = [super init];
    
    if (self) {
        self.frame              = ScreenBonds;
        self.backgroundColor    = [UIColor cyanColor];
        UIScrollView * scroll   = [[UIScrollView alloc]initWithFrame:ScreenBonds];
        UIImageView  *imageView = [[UIImageView alloc]initWithImage:img];
        imageView.size          = CGSizeMake(ScreenWidth, ScreenWidth/img.size.width * img.size.height);
        
        [scroll addSubview:imageView];
        imageView.center = scroll.center;
        
        
        scroll.contentSize = imageView.size;
        scroll.minimumZoomScale = 1;
        scroll.maximumZoomScale = 2;
        [self addSubview:scroll];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            [self removeFromSuperview];
        }];
        [self addGestureRecognizer:tap];
    }
    return self;
}


@end
