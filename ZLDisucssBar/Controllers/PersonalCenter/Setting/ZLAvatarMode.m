//
//  ZLAvatarMode.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/16.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLAvatarMode.h"

@interface ZLAvatarMode ()

@end

@implementation ZLAvatarMode

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"头像模式";
    NSString *string = [[ZLGlobal sharedInstence]avatarMass];
    if ([string isEqualToString:@"big"]) {
        self.highMassImage.hidden   = NO;
        self.normalMassImage.hidden = YES;
        self.noImage.hidden         = YES;
    }else if ([string isEqualToString:@"no"]){
        self.highMassImage.hidden   = YES;
        self.normalMassImage.hidden = YES;
        self.noImage.hidden         = NO;
    }else{
        self.highMassImage.hidden   = YES;
        self.normalMassImage.hidden = NO;
        self.noImage.hidden         = YES;
    }
}
- (IBAction)highMassOnClick:(id)sender {
    self.highMassImage.hidden   = NO;
    self.normalMassImage.hidden = YES;
    self.noImage.hidden         = YES;
    
    [[NSUserDefaults standardUserDefaults]setValue:@"big" forKey:@"avatarMass"];
}
- (IBAction)normalMassOnClick:(id)sender {
    self.highMassImage.hidden   = YES;
    self.normalMassImage.hidden = NO;
    self.noImage.hidden         = YES;
    
    [[NSUserDefaults standardUserDefaults]setValue:@"small" forKey:@"avatarMass"];
}
- (IBAction)noImageOnClick:(id)sender {
    self.highMassImage.hidden   = YES;
    self.normalMassImage.hidden = YES;
    self.noImage.hidden         = NO;
    
    [[NSUserDefaults standardUserDefaults]setValue:@"no" forKey:@"avatarMass"];

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
