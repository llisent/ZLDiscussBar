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
#import "ZLPurchaseModel.h"

@interface ZLPostsDetailVC ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, TYAttributedLabelDelegate, UIAlertViewDelegate>

/** TableView*/
@property (nonatomic ,strong) UITableView     *mainTableView;

/** 数据源*/
@property (nonatomic ,strong) NSMutableArray  *dataArray;

/** 防重复集*/
@property (nonatomic ,strong) NSMutableSet    *dataSet;

/** 页码*/
@property (nonatomic ,assign) NSInteger       page;

/** 帖子数据*/
@property (nonatomic ,strong) NSMutableArray  *textArray;

/** 作者帖子编码*/
@property (nonatomic ,strong) NSString        *authorPid;

/** 出售信息*/
@property (nonatomic ,strong) ZLPurchaseModel *sellModel;

@end

@implementation ZLPostsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initProperty];        // ------数据初始化
    [self initData];            // ------加载帖子数据
    [self creatConstomUI];      // ------创建UI
    [self creatToolBar];        // ------创建工具按钮
    [self creatNaviToolBar];    // ------创建回帖工具
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self creatRate];
}

#pragma mark - **************** 初始化
- (void)initProperty{
    self.page      = 1;
    self.dataSet   = [NSMutableSet set];
    self.dataArray = [NSMutableArray array];
    self.textArray = [NSMutableArray array];
}

#pragma mark - **************** 创建工具按钮
- (void)creatRate{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_xiala"] style:UIBarButtonItemStylePlain target:self action:@selector(naviToolBarOnClick)];
    
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - **************** 展开/隐藏工具栏(tag = 11111)
- (void)naviToolBarOnClick{
    
    UIView *views = [self.view viewWithTag:11111];
    [UIView animateWithDuration:0.3 animations:^{
        if (views.top == 0) {
            [self.tidType isEqual:@"31"] ? (views.top = - 137) : (views.top = -91);
        }else{
            views.top = 0;
        }
    }];
}

#pragma mark - **************** 创建工具UI
- (void)creatNaviToolBar{
    //创建工具视图
    UIView *costomView         = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth - 130, -91, 130, 91)];
    costomView.tag             = 11111;
    costomView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.550];

    //网页打开帖子
    UIButton *useWeb           = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 130, 45)];
    useWeb.titleLabel.font     = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    [useWeb setTitle:@"网页打开" forState:UIControlStateNormal];
    
    [useWeb addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        //网页打开帖子
        [self naviToolBarOnClick];
        NSString *urlStr = [NSString stringWithFormat:@"http://www.zuanke8.com/thread-%@-1-1.html",self.tid];
        
        SVWebViewController *web = [[SVWebViewController alloc]initWithAddress:urlStr];
        [self.navigationController pushViewController:web animated:YES];
    }];
    
    //分割线
    UIView *line1              = [[UIView alloc]initWithFrame:CGRectMake(10, 45, 110, 1)];
    line1.backgroundColor      = [UIColor colorWithWhite:1.000 alpha:0.900];

    //给帖子评分
    UIButton *rate             = [[UIButton alloc]initWithFrame:CGRectMake(0, 46, 130, 45)];
    rate.titleLabel.font       = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    [rate setTitle:@"评分" forState:UIControlStateNormal];
    
    [rate addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        //给帖子评分
        [self naviToolBarOnClick];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"确定给该贴作者一个积分的评分?"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:@"取消", nil];
        [alert show];
    }];
    
    //果果换物
    if ([self.tidType isEqual: @"31"]) {
        //分割线
        UIView *line2         = [[UIView alloc]initWithFrame:CGRectMake(10, 91, 110, 1)];
        line2.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.900];
        [costomView addSubview:line2];
        
        //购买
        UIButton *buyit             = [[UIButton alloc]initWithFrame:CGRectMake(0, 92, 130, 45)];
        buyit.titleLabel.font       = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        [buyit setTitle:@"购买" forState:UIControlStateNormal];
        
        [buyit addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
            //立即购买
            [self naviToolBarOnClick];
            if (self.sellModel) {
                NSString *message  = [NSString stringWithFormat:@"售价:%@果果 确认购买?",self.sellModel.price];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:([self.sellModel.sellType isEqualToString:@"3"] ? @"担保交易" : @"自动发货")
                                                               message:message
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:@"取消", nil];
                [alert show];
            }
        }];
        [costomView addSubview:buyit];
        
        //更新视图大小
        costomView.height = 137;
        costomView.top    = -137;
    }
    
    [costomView addSubview:useWeb];
    [costomView addSubview:rate];
    [costomView addSubview:line1];
    [self.view addSubview:costomView];

}

#pragma mark - **************** 立即购买
- (void)purchaseNow{
    if (!self.tid || !self.sellModel.sellType) {
        return;
    }
    [[ZLNetworkManager sharedInstence]userPurchaseWithUid:self.tid type:self.sellModel.sellType block:^(NSString *str) {
        NSLog(@"%@",str);
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - **************** 给作者评分
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

#pragma mark - **************** 初始化数据
- (void)initData{
    [[ZLNetworkManager sharedInstence]getDetailInfoWithPage:self.page tid:self.tid block:^(NSDictionary *dict) {
        
        [ZLGlobal sharedInstence].gachincoFormHash = dict[@"formhash"];
        
        if ([self.tidType isEqualToString:@"31"]) {
            
            NSDictionary *dictionary = dict[@"thread"];
            NSString *str1           = dictionary[@"ejew_auction1"];
            NSString *str2           = dictionary[@"ejew_auction3"];
            
            if (str1.length > 10) {
                self.sellModel          = [str1 checkOutPurchaseInfo];
                self.sellModel.sellType = @"1"; //自动发货
            }else{
                self.sellModel          = [str2 checkOutPurchaseInfo];
                self.sellModel.sellType = @"3"; //担保交易
            }
        }
        
        NSArray *arr = dict[@"postlist"];
        
        if (!self.authorPid) {
            NSDictionary *dic = arr.firstObject;
            self.authorPid    = dic[@"pid"];
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

#pragma mark - **************** 创建UI
- (void)creatConstomUI{
    self.view.backgroundColor          = [UIColor whiteColor];
    self.mainTableView                 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50)];
    self.mainTableView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    self.mainTableView.delegate        = self;
    self.mainTableView.dataSource      = self;
    self.mainTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;

    [self.mainTableView registerNib:[UINib nibWithNibName:@"ZLPostDetailCellView" bundle:nil] forCellReuseIdentifier:@"detailCell"];

    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self initData];
    }];
    
    self.mainTableView.mj_footer.automaticallyHidden = YES;
    [self.view addSubview:self.mainTableView];
}

#pragma mark - **************** 创建底部回复区
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

#pragma mark - **************** TableViewDelegate & DataSouce
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    /**
     *  返回cell的高度
     *  1.净值1 = 80 上20 + 图 40 + 底默认10 + 图底默认10
     *  2.考虑是否为回复贴（如果是返回值为两个）
     *  3.考虑图片高度
     */

    NSDictionary *dict       = self.textArray[indexPath.row];
    ZLPostDetailModel *model = self.dataArray[indexPath.row];
    NSArray *imgArr          = [NSArray array];

    TYTextContainer *text1   = dict[@"a"];
    TYTextContainer *text2   = dict[@"b"];
    
    if ([[ZLGlobal sharedInstence]downLoadImage]) {
        imgArr = @[];
    }else{
        imgArr = model.attachments.allValues;
    }
    
    CGFloat height = 0.0f;
    height += [text1 getHeightWithFramesetter:nil width:ScreenWidth - 40];
    if (text2) {
        height += [text2 getHeightWithFramesetter:nil width:ScreenWidth - 40] + 10;
    }
    if (imgArr.count != 0) {
        if (imgArr.count % 3 == 0) {
            //整行
            height += ((ScreenWidth - 60)/3 + 10) * (imgArr.count / 3);
            
        }else{
            //多出一行
            height += ((ScreenWidth - 60)/3 + 10) * (imgArr.count / 3 + 1);
        }
    }
    return height + 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLPostDetailModel *model = self.dataArray[indexPath.row];
//    IQTextView *textView     = [self.view viewWithTag:1111];
//    textView.placeholder     = [NSString stringWithFormat:@"回复%@",model.author];
//    [textView becomeFirstResponder];
    
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
    cell.replyLabel.textContainer   = containerReply;
    
    
    if (model.isReply) {
        // ------建立容器
        TYTextContainer *containerQuote = dict[@"b"];
        cell.quoteLabel.textContainer   = containerQuote;
        [cell.quoteLabel sizeToFit];
        
    }
    
    [cell.replyLabel sizeToFit];
    
    if (cell.imgArr.count != 0) {
        // ------有图片需要显示 加载图片(待加载代理)
        for (int i = 0; i < [cell.imgArr count]; i++) {
            NSDictionary *dic      = cell.imgArr[i];
            NSString *url          = [NSString stringWithFormat:@"http://img.zuanke8.com/forum/%@",dic[@"attachment"]];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(((ScreenWidth - 60)/3 + 10) * (i%3),
                                                                                  (i/3) * ((ScreenWidth - 60)/3 + 10),
                                                                                  (ScreenWidth-60)/3,
                                                                                  (ScreenWidth-60)/3)];
            imageView.userInteractionEnabled = YES;
            [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
            [cell.imageBedView addSubview:imageView];
            
#warning 待修改    Error Domain=NSURLErrorDomain Code=404 "(null)" 控制图片404时状态

            SDWebImageDownloader *dl = [SDWebImageDownloader sharedDownloader];
            [dl downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                
                imageView.image             = image;
                UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                ZLScrollImageVC *vc         = [[ZLScrollImageVC alloc]init];
                vc.constomImage             = image;
                vc.modalTransitionStyle     = UIModalTransitionStyleCrossDissolve;
                    [self.navigationController presentViewController:vc animated:YES completion:^{

                    }];
                }];
                [imageView addGestureRecognizer:ges];
            }];
        }
        //高度
        CGFloat  a = ((ScreenWidth - 60)/3) * ((cell.imgArr.count % 3 == 0) ? (cell.imgArr.count / 3) : (cell.imgArr.count / 3) + 1);
        [cell.imageBedView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(a);
            
        }];
    }
    [cell updateConstraints];
    [cell layoutIfNeeded];
}

#pragma mark - **************** TYAttributedLabel代理(点击网址跳转)
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

#pragma mark - **************** TextViewDelegate (自动展开行)
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

#pragma mark - **************** 展示图片
- (void)showImageWith:(UIImage *)img{
    ZLScrollImageVC *vc = [[ZLScrollImageVC alloc]init];
    vc.constomImage = img;
    self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

#pragma mark - **************** 回帖
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

#pragma mark - **************** AlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if ([alertView.title isEqualToString:@"提示"]) {
            [self rateAuthor];
        }else{
            [self purchaseNow];
        }
    }
}

#pragma mark - **************** SCROLLVIEW DELEGATE
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    UIView *views = [self.view viewWithTag:11111];
    if (views.top == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.tidType isEqual:@"31"] ? (views.top = - 137) : (views.top = -91);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
