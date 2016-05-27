//
//  AppDelegate.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/26.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeGuide.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ReadCookies
    [self initCorrelationSetting];
    
    self.window                    = [[UIWindow alloc]initWithFrame:ScreenBonds];
    HomeGuide *guide               = [[HomeGuide alloc]init];
    self.window.rootViewController = guide.tabBarController;
    [self.window makeKeyWindow];    
    return YES;
}

- (void)initCorrelationSetting{
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"title_bg"] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    [[UINavigationBar appearance]setTitleTextAttributes:@{
                                                          NSForegroundColorAttributeName:[UIColor whiteColor]
                                                          }];
    
    [[UIBarButtonItem appearance]setTitleTextAttributes:@{
                                                          NSForegroundColorAttributeName:[UIColor colorWithWhite:1.0 alpha:0.8]
                                                          }
                                               forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearance]setTintColor:[UIColor whiteColor]];
    
    UIImage *backImage = [UIImage imageNamed:@"back"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[backImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backImage.size.width, 0, 0)]
                                                      forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-233, 0) forBarMetrics:UIBarMetricsDefault];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
