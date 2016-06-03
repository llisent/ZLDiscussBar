//
//  ZLBookMarkViewController.m
//  ZLDisucssBar
//
//  Created by 赵新 on 16/4/28.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLBookMarkViewController.h"
#import "ZLFavuriteModel.h"
#import "ZLBookMarkCell.h"
#import "ZLPostsDetailVC.h"
#import "ZLRecordCell.h"
#import "ZLPostsModel.h"

@interface ZLBookMarkViewController ()<UITableViewDelegate, UITableViewDataSource>

/** daddyView*/
@property (nonatomic ,strong) UIScrollView       *mainScroll;

/** 收藏tableview*/
@property (nonatomic ,strong) UITableView        *favoriteTableView;

/** 历史tableview*/
@property (nonatomic ,strong) UITableView        *recordTableView;

/** segment*/
@property (nonatomic ,strong) UISegmentedControl *segmentControl;

/** 收藏数组*/
@property (nonatomic ,strong) NSMutableArray     *favoriteArray;

/** 历史数组*/
@property (nonatomic ,strong) NSArray            *recordArray;

/** 收藏记录页码*/
@property (nonatomic ,assign) NSInteger          page;


@property (nonatomic ,strong) NSDictionary       *plateDic;


@property (nonatomic ,assign) HPGetInfoType      type;

@end

@implementation ZLBookMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    {
        self.page          = 1;
        self.favoriteArray = [NSMutableArray array];
        self.recordArray   = [NSArray array];
        

    }
    [self creatNavigationBar];
    [self creatConstomUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self initData];
    });
    
    static int a = 0;
    (a != 0) ? ([self initDataOnceMore]) : (a++);
}

#pragma mark - **************** lazy

- (NSDictionary *)plateDic{
    if (!_plateDic) {
        _plateDic =      @{@"2":@"免费赠品",
                          @"15":@"赚客大家谈",
                          @"11":@"做任务赚果果",
                          @"13":@"有奖活动",
                          @"14":@"有奖调查",
                          @"19":@"活动线报",
                          @"20":@"赚品显摆",
                          @"22":@"获奖名单",
                          @"24":@"微博活动",
                          @"25":@"赚品交换",
                          @"26":@"求助咨询",
                          @"27":@"活动秘籍",
                          @"29":@"区域活动",
                          @"30":@"抢楼秒杀",
                          @"31":@"果果换物"};
    }
    return _plateDic;
}

#pragma mark - **************** 初始化UI
- (void)creatConstomUI{
    // ------创建Scroll
    self.mainScroll                       = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.mainScroll.pagingEnabled         = YES;
    self.mainScroll.scrollEnabled         = YES;
    self.mainScroll.delegate              = self;
    self.mainScroll.bounces               = NO;
    self.mainScroll.contentSize           = CGSizeMake(ScreenWidth * 2, ScreenHeight - 64 - 49);
    [self.view addSubview:self.mainScroll];

    // ------创建收藏TableView
    self.favoriteTableView                = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49)];
    self.favoriteTableView.delegate       = self;
    self.favoriteTableView.dataSource     = self;
    self.favoriteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.favoriteTableView registerNib:[UINib nibWithNibName:@"ZLBookMarkCell" bundle:nil] forCellReuseIdentifier:@"favorite"];
    self.favoriteTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self initFavoriteData];
    }];
    self.favoriteTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        self.type = HPGetInfoTypeRefresh;
        [self initData];
    }];
    
    self.favoriteTableView.mj_footer.automaticallyHidden = YES;

    
    [self.mainScroll addSubview:self.favoriteTableView];

    // ------创建记录TableView
    self.recordTableView                  = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 64 - 49)];
    self.recordTableView.delegate         = self;
    self.recordTableView.dataSource       = self;
    self.recordTableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    [self.recordTableView registerNib:[UINib nibWithNibName:@"ZLBookMarkCell" bundle:nil] forCellReuseIdentifier:@"record"];
    [self.mainScroll addSubview:self.recordTableView];
}

#pragma mark - **************** 加载数据
- (void)initData{
    
    [self initFavoriteData];
    [self initRecordData];
}

#pragma mark - **************** 第二次刷新数据
- (void)initDataOnceMore{
    self.page = 1;
    [self.favoriteTableView.mj_header beginRefreshing];
    [self initFavoriteData];
    [self initRecordData];
}

#pragma mark - **************** 加载收藏数据
- (void)initFavoriteData{
    //加载收藏记录 (NET)
    if (![[ZLGlobal sharedInstence]isLogin]) {
        return;
    }
    [[ZLNetworkManager sharedInstence]getFavoriteThreadWithPage:[NSString stringWithFormat:@"%ld",self.page] block:^(NSDictionary *dict) {
        
        NSArray *array = dict[@"list"];
        [self endRefreshWithTableView:self.favoriteTableView nomoreDataFlag:(array.count != 20)];
        
        if (self.page == 1) {
            [self.favoriteArray removeAllObjects];
        }
        
        for (NSDictionary *modelDic in array) {
            ZLFavuriteModel *model = [ZLFavuriteModel mj_objectWithKeyValues:modelDic];
            [self.favoriteArray addObject:model];
        }
        [self.favoriteTableView reloadData];
    } failure:^(NSError *error) {
        [self endRefreshWithTableView:self.favoriteTableView nomoreDataFlag:NO];
        self.page --;
        //容错
        if (self.page <= 0) {
            self.page = 1;
        }
    }];
}

#pragma mark - **************** 加载历史记录
- (void)initRecordData{
    //加载历史记录 (解归档 -- 收藏记录只保存最近30条 多余记录自动删除)
    self.recordArray = [[ZLGlobal sharedInstence]readArchive];
    [self.recordTableView reloadData];
}

#pragma mark - **************** 停止MJ刷新
- (void)endRefreshWithTableView:(UITableView *)tableView nomoreDataFlag:(BOOL)flag{
    if (flag) {
        [tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        if ([tableView.mj_header isRefreshing]) {
            [tableView.mj_header endRefreshing];
        }
        if ([tableView.mj_footer isRefreshing]) {
            [tableView.mj_footer endRefreshing];
        }
    }
}

#pragma mark - **************** 创建segment
- (void)creatNavigationBar{
    UISegmentedControl *control  = [[UISegmentedControl alloc]initWithItems:@[@"收藏",@"记录"]];
    control.width                = 200;
    control.tintColor            = [UIColor whiteColor];
    control.selectedSegmentIndex = 0;
    control.center               = self.navigationItem.titleView.center;

    [control addBlockForControlEvents:UIControlEventValueChanged block:^(id sender) {
        [UIView animateWithDuration:0.5 animations:^{
            self.mainScroll.contentOffset = CGPointMake(control.selectedSegmentIndex * ScreenWidth, 0);
        }];
    }];
    self.segmentControl = control;
    self.navigationItem.titleView = control;
}

#pragma mark - **************** TableViewDelegate & DataSouruce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.favoriteTableView) {
        return self.favoriteArray.count;
    }
    return self.recordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.favoriteTableView) {
        ZLFavuriteModel *model = self.favoriteArray[indexPath.row];
        ZLBookMarkCell *cell   = [tableView dequeueReusableCellWithIdentifier:@"favorite" forIndexPath:indexPath];
        [cell updateFavoriteWith:model];
        return cell;
    }else{
        ZLPostsModel *model  = self.recordArray[indexPath.row];
        ZLBookMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"record" forIndexPath:indexPath];
        cell.replies.text    = [self.plateDic objectForKey:model.currentType];
        [cell updateRecordWith:model];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *heightStr;
    if (tableView == self.recordTableView) {
        ZLPostsModel *model    = self.recordArray[indexPath.row];
        heightStr              = model.subject;
    }else{
        ZLFavuriteModel *model = self.favoriteArray[indexPath.row];
        heightStr              = model.title;
    }
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15]};
    CGSize size             = [heightStr boundingRectWithSize:CGSizeMake(ScreenWidth-20, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;

    return size.height +44 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *tidStr;
    NSString *type;
    if (tableView == self.recordTableView) {
        ZLPostsModel *model         = self.recordArray[indexPath.row];
        tidStr                      = model.tid;
        type                        = model.currentType;
    }else{
        ZLFavuriteModel *model      = self.favoriteArray[indexPath.row];
        tidStr                      = model.id;
    }
    ZLPostsDetailVC *vc         = [[ZLPostsDetailVC alloc]init];
    vc.tid                      = tidStr;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - **************** ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // ------排除tableview乱入
    if (scrollView != self.mainScroll) {
        return;
    }
    CGPoint offset = scrollView.contentOffset;
    self.segmentControl.selectedSegmentIndex = offset.x / self.view.frame.size.width;
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
