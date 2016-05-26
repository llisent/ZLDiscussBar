//
//  Macros.h
//  ForecastLottery
//
//  Created by Mrr on 16/4/6.
//  Copyright © 2016年 llisent. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

// ------UIColor
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


// ------屏幕尺寸相关
#define ScreenBonds [UIScreen mainScreen].bounds
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

// ------获取函数执行时间
#define TICK   NSDate *startTime = [NSDate date];
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow]);


//
#define UserLogin   @"UserLoginNotification"
#define UserExit    @"UserExitNotification"

//用户头像姓名存储
#define UserInformation @"userInfomation"




#endif /* Macros_h */
