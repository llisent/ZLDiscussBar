//
//  ZLPersonalInfoCell.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/6/2.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLPersonalInfoCell : UITableViewCell

@property (weak, nonatomic  ) IBOutlet UILabel      *titleLabel;
@property (weak, nonatomic  ) IBOutlet UILabel      *contentLabel;


- (void)updateInfomationWith:(NSDictionary *)dic rowsNum:(NSInteger)num;

@end
