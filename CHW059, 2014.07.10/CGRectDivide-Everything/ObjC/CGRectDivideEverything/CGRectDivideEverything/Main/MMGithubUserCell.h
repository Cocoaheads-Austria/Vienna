//
// Created by Manuel Maly on 07.07.14.
// Copyright (c) 2014 Creative Pragmatics GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMGithubUser;
@class RACCommand;
@class MMLoadFullUserCommand;

static const CGFloat MMGithubUserCellPartiallyLoadedHeight = 66.f;
static const CGFloat MMGithubUserCellFullyLoadedHeight = 330.f;
static const CGFloat MMGithubUserCellOuterStrokeViewTopOffset = 10.f;

@interface MMGithubUserCell : UITableViewCell

@property (strong, nonatomic) MMGithubUser *user;
@property (strong, nonatomic) MMLoadFullUserCommand *loadFullUserCommand;
@property (assign, nonatomic) BOOL expanded;
@property (assign, nonatomic) BOOL isLastCell;

+ (instancetype)cellForTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

- (void)refreshAllAvailableElementsVisibility;
@end