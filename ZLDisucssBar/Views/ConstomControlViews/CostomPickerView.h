//
//  CostomPickerView.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostomPickerView : UIView

/** pickerView*/
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

/** 确定*/
@property (weak, nonatomic) IBOutlet UIButton     *sureBtn;

/** 取消*/
@property (weak, nonatomic) IBOutlet UIButton     *cancelBtn;

@end
