//
//  ZLCheckSecurityCodeVc.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLCheckSecurityCodeVc : UIViewController

@property (weak, nonatomic  ) IBOutlet UIImageView *securityCodeImageView;
@property (weak, nonatomic  ) IBOutlet UITextField *securityCodeTextField;
@property (weak, nonatomic  ) IBOutlet UIButton    *loginBtn;
@property (nonatomic ,copy  ) NSString    *sechash;
@property (nonatomic ,strong) UIImage     *securityImg;

@end
