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

@interface ZLPostsDetailVC ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, TYAttributedLabelDelegate>

/** TableView*/
@property (nonatomic ,strong) UITableView    *mainTableView;

/** 数据源*/
@property (nonatomic ,strong) NSMutableArray *dataArray;

/** 防重复集*/
@property (nonatomic ,strong) NSMutableSet   *dataSet;

/** 页码*/
@property (nonatomic ,assign) NSInteger      page;


@property (nonatomic ,strong) NSMutableArray *textArray;

@property (nonatomic ,strong) NSString       *authorPid;

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
    [self textMe];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self creatRate];
}

- (void)creatRate{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"点击" style:UIBarButtonItemStylePlain target:self action:@selector(hahaha)];
    
    
    
    
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"评分" style:UIBarButtonItemStylePlain target:self action:@selector(rateAuthor)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)hahaha{
    UIView *views = [self.view viewWithTag:11111];
    [UIView animateWithDuration:0.3 animations:^{
        if (views.height == 0) {
            [self.tidType isEqual:@"31"] ? (views.height = 137) : (views.height = 91);
        }else{
            views.height = 0;
        }
    }];
}

- (void)textMe{
    UIView *costomView         = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth - 130, 0, 130, 0)];
    costomView.tag             = 11111;
    costomView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.550];

    UIButton *useWeb           = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 130, 45)];
    [useWeb setTitle:@"网页打开" forState:UIControlStateNormal];
    useWeb.titleLabel.font     = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];

    UIView *line1              = [[UIView alloc]initWithFrame:CGRectMake(10, 45, 110, 1)];
    line1.backgroundColor      = [UIColor colorWithWhite:1.000 alpha:0.900];

    UIButton *rate             = [[UIButton alloc]initWithFrame:CGRectMake(0, 46, 130, 45)];
    [rate setTitle:@"评分" forState:UIControlStateNormal];
    rate.titleLabel.font       = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    
    if ([self.tidType  isEqual: @"31"]) {
        UIView *line2         = [[UIView alloc]initWithFrame:CGRectMake(10, 91, 110, 1)];
        line2.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.900];
        [costomView addSubview:line2];
        
        UIButton *buyit             = [[UIButton alloc]initWithFrame:CGRectMake(0, 92, 130, 45)];
        [buyit setTitle:@"购买" forState:UIControlStateNormal];
        buyit.titleLabel.font       = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        [costomView addSubview:buyit];
    }
    
    [costomView addSubview:useWeb];
    [costomView addSubview:rate];
    [costomView addSubview:line1];
    [self.view addSubview:costomView];

}

- (void)rateAuthor{
    if (!self.authorPid) {
        return;
    }
    [[ZLNetworkManager sharedInstence]rateSomeOneWith:self.tid pid:self.authorPid faceValue:@"1" reason:@"" block:^(NSString *str) {
        NSString *returnStr = [str checkRateResult];
        if ([returnStr isEqualToString:@"评分成功"]) {
            [self.view showSuccessWithStatus:returnStr];
        }else{
            [self.view showErrorWithStatus:returnStr];
        }
    } failure:^(NSError *error) {
        [self.view showErrorWithStatus:@"网络错误"];
    }];
}

- (void)initData{    
//    [self.view showLoadingWithStatus:@"加载中"];

    [[ZLNetworkManager sharedInstence]getDetailInfoWithPage:self.page tid:self.tid block:^(NSDictionary *dict) {
        
        [ZLGlobal sharedInstence].gachincoFormHash = dict[@"formhash"];
        NSArray *arr = dict[@"postlist"];
        
        if (!self.authorPid) {
            NSDictionary *dic = arr.firstObject;
            self.authorPid = dic[@"pid"];
        }
        
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
    self.mainTableView                = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50)];
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.mainTableView registerNib:[UINib nibWithNibName:@"ZLPostDetailCellView" bundle:nil] forCellReuseIdentifier:@"detailCell"];

    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self initData];
    }];
    [self.view addSubview:self.mainTableView];
}

//创建底部回复区
- (void)creatToolBar{
    //底部父View
    UIView *writeView           = [[UIView alloc]init];
    writeView.backgroundColor   = [UIColor colorWithWhite:0.922 alpha:1.000];

    IQTextView *textView        = [[IQTextView alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth - 80, 30)];
    textView.delegate           = self;
    textView.tag                = 1111;
    textView.layer.cornerRadius = 8;
    textView.clipsToBounds      = YES;
    textView.delegate           = self;
    textView.placeholder        = @"回复楼主";
    textView.font               = [UIFont fontWithName:@"HelveticaNeue" size:15];
    textView.textColor          = [UIColor colorWithWhite:0.149 alpha:1.000];
    [writeView addSubview:textView];
    [self.view addSubview:writeView];

    UIButton *send              = [[UIButton alloc]init];
    [send setTitle:@"发送" forState:UIControlStateNormal];
    send.layer.cornerRadius     = 12;
    send.clipsToBounds          = YES;
    send.titleLabel.font        = [UIFont fontWithName:@"HelveticaNeue" size:15];
    [send setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    send.backgroundColor        = [UIColor orangeColor];
    [send addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [self replyPosts];
    }];
    [writeView addSubview:send];
    
    [send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(writeView);
        make.left.mas_equalTo(textView.mas_right).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(@30);
    }];
    
    [writeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(textView.mas_height).offset(20);
    }];
    
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.placeholderFont = [UIFont fontWithName:@"placeholder" size:15];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLPostDetailModel *model   = self.dataArray[indexPath.row];
    ZLPostDetailCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    cell.selectionStyle        = UITableViewCellSelectionStyleNone;
    
    [cell updateInfomationWith:model];
    [self deepAssignmentWithCell:cell Model:model rowNum:indexPath.row];
    return cell;
}

- (void)deepAssignmentWithCell:(ZLPostDetailCellView *)cell Model:(ZLPostDetailModel *)model rowNum:(NSUInteger)row{
    
    {
        cell.quoteLabel.textContainer = nil;
        cell.replyLabel.textContainer = nil;
        cell.quoteLabel.delegate      = self;
        cell.replyLabel.delegate      = self;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLPostDetailModel *model = self.dataArray[indexPath.row];
    IQTextView *textView     = [self.view viewWithTag:1111];
    textView.placeholder     = [NSString stringWithFormat:@"回复%@",model.author];
    [textView becomeFirstResponder];
    
}

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point{
    if ([textStorage isKindOfClass:[TYLinkTextStorage class]]) {

        id linkStr = ((TYLinkTextStorage*)textStorage).linkData;
        
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

- (void)textViewDidChange:(UITextView *)textView {
    CGSize constraintSize;
    constraintSize.width  = textView.frame.size.width;
    constraintSize.height = MAXFLOAT;
    CGSize sizeFrame      = [textView sizeThatFits:constraintSize];
    textView.frame        = CGRectMake(textView.frame.origin.x,
                                       textView.frame.origin.y,
                                       textView.frame.size.width,
                                       sizeFrame.height);
}

- (void)showImageWith:(UIImage *)img{
    ZLScrollImageVC *vc = [[ZLScrollImageVC alloc]init];
    vc.constomImage = img;
    self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)replyPosts{
    IQTextView *textView = [self.view viewWithTag:1111];
    [SVProgressHUD showWithStatus:@"发送中" maskType:SVProgressHUDMaskTypeBlack];
    
    [[ZLNetworkManager sharedInstence]userReplyWithTid:self.tid formHash:[ZLGlobal sharedInstence].gachincoFormHash message:textView.text block:^(NSDictionary *dict) {
        [SVProgressHUD dismiss];
        NSString *mess = dict[@"Message"][@"messageval"];
        if ([mess isEqualToString:@"post_reply_succeed"]) {
            [SVProgressHUD showSuccessWithStatus:@"发布成功"
                                        maskType:SVProgressHUDMaskTypeBlack];
            [self initData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"发布失败"
                                      maskType:SVProgressHUDMaskTypeBlack];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
