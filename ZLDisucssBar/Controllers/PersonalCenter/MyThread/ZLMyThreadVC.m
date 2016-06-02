//
//  ZLMyThreadVC.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/25.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLMyThreadVC.h"
#import "ZLMyThreadModel.h"
#import "ZLBookMarkCell.h"
#import "ZLPostsDetailVC.h"

@interface ZLMyThreadVC ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong) UITableView    *myThreadTableView;

@property (nonatomic ,strong) NSMutableArray *dataArray;

@property (nonatomic ,assign) NSInteger      page;

@end

@implementation ZLMyThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperty];
    [self initData];
    [self initCostomUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - **************** 初始化参数
- (void)initProperty{
    self.dataArray = [NSMutableArray array];
    self.page      = 1;
}

#pragma mark - **************** 初始化数据
- (void)initData{
    
    [self.view showLoadingWithStatus:@"加载中"];
    NSString *dataPage = [NSString stringWithFormat:@"%ld",self.page];
    [[ZLNetworkManager sharedInstence]generalAccessWith:@"mythread" page:dataPage block:^(NSDictionary *dict) {
        [self.view dismissLoading];
        NSArray *array = dict[@"data"];
        NSString *returnPage = dict[@"perpage"];
        if (array.count < [returnPage intValue]) {
            self.page--;
            [self.myThreadTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.myThreadTableView.mj_footer endRefreshing];
        }
        for (NSDictionary *item in array) {
            ZLMyThreadModel *model = [ZLMyThreadModel mj_objectWithKeyValues:item];
            [self.dataArray addObject:model];
        }
        [self.myThreadTableView reloadData];
    } failure:^(NSError *error) {
        //请求失败
         [self.myThreadTableView.mj_footer endRefreshing];
        [self.view dismissLoading];
    }];
}

#pragma mark - **************** 初始化UI
- (void)initCostomUI{
    self.myThreadTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    [self.myThreadTableView setDataSource:self];
    [self.myThreadTableView setDelegate:self];
    [self.myThreadTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.myThreadTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self initData];
    }];
    [self.myThreadTableView registerNib:[UINib nibWithNibName:@"ZLBookMarkCell" bundle:nil] forCellReuseIdentifier:@"mythreadCell"];
    self.myThreadTableView.mj_footer.automaticallyHidden = YES;
    [self.view addSubview:self.myThreadTableView];
}

#pragma mark - **************** TableViewDelegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLBookMarkCell *cell   = [tableView dequeueReusableCellWithIdentifier:@"mythreadCell" forIndexPath:indexPath];
    ZLMyThreadModel *model = self.dataArray[indexPath.row];
    [cell.replies setHidden:YES];
    [cell updateMythreadWith:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLMyThreadModel *model  = self.dataArray[indexPath.row];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15]};
    CGSize size             = [model.subject boundingRectWithSize:CGSizeMake(ScreenWidth-20, CGFLOAT_MAX)
                                                          options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                       attributes:attribute
                                                          context:nil].size;
    
    return size.height +44 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLMyThreadModel *model = self.dataArray[indexPath.row];
    ZLPostsDetailVC *vc    = [[ZLPostsDetailVC alloc]init];
    vc.tid                 = model.tid;
    vc.tidType             = model.fid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
