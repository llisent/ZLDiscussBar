//
//  ZLPurchaseModel.h
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/23.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLPurchaseModel : NSObject

/** 售价*/
@property (nonatomic ,strong) NSString *price;

/** 总计个数*/
@property (nonatomic ,strong) NSString *accountNum;

/** 剩余个数*/
@property (nonatomic ,strong) NSString *lessNum;

/** 售出个数*/
@property (nonatomic ,strong) NSString *sellNum;

/** 出售模式*/
@property (nonatomic ,strong) NSString *sellType;

@end
