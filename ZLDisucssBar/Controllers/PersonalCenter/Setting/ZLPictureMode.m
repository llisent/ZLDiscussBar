//
//  ZLPictureMode.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/16.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPictureMode.h"

@interface ZLPictureMode ()

@property (weak, nonatomic) IBOutlet UIImageView *isPicIcon;
@property (weak, nonatomic) IBOutlet UIImageView *noPicIcon;

@end

@implementation ZLPictureMode

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片模式";
    BOOL isDownLoad = [[ZLGlobal sharedInstence]downLoadImage];
    if (isDownLoad) {
        //不下载图片
        self.isPicIcon.hidden = YES;
    }else{
        //下载图片
        self.noPicIcon.hidden = YES;
    }
}

//选择下载图片
- (IBAction)isPicture:(id)sender {
    self.isPicIcon.hidden = NO;
    self.noPicIcon.hidden = YES;
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"downLoadImage"];
}

//选择不下载图片
- (IBAction)noPicture:(id)sender {
    self.noPicIcon.hidden = NO;
    self.isPicIcon.hidden = YES;
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"downLoadImage"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
