//
// Created by Manuel Maly on 07.07.14.
// Copyright (c) 2014 Creative Pragmatics GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/MTLJSONAdapter.h>
#import "MTLModel.h"

@interface MMGithubUser : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic) NSString *login;
@property (assign, nonatomic) NSInteger userId;
@property (copy, nonatomic) NSString *avatarURL;
@property (copy, nonatomic) NSString *gravatarId;
@property (copy, nonatomic) NSString *URL;
@property (copy, nonatomic) NSString *htmlURL;
@property (copy, nonatomic) NSString *followersURL;
@property (copy, nonatomic) NSString *followingURL;
@property (copy, nonatomic) NSString *gistsURL;
@property (copy, nonatomic) NSString *starredURL;
@property (copy, nonatomic) NSString *subscriptionsURL;
@property (copy, nonatomic) NSString *organizationsURL;
@property (copy, nonatomic) NSString *reposURL;
@property (copy, nonatomic) NSString *eventsURL;
@property (copy, nonatomic) NSString *receivedEventsURL;
@property (copy, nonatomic) NSString *type;
@property (assign, nonatomic) BOOL siteAdmin;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *company;
@property (copy, nonatomic) NSString *blog;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *email;
@property (assign, nonatomic) BOOL hireable;
@property (copy, nonatomic) NSString *bio;
@property (assign, nonatomic) NSInteger publicRepos;
@property (assign, nonatomic) NSInteger publicGists;
@property (assign, nonatomic) NSInteger followers;
@property (assign, nonatomic) NSInteger following;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSDate *updatedAt;

// Transient
@property (assign, nonatomic) BOOL fullyLoaded;

@end