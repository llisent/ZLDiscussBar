//
//  ZLBaseViewController.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/4.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLBaseViewController.h"
#import "ZLCostomPostsCell.h"

@interface ZLBaseViewController ()<UITableViewDelegate ,UITableViewDataSource>

@end

@implementation ZLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatConstomUI];
    self.dataArray = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)creatConstomUI{
    self.view.backgroundColor     = [UIColor whiteColor];
    self.mainTableView            = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49)];
    self.mainTableView.delegate   = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ZLCostomPostsCell" bundle:nil] forCellReuseIdentifier:@"postsCell"];
    self.mainTableView.rowHeight  = 100;
    self.mainTableView.mj_header  = [MJRefreshHeader headerWithRefreshingBlock:^{
        self.page = 1;
//        [self downloadPostsWithtype:PostsRefresh];
    }];
    self.mainTableView.mj_footer  = [MJRefreshFooter footerWithRefreshingBlock:^{
        self.page++;
//        [self downloadPostsWithtype:PostsMore];
    }];
    

    
    [self.view addSubview:self.mainTableView];
}

- (void)endingRefreshing{
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
}

//- (void)downloadPostsWithtype:(RefreshType)type{
//    switch (type) {
//        case PostsMore:
//            self.page++;
//            break;
//        case PostsRefresh:
//            self.page = 1;
//            [self.dataArray removeAllObjects];
//            break;
//        default:
//            break;
//    }
//
//    [[ZLNetworkManager sharedInstence]getInfoWithFid:_fid page:_page block:^(NSDictionary *dict) {
//        NSLog(@"%@",dict);
//        NSArray *arr = dict[@"forum_threadlist"];
//        for (NSDictionary *dic in arr) {
//            ZLPostsModel *model = [ZLPostsModel mj_objectWithKeyValues:dic];
//            [self.dataArray addObject:model];
//        }
//        [self endingRefreshing];
//        [self.mainTableView reloadData];
//    } failure:^(NSError *error) {
//        [self endingRefreshing];
//    }];
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLCostomPostsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postsCell" forIndexPath:indexPath];
    ZLPostsModel *model = self.dataArray[indexPath.row];
    [cell updateInformationWithModel:model];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
