//
//  ZLBookMarkCell.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/20.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLFavuriteModel.h"
#import "ZLPostsModel.h"

@interface ZLBookMarkCell : UITableViewCell

@property (weak, nonatomic  ) IBOutlet UILabel  *title;
@property (weak, nonatomic  ) IBOutlet UILabel  *dateline;
@property (weak, nonatomic  ) IBOutlet UILabel  *replies;

@property (nonatomic ,strong) NSString *tid;


- (void)updateFavoriteWith:(ZLFavuriteModel *)model;

- (void)updateRecordWith:(ZLPostsModel *)model;

@end
