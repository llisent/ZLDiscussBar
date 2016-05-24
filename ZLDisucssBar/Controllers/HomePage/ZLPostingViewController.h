//
//  ZLPostingViewController.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/24.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLPostingViewController : UIViewController

/** 标题*/
@property (weak, nonatomic) IBOutlet UITextField      *titleTextField;

/** 内容*/
@property (weak, nonatomic) IBOutlet UITextView       *contentTextView;

/** 图片*/
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollection;
@end
