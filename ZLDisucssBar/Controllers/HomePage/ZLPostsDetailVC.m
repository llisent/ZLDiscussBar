//
//  ZLPostsDetailVC.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/6.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPostsDetailVC.h"
#import "ZLPostDetailModel.h"
#import "ZLScrollImageVC.h"
#import "ZLPostDetailCellView.h"

@interface ZLPostsDetailVC ()<UITableViewDelegate, UITableViewDataSource>

/** TableView*/
@property (nonatomic ,strong) UITableView    *mainTableView;

/** 数据源*/
@property (nonatomic ,strong) NSMutableArray *dataArray;

/** 防重复集*/
@property (nonatomic ,strong) NSMutableSet   *dataSet;

/** 页码*/
@property (nonatomic ,assign) NSInteger      page;


@property (nonatomic ,strong) NSMutableArray *textArray;

@end

@implementation ZLPostsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    self.dataSet   = [NSMutableSet set];
    self.textArray = [NSMutableArray array];
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
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.tid = @"3070779";
    });
    
    [[ZLNetworkManager sharedInstence]getDetailInfoWithPage:self.page tid:self.tid block:^(NSDictionary *dict) {
        NSArray *arr = dict[@"postlist"];
        if (self.dataArray.count !=0 && arr.count!= 10) {
            self.page--;
        }
        
        for (NSDictionary *dictx in arr) {
            ZLPostDetailModel *model = [ZLPostDetailModel mj_objectWithKeyValues:dictx];
            if (!model.message) {
                continue;
            }

            NSInteger num1 = self.dataSet.count;
            [self.dataSet addObject:model.pid];
            
            if (self.dataSet.count != num1) {
                [model detectionModel];
                if (model.container2) {
                    NSDictionary *co = @{@"a":model.container1,@"b":model.container2};
                    [self.textArray addObject:co];

                }else{
                    NSDictionary *co = @{@"a":model.container1};
                    [self.textArray addObject:co];

                }
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
    self.mainTableView            = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.mainTableView.delegate   = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.mainTableView registerNib:[UINib nibWithNibName:@"ZLPostDetailCellView" bundle:nil] forCellReuseIdentifier:@"detailCell"];

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
    ZLPostDetailModel *model  = self.dataArray[indexPath.row];
    ZLPostDetailCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [cell updateInfomationWith:model];
    
    [self deepAssignmentWithCell:cell Model:model rowNum:indexPath.row];
    

    
    return cell;
}

- (void)deepAssignmentWithCell:(ZLPostDetailCellView *)cell Model:(ZLPostDetailModel *)model rowNum:(NSUInteger)row{
    
    {
        cell.quoteLabel.textContainer = nil;
        cell.replyLabel.textContainer = nil;
        cell.quoteLabel.delegate = self;
        cell.replyLabel.delegate = self;
        [cell.imageBedView removeAllSubviews];
    }

    // ------
    NSDictionary *dict = self.textArray[row];
    
    
    // ------建立容器
    TYTextContainer *containerReply = dict[@"a"];
    
    //把容器赋回Label
    cell.replyLabel.textContainer = containerReply;
    
    
    if (model.isReply) {
        // ------建立容器
        TYTextContainer *containerQuote = dict[@"b"];

        cell.quoteLabel.textContainer = containerQuote;
        [cell.quoteLabel sizeToFit];
        
    }
    
    [cell.replyLabel sizeToFit];
    
    if (cell.imgArr.count != 0) {
        // ------有图片需要显示 加载图片(待加载代理)
        for (int i = 0; i < [cell.imgArr count]; i++) {
            NSDictionary *dic      = cell.imgArr[i];
            NSString *url          = [NSString stringWithFormat:@"http://img.zuanke8.com/forum/%@",dic[@"attachment"]];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(((ScreenWidth - 40)/3 + 10) * (i%3),
                                                                                  (i/3) * ((ScreenWidth - 40)/3 + 10),
                                                                                  (ScreenWidth-40)/3,
                                                                                  (ScreenWidth-40)/3)];
            imageView.userInteractionEnabled = YES;
            [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
            [cell.imageBedView addSubview:imageView];
            
#warning 待修改    Error Domain=NSURLErrorDomain Code=404 "(null)" 控制图片404时状态

            SDWebImageDownloader *dl = [SDWebImageDownloader sharedDownloader];
            [dl downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                imageView.image             = image;
                UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                    ZLScrollImageVC *vc = [[ZLScrollImageVC alloc]init];
                    vc.constomImage = image;
                    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    [self.navigationController presentViewController:vc animated:YES completion:^{
                        
                    }];
                }];
                [imageView addGestureRecognizer:ges];
            }];
        }
        //高度
        CGFloat  a = ((ScreenWidth - 40)/3 + 10) * ((cell.imgArr.count % 3 == 0) ? (cell.imgArr.count / 3) : (cell.imgArr.count / 3) + 1);
        [cell.imageBedView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(a);
            
        }];
    }
    [cell updateConstraints];
    [cell layoutIfNeeded];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    /**
     *  返回cell的高度
     *  1.净值1 = 60
     *  2.考虑是否为回复贴（如果是返回值为两个）
     *  3.考虑图片高度
     */
    
    NSDictionary *dict       = self.textArray[indexPath.row];
    ZLPostDetailModel *model = self.dataArray[indexPath.row];
    NSArray *imgArr          = [NSArray array];
    
    TYTextContainer *text1     = dict[@"a"];
    TYTextContainer *text2     = dict[@"b"];
    
    if ([[ZLGlobal sharedInstence]downLoadImage]) {
        imgArr = @[];
    }else{
        imgArr = model.attachments.allValues;
    }
    
    CGFloat height = 0.0f;
    height += [text1 getHeightWithFramesetter:nil width:ScreenWidth - 20];
    if (text2) {
        height += [text2 getHeightWithFramesetter:nil width:ScreenWidth - 20] + 10;
    }
    if (imgArr.count != 0) {
        height += ((ScreenWidth - 40)/3 + 10) * ((imgArr.count % 3 == 0) ? (imgArr.count / 3) : (imgArr.count / 3) + 1) + 10;
    }
    return height + 75;

}

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point{
    if ([textStorage isKindOfClass:[TYLinkTextStorage class]]) {

        id linkStr = ((TYLinkTextStorage*)textStorage).linkData;
        
        #warning 还有几种形式 待加入
        NSRange range = [linkStr rangeOfString:@"http://www.zuanke8.com/thread-"];
        
        if (range.length != 0) {
            NSString *url       = [linkStr stringByReplacingOccurrencesOfString:@"http://www.zuanke8.com/thread-" withString:@""];
            NSRange range1      = [url rangeOfString:@"-"];
            NSString *tidStr    = [url substringToIndex:range1.location];
            ZLPostsDetailVC *vc = [[ZLPostsDetailVC alloc]init];
            vc.tid              = tidStr;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else{
        
            if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:linkStr]]){
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:linkStr]];
        
            }
        }
        
        
        
        

    }
}

- (void)showImageWith:(UIImage *)img{
    ZLScrollImageVC *vc = [[ZLScrollImageVC alloc]init];
    vc.constomImage = img;
    self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
