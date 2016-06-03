//
//  ZLPersonalInfoViewController.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/17.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPersonalInfoViewController.h"
#import "ZLPersonalInfoCell.h"

@interface ZLPersonalInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView        *backButton;
@property (weak, nonatomic) IBOutlet UIView             *hiddenView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nametop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jifentop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leveltop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLeftCons;

@property (weak, nonatomic) IBOutlet UILabel            *placeLabel1;

@property (weak, nonatomic) IBOutlet UILabel            *placeLabel2;

@property (weak, nonatomic) IBOutlet UILabel            *placeLabel3;





@end

@implementation ZLPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatCostomUI];
    [self startBreath];
    [self assignment];
}

- (void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:0.4 animations:^{
        self.userIcon.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35 animations:^{
            self.nametop.constant = 52;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.35 animations:^{
                self.jifentop.constant = 79;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.35 animations:^{
                    self.leveltop.constant = 106;
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.35 animations:^{
                        self.nameLeftCons.constant = 100;
                        self.placeLabel1.alpha     = 1;
                        self.placeLabel2.alpha     = 1;
                        self.placeLabel3.alpha     = 1;
                        [self.view layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.35 animations:^{
                            self.infoTableview.alpha = 1;
                        }];
                    }];
                }];
            }];
        }];
    }];
}

- (void)creatCostomUI{
    self.nametop.constant            = -27;
    self.jifentop.constant           = -27;
    self.leveltop.constant           = -27;
    self.userIcon.layer.cornerRadius = self.userIcon.width/2;
    self.userIcon.clipsToBounds      = YES;
    UITapGestureRecognizer *tap      = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [self.hiddenView addGestureRecognizer:tap];
    [self.infoTableview registerNib:[UINib nibWithNibName:@"ZLPersonalInfoCell" bundle:nil] forCellReuseIdentifier:@"infoCell"];
}

- (void)assignment{
    self.userName.text     = self.VariablesDict[@"space"][@"username"];
    self.userIntegral.text = self.VariablesDict[@"space"][@"credits"];
    self.userLevel.text    = self.VariablesDict[@"space"][@"group"][@"grouptitle"];
    NSString *iconUrl      = [NSString stringWithFormat:@"http://uc.zuanke8.com/avatar.php?uid=%@&size=big",
                              self.VariablesDict[@"space"][@"uid"]];
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:iconUrl]];
    
}

//- (void)loadUserInfomation{
//    if (!self.uid) {
//        //个人信息
//        [[ZLNetworkManager sharedInstence]getUserInfoWithBlock:^(NSDictionary *dict) {
//            
//        } failure:^(NSError *error) {
//            
//        }];
//    }else{
//        [[ZLNetworkManager sharedInstence]getUserInfoWithUid:self.uid block:^(NSDictionary *dict) {
//            
//        } failure:^(NSError *error) {
//            
//        }];
//    }
//}

- (void)updateInformationWithDictionary:(NSDictionary *)dic{
    
}

- (void)startBreath{
    [NSTimer scheduledTimerWithTimeInterval:1.5 block:^(NSTimer * _Nonnull timer) {
        [UIView animateWithDuration:0.75 animations:^{
            self.backButton.layer.transformScale = 1.5;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.75 animations:^{
                self.backButton.layer.transformScale = 1;
            }];
        }];
    } repeats:YES];
}

#pragma mark - **************** TableviewDelegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 14;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLPersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    [cell updateInfomationWith:self.VariablesDict rowsNum:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
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
