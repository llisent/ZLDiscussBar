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
    UIScrollView *scroll        = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scroll.delegate             = self;
    scroll.maximumZoomScale     = 2.0f;
    scroll.minimumZoomScale     = 1.0f;
    [self.view addSubview:scroll];

    CGFloat height              = ScreenWidth / self.constomImage.size.width * self.constomImage.size.height;
    self.imageView              = [[UIImageView alloc]initWithImage:self.constomImage];
    self.imageView.size         = self.constomImage.size;
    self.imageView.frame        = CGRectMake(0, ScreenHeight/2 - height/2, ScreenWidth, height);
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

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    
    //目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点为屏幕中点，此种情况确保图像在屏幕中心。
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    [self.imageView setCenter:CGPointMake(xcenter, ycenter)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
