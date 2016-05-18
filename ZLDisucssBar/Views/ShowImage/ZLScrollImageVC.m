//
//  ZLScrollImageVC.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/9.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLScrollImageVC.h"

@interface ZLScrollImageVC ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIImageView *imageView;

@end

@implementation ZLScrollImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self creatConstomUI];
}

- (void)creatConstomUI{
    UIScrollView *scroll        = [[UIScrollView alloc]initWithFrame:ScreenBonds];
    scroll.delegate             = self;
    scroll.maximumZoomScale     = 2.5;
    scroll.minimumZoomScale     = 1;
    [self.view addSubview:scroll];

    self.imageView              = [[UIImageView alloc]initWithImage:self.constomImage];
    self.imageView.size         = self.constomImage.size;
    self.imageView.frame        = CGRectMake(0, 0, ScreenWidth, ScreenWidth / self.constomImage.size.width * self.constomImage.size.height);
    self.imageView.center       = self.view.center;
    [scroll addSubview:self.imageView];

    scroll.contentSize          = self.constomImage.size;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [scroll addGestureRecognizer:tap];
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
