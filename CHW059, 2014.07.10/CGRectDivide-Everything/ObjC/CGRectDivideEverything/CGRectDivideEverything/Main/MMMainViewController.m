//
// Created by Manuel Maly on 07.07.14.
// Copyright (c) 2014 Creative Pragmatics GmbH. All rights reserved.
//
#import "MMMainViewController.h"
#import "MMMainViewModel.h"
#import "MMMainView.h"

@interface MMMainViewController()

@property (strong, nonatomic) MMMainView *view;
@property (strong, nonatomic) MMMainViewModel *viewModel;

@end

@implementation MMMainViewController

- (id)init {
    if (self = [super init]) {
        self.viewModel = MMMainViewModel.new;
    }

    return self;
}

- (void)loadView {
    MMMainView *view = MMMainView.new;
    view.frame = UIScreen.mainScreen.applicationFrame;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.viewModel = self.viewModel;
}

@end