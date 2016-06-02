//
//  ZLPersonalInfoViewController.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/17.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLPersonalInfoViewController : UIViewController

/** 待查询用户的uid*/
@property (nonatomic ,strong) NSString     *uid;

@property (nonatomic ,strong) NSDictionary *VariablesDict;




@property (weak, nonatomic  ) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic  ) IBOutlet UILabel     *userName;
@property (weak, nonatomic  ) IBOutlet UILabel     *userIntegral;
@property (weak, nonatomic  ) IBOutlet UILabel     *userLevel;
@property (weak, nonatomic  ) IBOutlet UITableView *infoTableview;

@end
