//
//  ZLHomePageViewController.m
//  ZLDisucssBar
//
//  Created by 赵新 on 16/4/28.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLHomePageViewController.h"
#import "ZLCostomPostsCell.h"
#import "ZLPostsModel.h"
#import "ZLPostsDetailVC.h"


@interface ZLHomePageViewController ()<UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,strong) UITableView    *mainTableView;
@property (nonatomic ,assign) NSInteger      page;
@property (nonatomic ,assign) HPGetInfoType  type;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) NSMutableSet   *dataSet;
@property (nonatomic ,strong) UIButton       *reloadBtn;

@property (nonatomic ,assign) BOOL isLocked;


@end

@implementation ZLHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赚客大家谈";
    self.edgesForExtendedLayout               = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.dataArray                            = [NSMutableArray array];
    self.dataSet                              = [NSMutableSet set];
    self.page = 1;
    
    [self initData];
    [self creatConstomUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.hidesBottomBarWhenPushed = YES;
    [self test];

}

#pragma mark - **************** UI
- (void)creatConstomUI{
    self.view.backgroundColor         = [UIColor whiteColor];
    self.mainTableView                = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49)];
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ZLCostomPostsCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        self.type = HPGetInfoTypeRefresh;
        [self initData];
    }];
    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        self.type = HPGetInfoTypeLoadMore;
        [self initData];
    }];
    
    [self.view addSubview: self.mainTableView];
    [self creatReloadBar];
}

#pragma mark - **************** 旋转按钮
- (void)creatReloadBar{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth - 76, ScreenHeight - 64 - 49 - 10 - 66 , 66, 66)];
    bgView.layer.cornerRadius = 12;
    bgView.backgroundColor = [UIColor colorWithWhite:0.784 alpha:0.400];
    
    self.reloadBtn = [[UIButton alloc]initWithFrame:CGRectMake(4, 4, 58, 58)];
    [self.reloadBtn setImage:[UIImage imageNamed:@"pic_icon_fresh"] forState:UIControlStateNormal];
    [bgView addSubview:self.reloadBtn];
    
    [[self.reloadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (!self.isLocked) {
            self.isLocked = YES;
            [self startRotation];
            [self.mainTableView.mj_header beginRefreshing];
            self.page     = 1;
            self.type     = HPGetInfoTypeRefresh;
            [self initData];
        }
    }];
    [self.view addSubview:bgView];
}

#pragma mark - **************** 开始旋转
- (void)startRotation{

    CABasicAnimation *anim   = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.byValue = [NSNumber numberWithFloat:M_PI * 2];
    anim.repeatCount         = MAXFLOAT;
    anim.removedOnCompletion = NO;
    anim.duration            = 1.8f;
    anim.fillMode            = kCAFillModeForwards;
    [self.reloadBtn.layer addAnimation:anim forKey:nil];

}

#pragma mark - **************** 停止旋转
- (void)endRotation{
    [self.reloadBtn.layer removeAllAnimations];
}

#pragma mark - **************** 停止刷新
- (void)endingRefreshing{
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
}

#pragma mark - **************** 数据
- (void)initData{
    [[ZLNetworkManager sharedInstence]getInfoWithFid:@"15" page:_page block:^(NSDictionary *dict) {

        NSString *formHash = dict[@"formhash"];
        if (formHash) {
            [[ZLGlobal sharedInstence]setGachincoFormHash:formHash];
        }
        
        NSArray *data = dict[@"forum_threadlist"];
        if (self.type != HPGetInfoTypeLoadMore) {
            //下拉--置空数组/set 加入model 把tid加入到set中
            [self.dataArray removeAllObjects];
            [self.dataSet removeAllObjects];
            for (NSDictionary *item in data) {
                ZLPostsModel *model = [ZLPostsModel mj_objectWithKeyValues:item];
                [self.dataArray addObject:model];
                [self.dataSet addObject:model.tid];
            }
        }else{
            //上拉--判断set 不重复则将model加入数组中
            for (NSDictionary *item in data) {
                ZLPostsModel *model = [ZLPostsModel mj_objectWithKeyValues:item];
                NSInteger num1 = self.dataSet.count;
                [self.dataSet addObject:model.tid];
                if (self.dataSet.count != num1) {
                    [self.dataArray addObject:model];
                }
            }
        }
        [self endingRefreshing];
        self.isLocked = NO;
        [self endRotation];
        [self.mainTableView reloadData];
    } failure:^(NSError *error) {
        [self endingRefreshing];
        self.isLocked = NO;
        [self endRotation];
    }];
}


#pragma mark - **************** Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLCostomPostsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZLPostsModel *model = self.dataArray[indexPath.row];
    [cell updateInformationWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15]};
    ZLPostsModel *model = self.dataArray[indexPath.row];
    
    CGSize size = [model.subject boundingRectWithSize:CGSizeMake(ScreenWidth-20, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size.height + 86;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLPostsModel *model = self.dataArray[indexPath.row];
    ZLPostsDetailVC * vc = [[ZLPostsDetailVC alloc]init];
    vc.tid = model.tid;
//    if (model.readperm > [[ZLUserInfo sharedInstence]readaccess]) {
//        [SVProgressHUD showErrorWithStatus:@"权限不足"];
//        return;
//    }
    vc.title = model.tid;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)test{
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    [self.navigationItem setLeftBarButtonItem:left];
}

- (void)login{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ZLLogin" bundle:[NSBundle mainBundle]];
    UINavigationController *navi = [sb instantiateInitialViewController];
    
    [self.navigationController presentViewController:navi animated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
