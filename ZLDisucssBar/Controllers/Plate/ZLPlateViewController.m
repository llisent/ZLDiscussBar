//
//  ZLPlateViewController.m
//  ZLDisucssBar
//
//  Created by 赵新 on 16/4/28.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPlateViewController.h"
#import "ZLPlateCollectionCell.h"
#import "ZLHomePageViewController.h"
#import "ZLPlateCell.h"

@interface ZLPlateViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic ,strong) UICollectionView *plateCollectionView;

@property (nonatomic ,strong) NSArray *pidArray;

@property (nonatomic ,strong) NSArray *nameArray;

@end

@implementation ZLPlateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"全部板块";
    self.pidArray = @[@"15",
                      @"11",
                      @"13",
                      @"14",
                      @"19",
                      @"20",
                      @"22",
                      @"24",
                      @"25",
                      @"26",
                      @"27",
                      @"29",
                      @"30",
                      @"31",
                      @"2"];

    self.nameArray = @[@"赚客大家谈",
                       @"做任务赚果果",
                       @"有奖活动",
                       @"有奖调查",
                       @"活动线报",
                       @"赚品显摆",
                       @"获奖名单",
                       @"微博活动",
                       @"赚品交换",
                       @"求助咨询"
                       ,@"活动秘籍",
                       @"区域活动",
                       @"抢楼秒杀",
                       @"果果换物",
                       @"免费赠品"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatConstomUI];
}

- (void)creatConstomUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize                    = CGSizeMake((ScreenWidth- 2) / 3, (ScreenWidth - 2) / 3);
    flowLayout.itemSize                    = CGSizeMake((ScreenWidth - 15)/2, 45);
    flowLayout.minimumLineSpacing          = 5;
    flowLayout.minimumInteritemSpacing     = 5;
    flowLayout.sectionInset                = UIEdgeInsetsMake(5, 5, 0, 5);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.plateCollectionView            = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) collectionViewLayout:flowLayout];
    self.plateCollectionView.dataSource = self;
    self.plateCollectionView.delegate   = self;
    [self.plateCollectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.plateCollectionView registerNib:[UINib nibWithNibName:@"ZLPlateCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
    [self.view addSubview:self.plateCollectionView];
}

#pragma mark - **************** CollectionDelegate & DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.nameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZLPlateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.title.text = self.nameArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZLHomePageViewController *vc = [[ZLHomePageViewController alloc]init];
    vc.title                     = self.nameArray[indexPath.row];
    vc.plateFid                  = self.pidArray[indexPath.row];
    vc.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
