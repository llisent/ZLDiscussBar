//
//  ZLUserInfo.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/4/27.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLUserInfo.h"

@implementation ZLUserInfo

+ (instancetype)sharedInstence{
    static ZLUserInfo *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *docPath =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *path    =  [docPath stringByAppendingPathComponent:@"user.info"];
        user = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!user) {
            user = [[ZLUserInfo alloc]init];
        }
    });
    return user;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.userUID        = [aDecoder decodeObjectForKey:@"userUID"];
        self.username       = [aDecoder decodeObjectForKey:@"username"];
        self.readaccess     = [aDecoder decodeObjectForKey:@"readaccess"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userUID         forKey:@"userUID"];
    [aCoder encodeObject:self.username        forKey:@"username"];
    [aCoder encodeObject:self.readaccess      forKey:@"readaccess"];
}

- (void)clearUserInfoWhenExit{
    self.userUID    = @"";
    self.username   = @"";
    self.readaccess = @"";
}

@end
