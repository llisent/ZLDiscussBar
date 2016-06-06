//
//  ZLMainPostViewController.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/6/6.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLMainPostViewController.h"

@interface ZLMainPostViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic  ) IBOutlet UITextField  *titleTextField;
@property (weak, nonatomic  ) IBOutlet UITextView   *contentTextView;

@property (nonatomic ,strong) NSDictionary *threadDic;

@end

@implementation ZLMainPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSDictionary *)threadDic{
    if (!_threadDic) {
        _threadDic = @{
                       @"zkdjt":@[@"大家谈谈", @"zk心情", @"我来帮忙", @"活动线报"],
                       @"活动线报":@[@"轻", @"软件", @"缓", @"急", @"重", @"秘籍"],
                       @"活动秘籍":@[@"转载秘籍", @"原创秘籍", @"原创经验",@"转帖经验"],
                       @"zp显摆":@"",
                       @"":@""};
    }
    return _threadDic;
}

- (IBAction)chooseThread:(id)sender {
    
}

- (IBAction)submitNow:(id)sender {
    
}

#pragma mark - **************** PicerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 8;
}

#pragma mark - **************** PickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        switch (row) {
            case 0:
                
                break;
            case 1:
                
                break;
            case 2:
                
                break;
            case 3:
                
                break;
            case 4:
                
                break;
                
            default:
                break;
        }
    }else{
        
    }
    return nil;
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
