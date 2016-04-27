//
//  ZLMainLoginViewController.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLMainLoginViewController : UIViewController

/** 账号*/
@property (weak, nonatomic) IBOutlet UITextField *userIDTextField;

/** 密码*/
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

/** 安全问题*/
@property (weak, nonatomic) IBOutlet UILabel     *safetyLabel;

/** 安全问题答案*/
@property (weak, nonatomic) IBOutlet UITextField *safetyAnswerTextField;

/** 登陆*/
@property (weak, nonatomic) IBOutlet UIButton    *loginButton;

@end
