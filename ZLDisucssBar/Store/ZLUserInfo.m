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
        self.userID         = [aDecoder decodeObjectForKey:@"userID"];
        self.password       = [aDecoder decodeObjectForKey:@"password"];
        self.safetyQuestion = [aDecoder decodeObjectForKey:@"safetyQuestion"];
        self.safetyAnswer   = [aDecoder decodeObjectForKey:@"safetyAnswer"];
        self.userUID        = [aDecoder decodeObjectForKey:@"userUID"];
        self.username       = [aDecoder decodeObjectForKey:@"username"];
        self.readaccess     = [aDecoder decodeObjectForKey:@"readaccess"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.userID          forKey:@"userID"];
    [aCoder encodeObject:self.password        forKey:@"password"];
    [aCoder encodeObject:self.safetyQuestion  forKey:@"safetyQuestion"];
    [aCoder encodeObject:self.safetyAnswer    forKey:@"safetyAnswer"];
    [aCoder encodeObject:self.userUID         forKey:@"userUID"];
    [aCoder encodeObject:self.username        forKey:@"username"];
    [aCoder encodeObject:self.readaccess      forKey:@"readaccess"];
}

@end
