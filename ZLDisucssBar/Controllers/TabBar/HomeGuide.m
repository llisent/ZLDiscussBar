//
//  HomeGuide.m
//  zuanke8
//
//  Created by Mrr on 16/2/17.
//  Copyright © 2016年 lnzsbks. All rights reserved.
//

#import "HomeGuide.h"
#import "ZLHomePageViewController.h"
#import "ZLPersonalCenter.h"
#import "ZLPlateViewController.h"
#import "ZLBookMarkViewController.h"

@interface HomeGuide ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation HomeGuide


- (CYLTabBarController *)tabBarController
{
    if (_tabBarController == nil) {
        
        ZLHomePageViewController *firstViewController = [[ZLHomePageViewController alloc] init];
        UIViewController *firstNavigationController   = [[UINavigationController alloc]
                                                       initWithRootViewController:firstViewController];

        ZLPlateViewController *secondViewController   = [[ZLPlateViewController alloc]init];
        UIViewController *secondNavigationController  = [[UINavigationController alloc]initWithRootViewController:secondViewController];

        ZLBookMarkViewController *thirdViewController = [[ZLBookMarkViewController alloc]init];
        UIViewController *thirdNavigationController   = [[UINavigationController alloc]initWithRootViewController:thirdViewController];

        ZLPersonalCenter *fourthViewController        = [[ZLPersonalCenter alloc] init];
        UIViewController *fourthNavigationController  = [[UINavigationController alloc]
                                                        initWithRootViewController:fourthViewController];

        CYLTabBarController *tabBarController         = [[CYLTabBarController alloc] init];
        
        /*
         *
         在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
         *
         */
        [self setUpTabBarItemsAttributesForController:tabBarController];
        
        [tabBarController setViewControllers:@[
                                               firstNavigationController,
                                               secondNavigationController,
                                               thirdNavigationController,
                                               fourthNavigationController
                                               ]];
        /**
         *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
         */
         [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}
/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
 *
 */
- (void)setUpTabBarItemsAttributesForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"home_normal",
                            CYLTabBarItemSelectedImage : @"home_highlight",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"板块",
                            CYLTabBarItemImage : @"fishpond_normal",
                            CYLTabBarItemSelectedImage : @"fishpond_highlight",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"书签",
                            CYLTabBarItemImage : @"message_normal",
                            CYLTabBarItemSelectedImage : @"message_highlight",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"account_normal",
                            CYLTabBarItemSelectedImage : @"account_highlight",
                            };

    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
                                       dict3,
                                       dict4
                                       ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController{
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.149 alpha:1.000];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
}


@end
