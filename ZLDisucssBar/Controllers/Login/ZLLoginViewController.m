//
//  ZLLoginViewController.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/6/3.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLLoginViewController.h"
#import "CostomPickerView.h"


@interface ZLLoginViewController ()<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

/** 验证码Top约束(用于显示问题答案输入)*/
@property (weak, nonatomic  ) IBOutlet NSLayoutConstraint *authCodeTop;

/** 用户名*/
@property (weak, nonatomic  ) IBOutlet UITextField        *userName;

/** 密码*/
@property (weak, nonatomic  ) IBOutlet UITextField        *passWord;

/** 显示问题*/
@property (weak, nonatomic  ) IBOutlet UILabel            *problemLabel;

/** 答案*/
@property (weak, nonatomic  ) IBOutlet UITextField        *answer;

/** 验证码输入框*/
@property (weak, nonatomic  ) IBOutlet UITextField        *authCodeTextField;

/** 验证码图片*/
@property (weak, nonatomic  ) IBOutlet UIImageView        *authCodeImage;

/** 登陆按钮*/
@property (weak, nonatomic  ) IBOutlet UIButton           *submitBtn;

/** 答案输入区*/
@property (weak, nonatomic  ) IBOutlet UIView             *answerView;

/** 安全问题picker*/
@property (nonatomic ,strong) CostomPickerView *pickerView;


/** 数据变量*/
@property (nonatomic ,strong) NSDictionary *safetyDict;
@property (nonatomic ,strong) NSArray      *safeArr;
@property (nonatomic ,strong) NSString     *sechash;


@end

@implementation ZLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAuthImg];      // ------获取验证码
    [self creatCostomView]; // ------创建UI
    [self creatSignal];     // ------创建信号
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - **************** Lazy
- (NSDictionary *)safetyDict{
    if (!_safetyDict) {
        _safetyDict = @{@"安全问题(未设置请忽略)":@"0",
                        @"母亲的名字":@"1",
                        @"爷爷的名字":@"2",
                        @"父亲的手机号码":@"3",
                        @"您其中一位老师的名字":@"4",
                        @"您个人计算机的型号":@"5",
                        @"您最喜欢的餐馆名称":@"6",
                        @"驾驶执照最后四位数字":@"7"};
    }
    return _safetyDict;
}

- (NSArray *)safeArr{
    if (!_safeArr) {
        _safeArr = @[@"安全问题(未设置请忽略)",
                     @"母亲的名字",
                     @"爷爷的名字",
                     @"父亲的手机号码",
                     @"您其中一位老师的名字",
                     @"您个人计算机的型号",
                     @"您最喜欢的餐馆名称",
                     @"驾驶执照最后四位数字"];
    }
    return _safeArr;
}

#pragma mark - **************** 创建UI
- (void)creatCostomView{
    __weak typeof(self)weakSelf           = self;
    
    // ------细节设置
    {
        self.submitBtn.layer.cornerRadius     = 5;
        self.submitBtn.clipsToBounds          = YES;
        self.userName.delegate                = self;
        self.passWord.delegate                = self;
        self.answer.delegate                  = self;
    }
    
    // ------placeHolder字体设置
    {
        [self.userName setValue:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]
                     forKeyPath:@"_placeholderLabel.font"];
        
        [self.answer setValue:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]
                   forKeyPath:@"_placeholderLabel.font"];
        
        [self.passWord setValue:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]
                     forKeyPath:@"_placeholderLabel.font"];
        
        [self.authCodeTextField setValue:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]
                              forKeyPath:@"_placeholderLabel.font"];
    }
    
    // ------pickerview相关
    {
        self.pickerView                       = [[CostomPickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 235)];
        self.pickerView.pickerView.dataSource = self;
        self.pickerView.pickerView.delegate   = self;
        
        [[self.pickerView.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSInteger row = [weakSelf.pickerView.pickerView selectedRowInComponent:0];
            if (row == 0) {
                [UIView animateWithDuration:0.35 animations:^{
                    self.authCodeTop.constant = 8;
                    self.answerView.hidden    = YES;
                    [self.view layoutIfNeeded];
                }];
                self.problemLabel.text = @"安全提问(未设置请忽略)";
            }else{
                [UIView animateWithDuration:0.35 animations:^{
                    self.authCodeTop.constant = 51;
                    self.answerView.hidden    = NO;
                    [self.view layoutIfNeeded];
                }];
                self.problemLabel.text = self.safeArr[row];
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
}

#pragma mark - **************** 创建信号
- (void)creatSignal{
    [self.userName.rac_textSignal subscribeNext:^(id x) {
        [self executeSignal];
    }];
    
    [self.passWord.rac_textSignal subscribeNext:^(id x) {
        [self executeSignal];
    }];
    
    [self.authCodeTextField.rac_textSignal subscribeNext:^(id x) {
        [self executeSignal];
    }];
}

#pragma mark - **************** 信号执行函数
- (void)executeSignal{
    if ([self checkEmpty]) {
        self.submitBtn.backgroundColor = [UIColor whiteColor];
    }else{
        self.submitBtn.backgroundColor = [UIColor colorWithWhite:0.863 alpha:1.000];
    }
}

#pragma mark - **************** 测空
- (BOOL)checkEmpty{
    if (self.userName.text.length > 0 &&
        self.passWord.text.length > 0 &&
        self.authCodeTextField.text.length >0) {
        return YES;
    }
    return NO;
}

#pragma mark - **************** 获取验证码图片
- (void)getAuthImg{
    
    [[ZLNetworkManager sharedInstence]getSeccodeWithblock:^(NSDictionary *dict) {
        
        SDWebImageDownloader *dl = [SDWebImageDownloader sharedDownloader];
        [dl setValue:@"http://www.zuanke8.com/api/mobile/index.php" forHTTPHeaderField:@"Referer"];
        self.sechash = dict[@"sechash"];
        [ZLGlobal sharedInstence].gachincoFormHash = dict[@"formhash"];
        [dl downloadImageWithURL:[NSURL URLWithString:dict[@"seccode"]] options:SDWebImageDownloaderHandleCookies progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.authCodeImage.image = image;
            });
        }];
    } failure:^(NSError *error) {
        [self.view showJGErrorWithStatus:@"获取验证码失败,请点击重试"];
    }];
}

#pragma mark - **************** 显示答案选择view
- (IBAction)showProblem:(id)sender {
    [self.view endEditing:YES];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.pickerView.top = ScreenHeight - weakSelf.pickerView.height;
    }];
}

#pragma mark - **************** 返回
- (IBAction)goBack:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - **************** 更换验证码
- (IBAction)changeAuthImage:(id)sender {
    [self getAuthImg];
}

#pragma mark - **************** 点击登陆
- (IBAction)submitOnClick:(id)sender {
    if (self.userName.text.length != 0 &&
        self.passWord.text.length != 0 &&
        self.authCodeTextField.text.length !=0) {
        if (![self.problemLabel.text isEqualToString:@"安全提问(未设置请忽略)"]) {
            if (self.answer.text.length == 0) {
                [self.view showJGErrorWithStatus:@"还未填写安全问题答案哦"];
            }else{
                [self loginNow];
            }
        }else{
            [self loginNow];
        }
    }else{
        [self.view showJGErrorWithStatus:@"填写完整在登陆吧"];
    }
}

#pragma mark - **************** 登陆
- (void)loginNow{
    // ------存储此次登陆信息
    ZLUserInfo *user        = [ZLUserInfo sharedInstence];
    
    // ------将编码转换(验证码转码)
    NSString *codStr = [self.authCodeTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *pro;
    NSString *ans;
    
    if ([self.problemLabel.text isEqualToString:@"安全提问(未设置请忽略)"]) {
        pro = @"0";
        ans = @"";
    }else{
        pro = [self.safetyDict valueForKey:self.problemLabel.text];
        ans = self.answer.text;
    }
    
    NSString *url = [NSString stringWithFormat:@"http://www.zuanke8.com/api/mobile/index.php?loginsubmit=yes&charset=utf-8&secqaahash=%@&loginfield=auto&seccodehash=%@&seccodeverify=%@&sechash=%@&module=login&mobile=no&version=3",self.sechash,self.sechash,codStr,self.sechash];
    
    [[ZLNetworkManager sharedInstence]userLoginSecondWithUserID:self.userName.text
                                                       password:self.passWord.text
                                                           type:pro
                                                            asw:ans
                                                            url:url
                                                       formhash:[ZLGlobal sharedInstence].gachincoFormHash block:^(NSDictionary *dic) {
                                                           //登陆信息
                                                           NSDictionary *messDic = dic[@"Message"];
                                                           NSString *messageval  = dic[@"Message"][@"messageval"];
                                                           NSLog(@"登陆信息---%@ ---%@",messageval,messDic[@"messagestr"]);
                                                           
                                                           NSRange succRange = [messageval rangeOfString:@"succeed"];
                                                           
                                                           // ------登陆成功
                                                           if (succRange.length != 0) {
                                                               user.userUID    = dic[@"Variables"][@"member_uid"];
                                                               user.username   = dic[@"Variables"][@"member_username"];
                                                               user.readaccess = dic[@"Variables"][@"readaccess"];
                                                               [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isLogin"];
                                                               
                                                               //归档存储用户信息
                                                               NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
                                                               NSString *path    = [docPath stringByAppendingPathComponent:@"user.info"];
                                                               [NSKeyedArchiver archiveRootObject:user toFile:path];
                                                               
                                                               //发送通知
                                                               [[NSNotificationCenter defaultCenter]postNotificationName:UserLogin object:nil];
                                                               
                                                               [self.navigationController dismissViewControllerAnimated:YES completion:^{
                                                                   
                                                                   [self.view showSuccessWithStatus:@"登陆成功"];
                                                                   
                                                                   SaveCookies
                                                               }];
                                                           }else{
                                                               [self.view showJGErrorWithStatus:messDic[@"messagestr"]];
                                                               return ;
                                                           }
                                                           
                                                       } failure:^(NSError *error) {
                                                           [self.view showJGErrorWithStatus:@"网络错误,登陆失败"];
                                                       }];

}

#pragma mark - **************** PicerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
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
