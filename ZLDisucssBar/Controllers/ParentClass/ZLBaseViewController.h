//
//  ZLBaseViewController.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/4.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLBaseViewController : UIViewController

@property (nonatomic ,strong) UITableView    *mainTableView;
@property (nonatomic ,strong) NSString       *sourceNum;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,assign) NSUInteger     page;
@property (nonatomic ,strong) NSString       *fid;


//- (void)downloadPostsWithtype:(RefreshType)type;

@end
