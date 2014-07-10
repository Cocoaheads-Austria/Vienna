//
// Created by Manuel Maly on 07.07.14.
// Copyright (c) 2014 Creative Pragmatics GmbH. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa/RACCommand.h>
#import <ReactiveCocoa/ReactiveCocoa/RACSignal+Operations.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa/RACSubscriptingAssignmentTrampoline.h>
#import "MMLoadFullUserCommand.h"
#import <ReactiveCocoa/ReactiveCocoa/NSObject+RACPropertySubscribing.h>
#import <ReactiveCocoa/ReactiveCocoa/UITableViewCell+RACSignalSupport.h>
#import "MMGithubUserCell.h"
#import "MMGithubUser.h"
#import "MMRoundedButton.h"
#import "UIView+MMAdditions.h"
#import "UIImageView+AFNetworking.h"

static const CGFloat outerStrokeViewBorderWidth = 2.f;

@interface MMGithubUserCell()

@property (assign, nonatomic) BOOL loading;

@property (strong, nonatomic) UIView *outerStrokeView;
@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *loginLabel;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) MMRoundedButton *reposButton;
@property (strong, nonatomic) MMRoundedButton *gistsButton;
@property (strong, nonatomic) MMRoundedButton *followersButton;
@property (strong, nonatomic) MMRoundedButton *followingButton;
@property (strong, nonatomic) UILabel *companyDescLabel;
@property (strong, nonatomic) UILabel *companyLabel;
@property (strong, nonatomic) UILabel *hireableDescLabel;
@property (strong, nonatomic) UILabel *hireableLabel;
@property (strong, nonatomic) UILabel *profileURLDescLabel;
@property (strong, nonatomic) UILabel *profileURLLabel;
@property (strong, nonatomic) UILabel *blogDescLabel;
@property (strong, nonatomic) UILabel *blogLabel;

@end

@implementation MMGithubUserCell

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.outerStrokeView = [self.class makeStrokeView];
        self.avatarView = [self.class makeAvatarView];
        self.loginLabel = [self.class makeLabelWithFontSize:20.f];
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.reposButton = [self makeButton];
        self.gistsButton = [self makeButton];
        self.followersButton = [self makeButton];
        self.followingButton = [self makeButton];
        self.companyDescLabel = [self.class makeAttributeDescLabel];
        self.companyLabel = [self.class makeAttributeLabel];
        self.hireableDescLabel = [self.class makeAttributeDescLabel];
        self.hireableLabel = [self.class makeAttributeLabel];
        self.profileURLDescLabel = [self.class makeAttributeDescLabel];
        self.profileURLLabel = [self.class makeAttributeLabel];
        self.blogDescLabel = [self.class makeAttributeDescLabel];
        self.blogLabel = [self.class makeAttributeLabel];

        self.activityIndicator.hidesWhenStopped = YES;
        self.activityIndicator.color = UIColor.blackColor;
        self.companyDescLabel.text = @"Working at";
        self.hireableDescLabel.text = @"Hireable";
        self.hireableLabel.textAlignment = NSTextAlignmentCenter;
        self.profileURLDescLabel.text = @"Github Profile";
        self.blogDescLabel.text = @"Blog";

        [self addSubviews:@[_outerStrokeView, _avatarView, _loginLabel, _activityIndicator, _reposButton, _gistsButton, _followersButton, _followingButton]];
        [self addSubviews:@[_companyDescLabel, _companyLabel, _hireableDescLabel, _hireableLabel, _profileURLDescLabel, _profileURLLabel, _blogDescLabel, _blogLabel]];
    }

    return self;
}

+ (instancetype)cellForTableView:(UITableView *)tableView style:(UITableViewCellStyle)style {
    NSString *cellID = [self cellIdentifier];
    MMGithubUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    }

    return cell;
}


+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (UIView *)makeStrokeView {
    UIView *strokeView = UIView.new;
    strokeView.layer.borderWidth = outerStrokeViewBorderWidth;
    strokeView.layer.borderColor = [UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1.0].CGColor;
    strokeView.layer.cornerRadius = 5.f;
    strokeView.layer.shouldRasterize = YES;
    strokeView.layer.rasterizationScale = UIScreen.mainScreen.scale;

    return strokeView;
}

+ (UIImageView *)makeAvatarView {
    UIImageView *avatarView = UIImageView.new;
    avatarView.clipsToBounds = YES;
    avatarView.layer.cornerRadius = 3.f;
    avatarView.layer.shouldRasterize = YES;
    avatarView.layer.rasterizationScale = UIScreen.mainScreen.scale;

    return avatarView;
}

+ (UILabel *)makeLabelWithFontSize:(CGFloat)fontSize {
    UILabel *label = UILabel.new;
    label.font = [UIFont fontWithName:@"Futura-Medium" size:fontSize];
    label.backgroundColor = UIColor.clearColor;
    return label;
}

- (MMRoundedButton *)makeButton {
    MMRoundedButton *button = MMRoundedButton.new;
    [button addTarget:self action:@selector(onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UILabel *)makeAttributeDescLabel {
    UILabel *label = UILabel.new;
    label.font = [UIFont fontWithName:@"Futura-Medium" size:12.f];
    label.backgroundColor = UIColor.clearColor;
    label.textColor = UIColor.grayColor;
    return label;
}

+ (UILabel *)makeAttributeLabel {
    UILabel *label = UILabel.new;
    label.font = [UIFont fontWithName:@"Futura-Medium" size:16.f];
    label.backgroundColor = UIColor.clearColor;
    return label;
}

#pragma mark - Attribute Accessors

- (void)setLoading:(BOOL)loading {
    if (_loading == loading) return;

    _loading = loading;
    if (loading) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
}

- (void)setLoadFullUserCommand:(MMLoadFullUserCommand *)loadFullUserCommand {
    NSAssert(!(loadFullUserCommand && _loadFullUserCommand), @"loadFullUserCommand can only be set once after initial state or prepareForReuse.");
    _loadFullUserCommand = loadFullUserCommand;

    @weakify(self)
    // We don't do a RAC(self, user) assignment here because that would make it impossible
    // to make a binding from outside the cell (which might someday be necessary).
    [[[_loadFullUserCommand.executionSignals.flatten ignore:nil] takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(MMGithubUser *user) {
        @strongify(self)
        self.user = user;
    }];

    [[[[RACObserve(self, expanded) map:^id(NSNumber *expanded) {
        @strongify(self)
        if (expanded.boolValue) {
            return RACObserve(self, user.fullyLoaded);
        } else {
            return [RACSignal return:@(NO)];
        }
    }] switchToLatest] takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(NSNumber *animateToFullState) {
        if (!animateToFullState) return; // no-op

        CGFloat alpha = animateToFullState.boolValue ? 1.f : 0.f;
        NSTimeInterval duration = animateToFullState.boolValue ? 0.5f : 0.3f;
        NSTimeInterval delay = animateToFullState.boolValue ? 0.3f : 0.f;
        [UIView animateWithDuration:duration delay:delay options:0 animations:^{
            [self setSideloadedElementsAlpha:alpha];
        } completion:nil];
    }];

    RAC(self, loading) = [loadFullUserCommand.executing takeUntil:self.rac_prepareForReuseSignal];
}

- (void)setUser:(MMGithubUser *)user {
    _user = user;

    self.loginLabel.text = user.name ?: user.login;
    [self.avatarView setImageWithURL:[NSURL URLWithString:user.avatarURL] placeholderImage:[UIImage imageNamed:@"octocat"]];
    [self.reposButton setTitle:(user.fullyLoaded ? [NSString stringWithFormat:@"%d Repos", user.publicRepos] : nil) forState:UIControlStateNormal];
    [self.gistsButton setTitle:(user.fullyLoaded ? [NSString stringWithFormat:@"%d Gists", user.publicGists] : nil) forState:UIControlStateNormal];
    [self.followersButton setTitle:(user.fullyLoaded ? [NSString stringWithFormat:@"%d Followers", user.followers] : nil) forState:UIControlStateNormal];
    [self.followingButton setTitle:(user.fullyLoaded ? [NSString stringWithFormat:@"Following %d", user.following] : nil) forState:UIControlStateNormal];
    self.companyLabel.text = [self safeifyAttributeString:user.company withUser:user];
    self.hireableLabel.text = (user.fullyLoaded ? (user.hireable ? @"✔" : @"✘") : nil);
    self.profileURLLabel.text = [self safeifyAttributeString:user.htmlURL withUser:user];
    self.blogLabel.text = [self safeifyAttributeString:user.blog withUser:user];
}

- (NSString *)safeifyAttributeString:(NSString *)attributeString withUser:(MMGithubUser *)user {
    return (user.fullyLoaded ? (attributeString.length > 0 ? attributeString : @"-") : nil);
}

- (void)refreshAllAvailableElementsVisibility {
    CGFloat alpha = (self.user.fullyLoaded && self.expanded) ? 1.f : 0.f;
    self.reposButton.alpha = self.gistsButton.alpha = self.followersButton.alpha = self.followingButton.alpha = alpha;
}

- (void)setSideloadedElementsAlpha:(CGFloat)alpha {
    self.reposButton.alpha = self.gistsButton.alpha = self.followersButton.alpha = self.followingButton.alpha = alpha;
    self.companyDescLabel.alpha = self.companyLabel.alpha = self.hireableDescLabel.alpha = self.hireableLabel.alpha = alpha;
    self.profileURLDescLabel.alpha = self.profileURLLabel.alpha = self.blogDescLabel.alpha = self.blogLabel.alpha = alpha;
}

#pragma mark - Actions

- (void)onButtonTapped:(id)button {
    if (button == self.reposButton) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.user.reposURL]];
    } else if (button == self.gistsButton) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.user.gistsURL]];
    } else if (button == self.followersButton) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.user.followersURL]];
    } else if (button == self.followingButton) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.user.followingURL]];
    }
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];

    static const CGFloat outerStrokeViewHInset = 10.f;
    static const CGFloat innerStrokePadding = 10.f;
    static const CGFloat activityIndicatorWidth = 40.f;
    static const CGFloat avatarToLoginLabelMargin = 20.f;
    static const CGFloat activityIndicatorToLoginLabelMargin = 10.f;
    static const CGFloat firstToSecondLineMargin = 15.f;
    static const CGFloat secondToThirdLineMargin = 8.f;
    static const CGFloat attributeLineMargin = 12.f;
    static const CGFloat attributeLabelInnerAndOuterMargin = 10.f;
    static const CGFloat attributeDescLabelBottomMargin = 2.f;

    CGRect nettoRect, slice, verticalRemainder, lineRemainder;

    // Outer stroke view has inset from bounds
    CGRect offsetBounds = CGRectOffset(self.bounds, 0, MMGithubUserCellOuterStrokeViewTopOffset);
    offsetBounds.size.height -= MMGithubUserCellOuterStrokeViewTopOffset * (self.isLastCell ? 2.f : 1.f);
    self.outerStrokeView.frame = CGRectInset(offsetBounds, outerStrokeViewHInset, 0);

    // Netto rect is where all the other elements align
    nettoRect = CGRectInset(self.outerStrokeView.frame, innerStrokePadding, innerStrokePadding);


    //////// 1. line (avatar, login label, and activity indicator) ////////

    CGFloat firstLineHeight = MMGithubUserCellPartiallyLoadedHeight - MMGithubUserCellOuterStrokeViewTopOffset - 2 * innerStrokePadding;
    CGRectDivide(nettoRect, &slice, &verticalRemainder, firstLineHeight, CGRectMinYEdge);

    // Slice avatar
    CGRectDivide(slice, &slice, &lineRemainder, firstLineHeight, CGRectMinXEdge);
    self.avatarView.frame = slice;

    // Slice activity indicator
    CGRectDivide(lineRemainder, &slice, &lineRemainder, activityIndicatorWidth, CGRectMaxXEdge);
    self.activityIndicator.frame = slice;

    // Cut padding avatar <> login label
    CGRectDivide(lineRemainder, &slice, &lineRemainder, avatarToLoginLabelMargin, CGRectMinXEdge);

    // Cut padding activity indicator <> login label
    CGRectDivide(lineRemainder, &slice, &lineRemainder, activityIndicatorToLoginLabelMargin, CGRectMaxXEdge);

    // Horizontal remainder is login label
    self.loginLabel.frame = lineRemainder;


    //////// 2. line (repos and gists button) ////////

    // Cut horizontal padding between 1. and 2. line
    CGRectDivide(verticalRemainder, &slice, &verticalRemainder, firstToSecondLineMargin, CGRectMinYEdge);

    // Slice 2. line buttons
    CGFloat secondLineHeight = self.reposButton.intrinsicContentSize.height;
    CGRectDivide(verticalRemainder, &slice, &verticalRemainder, secondLineHeight, CGRectMinYEdge);
    [self layoutEvenlyDistributedButtonsInRect:slice leftButton:self.reposButton rightButton:self.gistsButton];


    //////// 3. line (followers and following button) ////////

    // Cut horizontal padding between 2. and 3. line
    CGRectDivide(verticalRemainder, &slice, &verticalRemainder, secondToThirdLineMargin, CGRectMinYEdge);

    // Slice 3. line buttons
    CGFloat thirdLineHeight = self.followingButton.intrinsicContentSize.height;
    CGRectDivide(verticalRemainder, &slice, &verticalRemainder, thirdLineHeight, CGRectMinYEdge);
    [self layoutEvenlyDistributedButtonsInRect:slice leftButton:self.followersButton rightButton:self.followingButton];


    //////// Setup for remaining attribute lines ////////

    CGFloat attributeDescLabelHeight = [self.hireableDescLabel sizeThatFits:CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric)].height;
    CGFloat attributeLabelHeight = [@"T" sizeWithAttributes:@{NSFontAttributeName: self.hireableLabel.font}].height;
    CGFloat totalAttributeAndDescLabelHeights = attributeDescLabelHeight + attributeDescLabelBottomMargin + attributeLabelHeight;

    // Cut left and right margins for the lines to come (looks better)
    CGRectDivide(verticalRemainder, &slice, &verticalRemainder, attributeLabelInnerAndOuterMargin, CGRectMinXEdge);
    CGRectDivide(verticalRemainder, &slice, &verticalRemainder, attributeLabelInnerAndOuterMargin, CGRectMaxXEdge);


    //////// 4. line (working at and hireable) ////////

    // Cut horizontal padding between 3. and 4. line
    CGRectDivide(verticalRemainder, &slice, &verticalRemainder, attributeLineMargin, CGRectMinYEdge);

    // Slice 4. line
    CGRectDivide(verticalRemainder, &slice, &verticalRemainder, totalAttributeAndDescLabelHeights, CGRectMinYEdge);

    // Slice hireable labels
    CGSize hireableDescLabelSize = [self.hireableDescLabel sizeThatFits:CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric)];
    CGRectDivide(slice, &slice, &lineRemainder, hireableDescLabelSize.width, CGRectMaxXEdge);
    [self layoutAttributeLabel:self.hireableLabel andDescLabel:self.hireableDescLabel inRect:slice descLabelHeight:attributeDescLabelHeight labelHeight:attributeLabelHeight];
    CGRectDivide(lineRemainder, &slice, &lineRemainder, attributeLabelInnerAndOuterMargin, CGRectMaxXEdge);
    [self layoutAttributeLabel:self.companyLabel andDescLabel:self.companyDescLabel inRect:lineRemainder descLabelHeight:attributeDescLabelHeight labelHeight:attributeLabelHeight];


    //////// 5. & 6. line (profile URL and blog) ////////

    for (NSArray *lineLabels in @[@[self.profileURLDescLabel, self.profileURLLabel], @[self.blogDescLabel, self.blogLabel]]) {
        UILabel *descLabel = lineLabels[0];
        UILabel *attributeLabel = lineLabels[1];

        // Cut horizontal padding between last and this line
        CGRectDivide(verticalRemainder, &slice, &verticalRemainder, attributeLineMargin, CGRectMinYEdge);

        // Slice this line
        CGRectDivide(verticalRemainder, &slice, &verticalRemainder, totalAttributeAndDescLabelHeights, CGRectMinYEdge);

        [self layoutAttributeLabel:attributeLabel andDescLabel:descLabel inRect:slice descLabelHeight:attributeDescLabelHeight labelHeight:attributeLabelHeight];
    }
}

- (void)layoutEvenlyDistributedButtonsInRect:(CGRect)rect leftButton:(UIButton *)leftButton rightButton:(UIButton *)rightButton {
    static const CGFloat twoEvenlyDistributedButtonsMargin = 5.f;
    CGFloat twoEvenlyDistributedButtonsButtonWidth = (CGRectGetWidth(rect) - twoEvenlyDistributedButtonsMargin) / 2.f;
    CGRect slice, remainder;

    // Slice repos button
    CGRectDivide(rect, &slice, &remainder, twoEvenlyDistributedButtonsButtonWidth, CGRectMinXEdge);
    leftButton.frame = slice;

    // Cut buttons margin
    CGRectDivide(remainder, &slice, &remainder, twoEvenlyDistributedButtonsMargin, CGRectMinXEdge);

    // Right button is remainder
    rightButton.frame = remainder;
}

- (void)layoutAttributeLabel:(UILabel *)attributeLabel andDescLabel:(UILabel *)descLabel inRect:(CGRect)rect descLabelHeight:(CGFloat)descLabelHeight labelHeight:(CGFloat)labelHeight {
    CGRect slice, remainder;

    CGRectDivide(rect, &slice, &remainder, descLabelHeight, CGRectMinYEdge);
    descLabel.frame = slice;

    CGRectDivide(remainder, &slice, &remainder, labelHeight, CGRectMaxYEdge);
    attributeLabel.frame = slice;
}

#pragma mark - Teardown

- (void)prepareForReuse {
    [self setSideloadedElementsAlpha:0.f];
    self.expanded = NO;
    self.loadFullUserCommand = nil;
    self.user = nil;
}

@end