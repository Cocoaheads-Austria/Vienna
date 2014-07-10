//
// Created by Manuel Maly on 08.07.14.
// Copyright (c) 2014 Creative Pragmatics GmbH. All rights reserved.
//

#import <AFNetworking-RACExtensions/AFHTTPRequestOperationManager+RACSupport.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <RACEXTScope.h>
#import "MMLoadFullUserCommand.h"
#import "MMGithubUser.h"

@implementation MMLoadFullUserCommand

- (id)initWithUserLogin:(NSString *)login operationManager:(AFHTTPRequestOperationManager *)operationManager {
    @weakify(operationManager)
    self = [super initWithSignalBlock:^RACSignal *(id input) {
        @strongify(operationManager)
        return [[operationManager rac_GET:[NSString stringWithFormat:@"users/%@", login] parameters:nil] map:^id(NSDictionary *userDict) {
            MMGithubUser *user = [MTLJSONAdapter modelOfClass:MMGithubUser.class fromJSONDictionary:userDict error:nil];
            user.fullyLoaded = YES;
            return user;
        }];
    }];

    return self;
}

@end