//
//  ZLMainLoginViewController.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLMainLoginViewController.h"
#import "CostomPickerView.h"
#import "ZLCheckSecurityCodeVc.h"

@interface ZLMainLoginViewController ()<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (nonatomic ,strong) CostomPickerView *pickerView;
@property (nonatomic ,strong) NSDictionary     *safetyDict;
@property (nonatomic ,strong) NSArray          *safeArr;
@property (nonatomic ,assign) BOOL             canPush;

@end

@implementation ZLMainLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self checkAutoInfo];
    [self creatCostomView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)initData{
    self.safetyDict = @{@"安全问题(未设置请忽略)":@"0",
                        @"母亲的名字":@"1",
                        @"爷爷的名字":@"2",
                        @"父亲的手机号码":@"3",
                        @"您其中一位老师的名字":@"4",
                        @"您个人计算机的型号":@"5",
                        @"您最喜欢的餐馆名称":@"6",
                        @"驾驶执照最后四位数字":@"7"};
    
    self.safeArr    = @[@"安全问题(未设置请忽略)",
                        @"母亲的名字",
                        @"爷爷的名字",
                        @"父亲的手机号码",
                        @"您其中一位老师的名字",
                        @"您个人计算机的型号",
                        @"您最喜欢的餐馆名称",
                        @"驾驶执照最后四位数字"];
}

- (void)checkAutoInfo{
    //先判断是否需要自动填写 再判断沙盒中是否有登陆信息
    #warning 待修改
    if (![[ZLGlobal sharedInstence]autoFill]) {
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults]valueForKey:@"loginInfo"];
        if (dict) {
            self.userIDTextField.text   = dict[@"a"];
            self.passwordTextField.text = dict[@"b"];
            NSString *question          = dict[@"c"];
            NSString *answer            = dict[@"d"];
            
            if (question.length > 0 && answer.length > 0) {
            self.safetyLabel.text           = [self.safetyDict allKeysForObject:question][0];
            self.safetyAnswerTextField.text = dict[@"d"];
            }
        }
    }
}

- (void)creatCostomView{
    __weak typeof(self)weakSelf             = self;

    self.safetyLabel.userInteractionEnabled = YES;
    self.loginButton.layer.cornerRadius     = 5;
    self.loginButton.clipsToBounds          = YES;
    self.backHomePage.layer.cornerRadius    = 5;
    self.backHomePage.clipsToBounds         = YES;
    self.userIDTextField.delegate           = self;
    self.passwordTextField.delegate         = self;
    self.safetyAnswerTextField.delegate     = self;

    self.pickerView                         = [[CostomPickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 235)];
    self.pickerView.pickerView.dataSource   = self;
    self.pickerView.pickerView.delegate     = self;
    
    [[self.pickerView.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSInteger row = [weakSelf.pickerView.pickerView selectedRowInComponent:0];
        if (row == 0) {
            self.safetyLabel.text = @"安全提问(未设置请忽略)";
        }else{
            self.safetyLabel.text = self.safeArr[row];
        }
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.pickerView.top = ScreenHeight;
        }];
        
    }];
    [[self.pickerView.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.pickerView.top = ScreenHeight;
        }];
    }];
    [self.view addSubview:self.pickerView];
}

#pragma mark - **************** 展开安全问题
- (IBAction)spreadProblem:(id)sender {
    [self.view endEditing:YES];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.pickerView.top = ScreenHeight - weakSelf.pickerView.height;
    }];
}

#pragma mark - **************** 登陆
- (IBAction)loginNow:(id)sender {
    
//    UIStoryboard *sb                     = [UIStoryboard storyboardWithName:@"ZLLogin" bundle:[NSBundle mainBundle]];
//    ZLCheckSecurityCodeVc *vc            = [sb instantiateViewControllerWithIdentifier:@"CheckSecurity"];
//    [ZLUserInfo sharedInstence].userID   = self.userIDTextField.text;
//    [ZLUserInfo sharedInstence].password = self.passwordTextField.text;
//    
//    if (![self.safetyLabel.text isEqualToString:@"安全提问(未设置请忽略)"]) {
//        // ------有安全问题
//        [ZLUserInfo sharedInstence].safetyQuestion = [self.safetyDict valueForKey:self.safetyLabel.text];
//        [ZLUserInfo sharedInstence].safetyAnswer   = self.safetyAnswerTextField.text;
//    }else{
//        // ------无安全问题
//        [ZLUserInfo sharedInstence].safetyQuestion = @"";
//        [ZLUserInfo sharedInstence].safetyAnswer   = @"";
    }
    
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - **************** 返回首页
- (IBAction)backHomepageOnClick:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        //发送通知 刷新数据 更新Cookies & formHash
    }];
}

#pragma mark - **************** PickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerViewP{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 8;
}

#pragma mark - **************** PickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.safeArr[row];
}

#pragma mark - **************** TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.pickerView.top < ScreenHeight) {
        self.pickerView.top = ScreenHeight;
    }
}

#pragma mark - **************** touchScreen
- (IBAction)touchOnScreen:(id)sender {
    [self.view endEditing:YES];
    if (self.pickerView.top < ScreenHeight) {
        [UIView animateWithDuration:0.5 animations:^{
            self.pickerView.top = ScreenHeight;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
