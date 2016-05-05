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


@interface ZLHomePageViewController ()<UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,strong) UITableView    *mainTableView;
@property (nonatomic ,assign) NSInteger      page;
@property (nonatomic ,assign) HPGetInfoType  type;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) NSMutableSet   *dataSet;


@end

@implementation ZLHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        if (self.type == HPGetInfoTypeRefresh) {
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
        [self.mainTableView reloadData];
    } failure:^(NSError *error) {
        [self endingRefreshing];
    }];
}


#pragma mark - **************** Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLCostomPostsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
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
