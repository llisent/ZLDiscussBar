//
//  HomeGuide.m
//  zuanke8
//
//  Created by Mrr on 16/2/17.
//  Copyright © 2016年 lnzsbks. All rights reserved.
//

#import "HomeGuide.h"
#import "HomeViewController.h"
#import "PersonalCenter.h"

@interface HomeGuide ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation HomeGuide


- (CYLTabBarController *)tabBarController
{
    if (_tabBarController == nil) {
        
        HomeViewController *firstViewController = [[HomeViewController alloc] init];
        UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                       initWithRootViewController:firstViewController];
        
        PersonalCenter *secondViewController = [[PersonalCenter alloc] init];
        UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                        initWithRootViewController:secondViewController];
        

        CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
        
        /*
         *
         在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
         *
         */
        [self setUpTabBarItemsAttributesForController:tabBarController];
        
        [tabBarController setViewControllers:@[
                                               firstNavigationController,
                                               secondNavigationController
                                               ]];
        /**
         *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
         */
        // [[self class] customizeTabBarAppearance];
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
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"account_normal",
                            CYLTabBarItemSelectedImage : @"account_highlight",
                            };

    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2
                                       ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}


@end
