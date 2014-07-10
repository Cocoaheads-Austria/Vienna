//
// Created by Manuel Maly on 07.07.14.
// Copyright (c) 2014 Creative Pragmatics GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACCommand;
@class MMGithubUser;
@class MMLoadFullUserCommand;
@class RACSubject;


@interface MMMainViewModel : NSObject

@property (copy, nonatomic) NSString *searchTerm;
@property (copy, nonatomic) NSArray *partialUsers;
@property (strong, nonatomic, readonly) NSMutableDictionary *fullyLoadedUsers;
@property (strong, nonatomic, readonly) RACSubject *someUserFullyLoaded;
@property (assign, nonatomic, readonly) BOOL loadingUsers;

- (MMLoadFullUserCommand *)loadFullUserCommand:(MMGithubUser *)user createIfNotExists:(BOOL)createIfNotExists;

@end