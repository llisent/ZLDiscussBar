//
//  ZLPersonalCenter.m
//  ZLDisucssBar
//
//  Created by 赵新 on 16/4/28.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPersonalCenter.h"
#import "ZLPersonalCenterView.h"
#import "ZLPersonalCenterCell.h"
#import "ZLSettingViewController.h"
#import "ZLPersonalInfoViewController.h"
#import "ZLMyThreadVC.h"

@interface ZLPersonalCenter ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong) ZLPersonalCenterView *header;

@property (nonatomic ,strong) UITableView          *mainTableView;

@property (nonatomic ,strong) NSDictionary         *userInfoDict;

@end

@implementation ZLPersonalCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"";
    
    [self creatHeaderUI];               //创建header
    [self creatLoginNotfication];       //注册登录通知
    [self creatConstomUI];              //创建UI
    [self initHeader];                  //刷新头部信息
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //第二次开始 每次刷新信息
    static int a = 0;
    (a != 0) ? ([self initHeader]) : (a++);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - **************** 创建顶部视图(若有缓存信息 则加载缓存信息)
- (void)creatHeaderUI{
    
    self.header       = [[ZLPersonalCenterView alloc]initWithFrame:CGRectMake(0, 0, ScreenHeight, 190)];
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]valueForKey:UserInformation];
    if (dic) {
        [self.header initHeaderDataWith:dic];
    }
    
    __weak typeof(self)weakSelf = self;
    self.header.loginBlock = ^(){
        [weakSelf loginNow];
    };
}

#pragma mark - **************** 立即登录
- (void)loginNow{
    UIStoryboard *sb             = [UIStoryboard storyboardWithName:@"ZLLogin" bundle:[NSBundle mainBundle]];
    UINavigationController *navi = [sb instantiateInitialViewController];
    [self.navigationController presentViewController:navi animated:YES completion:^{
        
    }];
}

#pragma mark - **************** 更新数据
- (void)initHeader{
    if ([[ZLGlobal sharedInstence]isLogin]) {
        
        [[ZLNetworkManager sharedInstence]getUserInfoWithBlock:^(NSDictionary *dict) {
            // ------ 保存登录信息
            self.userInfoDict = dict;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *b = dict[@"space"][@"group"][@"grouptitle"];
                NSString *a = dict[@"space"][@"username"];
                NSString *c = [NSString stringWithFormat:@"%@果果",dict[@"space"][@"credits"]];
                NSDictionary *userInfoDic = @{@"a":a,
                                              @"b":b,
                                              @"c":c};
                [[NSUserDefaults standardUserDefaults]setObject:userInfoDic forKey:UserInformation];
            });
            
            
            // ------更新消息value
            {
                NSUInteger count     = 0;
                NSArray *noticeArray = [dict[@"notice"] allValues];
                
                for (NSString *str in noticeArray) {
                    if (![str isEqualToString:@"0"]) {
                        count += [str integerValue];
                    }
                }
                
                if (count != 0) {
                    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld",count]];
                    [self.mainTableView reloadRow:2 inSection:0 withRowAnimation:UITableViewRowAnimationFade];
                }
            }
            
            [self.header updateInfoWithDict:dict];
        } failure:^(NSError *error) {
            
        }];
        
    }else{
        //未登录
        [self.header updateInfoWithDict:nil];
    }
}

#pragma mark - **************** 注册登录通知
- (void)creatLoginNotfication{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UserLogin object:nil]subscribeNext:^(id x) {
        [self initHeader];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UserExit object:nil]subscribeNext:^(id x) {
        [self.header updateInfoWithDict:nil];
    }];
}

#pragma mark - **************** 创建基本UI
- (void)creatConstomUI{
    self.mainTableView                = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight - 29)];
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.rowHeight      = 45;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.mainTableView registerNib:[UINib nibWithNibName:@"ZLPersonalCenterCell" bundle:nil] forCellReuseIdentifier:@"personalCell"];
    [self.mainTableView setTableHeaderView:self.header];
    [self.view addSubview:self.mainTableView];
}

#pragma mark - **************** TableViewDelegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLPersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personalCell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"个人信息";
            cell.icon.image      = [UIImage imageNamed:@"person"];
            break;
        case 1:
            cell.titleLabel.text = @"我的帖子";
            cell.icon.image      = [UIImage imageNamed:@"post"];
            break;
        case 2:
            cell.titleLabel.text = @"我的消息";
            if (self.navigationController.tabBarItem.badgeValue) {
                cell.valueLabel.hidden = NO;
                cell.valueLabel.text = self.navigationController.tabBarItem.badgeValue;
            }
            cell.icon.image      = [UIImage imageNamed:@"message"];
            break;
        case 3:
            cell.titleLabel.text = @"我的回帖";
            cell.icon.image      = [UIImage imageNamed:@"repost"];
            break;
        case 4:
            cell.titleLabel.text = @"我的交易";
            cell.icon.image      = [UIImage imageNamed:@"shopping"];
            break;
        case 5:
            cell.titleLabel.text = @"设置";
            cell.icon.image      = [UIImage imageNamed:@"setting"];
            break;
        case 6:
            cell.titleLabel.text = @"更多";
            cell.icon.image      = [UIImage imageNamed:@"more"];
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // ------检测是否登录
    if (indexPath.row <= 4) {
        if (![[ZLGlobal sharedInstence]isLogin]) {
            [self.view showJGErrorWithStatus:@"您还未登录"];
            return;
        }
    }
    switch (indexPath.row) {
        case 0:{
            if (self.userInfoDict) {
                ZLPersonalInfoViewController *person = [[ZLPersonalInfoViewController alloc]init];
                person.VariablesDict = self.userInfoDict;
                person.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self presentViewController:person animated:YES completion:^{
                    
                }];
            }else{
                [self.view showJGErrorWithStatus:@"获取信息失败"];
            }
        }
            break;
        case 1:{
            ZLMyThreadVC *vc = [[ZLMyThreadVC alloc]init];
            vc.title = @"我的帖子";
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            [self pushToWebViewWithURL:@"http://www.zuanke8.com/home.php?mod=space&do=pm"];
        }
            break;
        case 3:{
            [self pushToWebViewWithURL:@"http://www.zuanke8.com/forum.php?mod=guide&view=my&type=reply"];
        }
            break;
        case 4:{
            [self pushToWebViewWithURL:@"http://www.zuanke8.com/plugin.php?id=ejew_auction1"];
        }
            break;
        case 5:{
            ZLSettingViewController *setting = [[ZLSettingViewController alloc]init];
            setting.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setting animated:YES];
        }
            break;
        case 6:
            
            break;
            
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - **************** 跳转到网页
- (void)pushToWebViewWithURL:(NSString *)address{
    SVWebViewController *sv     = [[SVWebViewController alloc]initWithAddress:address];
    sv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sv animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
