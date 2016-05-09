//
//  ZLPostsDetailVC.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/6.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPostsDetailVC.h"
#import "ZLPostDetailCellNormal.h"
#import "ZLPostDetailCellReply.h"
#import "ZLPostDetailModel.h"
#import "ZLScrollImageVC.h"

@interface ZLPostsDetailVC ()<UITableViewDelegate, UITableViewDataSource, ZLPostDetailCellNormalDelegate>

/** TableView*/
@property (nonatomic ,strong) UITableView    *mainTableView;

/** 数据源*/
@property (nonatomic ,strong) NSMutableArray *dataArray;

/** 防重复集*/
@property (nonatomic ,strong) NSMutableSet   *dataSet;

/** 页码*/
@property (nonatomic ,assign) NSInteger      page;

@end

@implementation ZLPostsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    self.dataSet   = [NSMutableSet set];
    self.page      = 1;
    
    
    [self initData];
    [self creatConstomUI];
    [self creatToolBar];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)initData{
    [[ZLNetworkManager sharedInstence]getDetailInfoWithPage:self.page tid:self.tid block:^(NSDictionary *dict) {
        NSArray *arr = dict[@"postlist"];
        if (arr.count == 0) {
            self.page --;
        }
        for (NSDictionary *dict in arr) {
            ZLPostDetailModel *model = [ZLPostDetailModel mj_objectWithKeyValues:dict];
            NSInteger num1 = self.dataSet.count;
            [self.dataSet addObject:model.pid];
            if (self.dataSet.count != num1) {
                [self.dataArray addObject:model];
            }
        }
        [self endingRefreshing];
        [self.mainTableView reloadData];
        
    } failure:^(NSError *error) {
        [self endingRefreshing];
    }];
}

#pragma mark - **************** 停止刷新
- (void)endingRefreshing{
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
}

- (void)creatConstomUI{
    self.mainTableView            = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 94)];
    self.mainTableView.delegate   = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ZLPostDetailCellNormal" bundle:nil] forCellReuseIdentifier:@"cellNormal"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ZLPostDetailCellReply" bundle:nil] forCellReuseIdentifier:@"cellReply"];

    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self initData];
    }];
    [self.view addSubview:self.mainTableView];
}

- (void)creatToolBar{
    //底部回复条;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLPostDetailModel *model = self.dataArray[indexPath.row];
    if (![model.message isReplyPosts]) {
        //非回复贴
        ZLPostDetailCellNormal *cell = [tableView dequeueReusableCellWithIdentifier:@"cellNormal" forIndexPath:indexPath];
        cell.delegate = self;
        [cell updateInfoWithDic:model];
        return cell;
    }else{
        //回复贴
        ZLPostDetailCellReply *cell  = [tableView dequeueReusableCellWithIdentifier:@"cellReply" forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLPostDetailModel *model = self.dataArray[indexPath.row];
    NSDictionary *attribute  = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15]};
    CGSize size              = [model.message boundingRectWithSize:CGSizeMake(ScreenWidth-20, CGFLOAT_MAX)
                                                           options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                        attributes:attribute
                                                           context:nil].size;
    NSArray *imgArr          = [model.attachments allValues];
    //不加载图片 或者无图片 返回净值
    if ([[ZLGlobal sharedInstence] downLoadImage] || model.attachments.count == 0) {
        return size.height + 70;
    }else{
        return size.height + 70 + ((ScreenWidth - 40)/3 + 10) * ((imgArr.count % 3 == 0) ? (imgArr.count / 3) : (imgArr.count / 3) + 1);
    }
}

- (void)showImageWith:(UIImage *)img{
    ZLScrollImageVC *vc = [[ZLScrollImageVC alloc]init];
    vc.constomImage = img;
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end