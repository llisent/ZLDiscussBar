//
//  ZLPostingViewController.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/24.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPostingViewController.h"
#import "ZLImageCollectionCell.h"

@interface ZLPostingViewController ()<UICollectionViewDelegate ,UICollectionViewDataSource ,UINavigationControllerDelegate ,UIImagePickerControllerDelegate>

@end

@implementation ZLPostingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatCostomUI];
    [self initNaviBaritem];
}

- (void)creatCostomUI{
    self.imageCollection.dataSource                     = self;
    self.imageCollection.delegate                       = self;
    self.imageCollection.backgroundColor                = [UIColor clearColor];
    self.imageCollection.showsHorizontalScrollIndicator = NO;
    [self.imageCollection registerNib:[UINib nibWithNibName:@"ZLImageCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
}

- (void)initNaviBaritem{
    UIBarButtonItem *postItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_fabu"] style:UIBarButtonItemStylePlain target:self action:@selector(postNow)];
    self.navigationItem.rightBarButtonItem = postItem;
}

- (void)postNow{
    
}

- (void)callPhotoWithType:(NSString *)type{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate                 = self;
    imagePicker.allowsEditing            = YES;
    
    if ([type isEqualToString:@"1"]) {
        //调用相机拍照
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self.navigationController presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }else{
        }
        
    }else{
        //从相册获取图片
        imagePicker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                          NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15]};
        
        [imagePicker.navigationBar setBarTintColor:[UIColor blackColor]];
        imagePicker.navigationBar.translucent = NO;
        
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self.navigationController presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }else{
        }
    }
}

- (void)callPhotoLibrary{
    
}

- (void)creatChooseView{
    UIView *cleanView          = [[UIView alloc]initWithFrame:ScreenBonds];
    cleanView.backgroundColor  = [UIColor clearColor];
    UIView *hiddenView         = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 100)];
    hiddenView.backgroundColor = [UIColor colorWithWhite:0.871 alpha:1.000];
    UIButton *sureBtn          = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 48)];
    sureBtn.backgroundColor    = [UIColor whiteColor];
    UIButton *cancalBtn        = [[UIButton alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, 48)];
    cancalBtn.backgroundColor  = [UIColor whiteColor];
    
    [sureBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [cancalBtn setTitle:@"从相册选择" forState:UIControlStateNormal];
    
    sureBtn.titleLabel.font   = [UIFont fontWithName:@"HelveticaNeue" size:15];
    cancalBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [sureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [UIView animateWithDuration:0.3 animations:^{
            cleanView.backgroundColor  = [UIColor clearColor];
            hiddenView.top             = ScreenHeight;
            
        } completion:^(BOOL finished) {
            if (cleanView.superview) {
                [cleanView removeFromSuperview];
            }
            [self callPhotoWithType:@"1"];
        }];
    }];
    [cancalBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [UIView animateWithDuration:0.3 animations:^{
            cleanView.backgroundColor  = [UIColor clearColor];
            hiddenView.top             = ScreenHeight;
            
        } completion:^(BOOL finished) {
            if (cleanView.superview) {
                [cleanView removeFromSuperview];
            }
            [self callPhotoWithType:@"2"];
        }];
    }];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
        [UIView animateWithDuration:0.3 animations:^{
            cleanView.backgroundColor  = [UIColor clearColor];
            hiddenView.top             = ScreenHeight;
            
        } completion:^(BOOL finished) {
            if (cleanView.superview) {
                [cleanView removeFromSuperview];
            }
        }];
    }];
    [cleanView addGestureRecognizer:ges];
    [hiddenView addSubview:sureBtn];
    [hiddenView addSubview:cancalBtn];
    [cleanView addSubview:hiddenView];
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:cleanView];
    [UIView animateWithDuration:0.3 animations:^{
        cleanView.backgroundColor  = [UIColor colorWithWhite:0.000 alpha:0.300];
        hiddenView.top             = ScreenHeight - 100;
    }];
}



#pragma mark - **************** Collectionview Delegate & Datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 14;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZLImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self creatChooseView];
}

#pragma mark - **************** ImagePicker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
        

//        self.userImg.image = info[@"UIImagePickerControllerEditedImage"];

        
    }];
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
