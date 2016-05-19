//
//  ZLBookMarkViewController.m
//  ZLDisucssBar
//
//  Created by 赵新 on 16/4/28.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLBookMarkViewController.h"

@interface ZLBookMarkViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong) UIScrollView *mainScroll;

@property (nonatomic ,strong) UITableView  *favoriteTableView;

@property (nonatomic ,strong) UITableView  *recordTableView;

@property (nonatomic ,strong) NSMutableArray *favoriteArray;

@property (nonatomic ,strong) NSMutableArray *recordArray;

@property (nonatomic ,strong) UISegmentedControl *segmentControl;

@end

@implementation ZLBookMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatConstomUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self creatNavigationBar];
}

- (void)creatConstomUI{
    // ------创建Scroll
    self.mainScroll                   = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.mainScroll.pagingEnabled     = YES;
    self.mainScroll.scrollEnabled = YES;
    self.mainScroll.delegate = self;
    self.mainScroll.contentSize       = CGSizeMake(ScreenWidth * 2, ScreenHeight - 64 - 49);
    [self.view addSubview:self.mainScroll];

    // ------创建收藏TableView
    self.favoriteTableView            = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.favoriteTableView.delegate   = self;
    self.favoriteTableView.dataSource = self;
    [self.favoriteTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"favorite"];
    [self.mainScroll addSubview:self.favoriteTableView];

    // ------创建记录TableView
    self.recordTableView              = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight)];
    self.recordTableView.delegate     = self;
    self.recordTableView.dataSource   = self;
    [self.recordTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"record"];
    [self.mainScroll addSubview:self.recordTableView];
}

- (void)creatNavigationBar{
    UISegmentedControl *control   = [[UISegmentedControl alloc]initWithItems:@[@"收藏",@"记录"]];
    control.width                 = 200;
    control.tintColor             = [UIColor whiteColor];

    [control addBlockForControlEvents:UIControlEventValueChanged block:^(id sender) {
        self.mainScroll.contentOffset = CGPointMake(control.selectedSegmentIndex * ScreenWidth, 0);
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
        return 10;
        return self.favoriteArray.count;
    }
    return 10;
    return self.recordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.favoriteTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favorite" forIndexPath:indexPath];
        cell.textLabel.text = @"1";
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"record" forIndexPath:indexPath];
        cell.textLabel.text = @"2";
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"%lf",offset.x);
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
