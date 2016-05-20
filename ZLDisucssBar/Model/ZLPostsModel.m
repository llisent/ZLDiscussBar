//
//  ZLPostsModel.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/5/5.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPostsModel.h"

@implementation ZLPostsModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        self.author     = [aDecoder decodeObjectForKey:@"author"];
        self.authorid   = [aDecoder decodeObjectForKey:@"authorid"];
        self.subject    = [aDecoder decodeObjectForKey:@"subject"];
        self.tid        = [aDecoder decodeObjectForKey:@"tid"];
        self.replies    = [aDecoder decodeObjectForKey:@"replies"];
        self.views      = [aDecoder decodeObjectForKey:@"views"];
        self.dateline   = [aDecoder decodeObjectForKey:@"dateline"];
        self.lastpost   = [aDecoder decodeObjectForKey:@"lastpost"];
        self.lastposter = [aDecoder decodeObjectForKey:@"lastposter"];
        self.readperm   = [aDecoder decodeObjectForKey:@"readperm"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.authorid forKey:@"authorid"];
    [aCoder encodeObject:self.subject forKey:@"subject"];
    [aCoder encodeObject:self.tid forKey:@"tid"];
    [aCoder encodeObject:self.replies forKey:@"replies"];
    [aCoder encodeObject:self.views forKey:@"views"];
    [aCoder encodeObject:self.dateline forKey:@"dateline"];
    [aCoder encodeObject:self.lastpost forKey:@"lastpost"];
    [aCoder encodeObject:self.lastposter forKey:@"lastposter"];
    [aCoder encodeObject:self.readperm forKey:@"readperm"];
    
}

@end