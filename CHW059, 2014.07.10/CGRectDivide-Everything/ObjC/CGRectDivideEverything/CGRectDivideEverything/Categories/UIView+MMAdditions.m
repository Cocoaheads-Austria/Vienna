//
// Created by Manuel Maly on 09.07.14.
// Copyright (c) 2014 Creative Pragmatics GmbH. All rights reserved.
//

#import "UIView+MMAdditions.h"

@implementation UIView (MMAdditions)

- (void)addSubviews:(NSArray *)views {
    for (UIView *view in views) {
        [self addSubview:view];
    }
}

@end