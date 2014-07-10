//
// Created by Manuel Maly on 07.07.14.
// Copyright (c) 2014 Creative Pragmatics GmbH. All rights reserved.
//

#import "MMGithubUser.h"
#import "MTLValueTransformer.h"


@implementation MMGithubUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"login": @"login",
            @"userId": @"id",
            @"avatarURL": @"avatar_url",
            @"gravatarId": @"gravatar_id",
            @"URL": @"url",
            @"htmlURL": @"html_url",
            @"followersURL": @"followers_url",
            @"followingURL": @"following_url",
            @"gistsURL": @"gists_url",
            @"starredURL": @"starred_url",
            @"subscriptionsURL": @"subscriptions_url",
            @"organizationsURL": @"organizations_url",
            @"reposURL": @"repos_url",
            @"eventsURL": @"events_url",
            @"receivedEventsURL": @"received_events_url",
            @"type": @"type",
            @"siteAdmin": @"site_admin",
            @"name": @"name",
            @"company": @"company",
            @"blog": @"blog",
            @"location": @"location",
            @"email": @"email",
            @"hireable": @"hireable",
            @"publicRepos": @"public_repos",
            @"publicGists": @"public_gists",
            @"followers": @"followers",
            @"following": @"following",
            @"createdAt": @"createdAt",
            @"updatedAt": @"updatedAt"
    };
}

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [self dateTransformer];
}

+ (NSValueTransformer *)updatedAtJSONTransformer {
    return [self dateTransformer];
}

+ (MTLValueTransformer *)dateTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.timeZoneDateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.timeZoneDateFormatter stringFromDate:date];
    }];
}

+ (NSDateFormatter *)timeZoneDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";

    return dateFormatter;
}

- (NSString *)gistsURL {
    return [_gistsURL stringByReplacingOccurrencesOfString:@"{/gist_id}" withString:@""];
}

- (NSString *)followingURL {
    return [_followingURL stringByReplacingOccurrencesOfString:@"{/other_user}" withString:@""];
}

@end