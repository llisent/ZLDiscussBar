//
//  ZLPersonalInfoCell.m
//  ZLDisucssBar
//
//  Created by Mrr on 16/6/2.
//  Copyright © 2016年 llisent. All rights reserved.
//

#import "ZLPersonalInfoCell.h"

@implementation ZLPersonalInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateInfomationWith:(NSDictionary *)dic rowsNum:(NSInteger)num{
    NSDictionary *spaceDic = dic[@"space"];
    NSDictionary *groupDic = spaceDic[@"group"];
    
    NSString *upStr = [NSString stringWithFormat:@"%d",[groupDic[@"creditslower"] intValue] - [spaceDic[@"credits"] intValue]];
    
    
    switch (num) {
        case 0:[self updateWith:@"用户名" content:spaceDic[@"username"]];   // ------用户名
            break;
        case 1:[self updateWith:@"用户ID" content:spaceDic[@"uid"]];        // ------uid
            break;
        case 2:[self updateWith:@"果果" content:spaceDic[@"credits"]];
            break;
        case 3:[self updateWith:@"用户级别" content:groupDic[@"grouptitle"]];
            break;
        case 4:[self updateWith:@"阅读权限" content:groupDic[@"readaccess"]];
            break;
        case 5:[self updateWith:@"发帖数" content:spaceDic[@"threads"]];
            break;
        case 6:[self updateWith:@"回帖数" content:spaceDic[@"posts"]];
            break;
        case 7:[self updateWith:@"收藏数" content:spaceDic[@"favthreads"]];
            break;
        case 8:[self updateWith:@"注册时间" content:spaceDic[@"regdate"]];
            break;
        case 9:[self updateWith:@"上次登录" content:spaceDic[@"lastvisit"]];
            break;
        case 10:[self updateWith:@"上次回帖" content:spaceDic[@"lastpost"]];
            break;
        case 11:[self updateWith:@"听众" content:spaceDic[@"follower"]];
            break;
        case 12:[self updateWith:@"收听" content:spaceDic[@"following"]];
            break;
        case 13:[self updateWith:@"升级" content:upStr];
            break;
        default:
            break;
    }
}

- (void)updateWith:(NSString *)title content:(NSString *)infoStr{
    self.titleLabel.text   = title;
    self.contentLabel.text = infoStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
