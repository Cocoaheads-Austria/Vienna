//
// Created by Manuel Maly on 08.07.14.
// Copyright (c) 2014 Creative Pragmatics GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa/RACCommand.h>

@class MMGithubUser;
@class AFHTTPRequestOperationManager;

@interface MMLoadFullUserCommand : RACCommand

- (id)initWithUserLogin:(NSString *)login operationManager:(AFHTTPRequestOperationManager *)operationManager;

@end