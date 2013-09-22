//
//  GIGameOverCreditsView.m
//  GuessIt
//
//  Created by Marlon Andrade on 16/09/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIGameOverCreditsView.h"

#import "GIConfiguration.h"
#import "GIDefinitions.h"
#import "GISound.h"
#import "GIUserInterfaceElement.h"
#import "MALazykit.h"
#import "UIFont+GuessItFonts.h"
#import "UIView+CBFrameHelpers.h"

@interface GIGameOverCreditsView ()

@property (nonatomic, strong, readonly) GIUserInterfaceElement *ui;

@property (nonatomic, strong) UILabel *credits;
@property (nonatomic, strong) UILabel *thankYou;
@property (nonatomic, strong, readonly) NSDictionary *peopleToThank;
@property (nonatomic, strong) NSMutableArray *roleLabels;
@property (nonatomic, strong) NSMutableArray *personLabels;

- (void)_initialize;
- (void)_catSoundEasterEgg:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation GIGameOverCreditsView

@synthesize peopleToThank = _peopleToThank;

#pragma mark - Getter

- (GIUserInterfaceElement *)ui {
    return [GIConfiguration sharedInstance].game.interface.credits;
}


- (NSDictionary *)peopleToThank {
    if (!_peopleToThank) {
        _peopleToThank = @{
            @"1_development" : @[
                                  @"marlon"
                                ],
            @"2_game_design" : @[
                                  @"marlon"
                                ],
            @"3_level_design": @[
                                  @"marlon",
                                  @"rosiene"
                                ],
            @"4_beta_tester" : @[
                                  @"rosiene",
                                  @"maurilio",
                                  @"david",
                                  @"tadeu",
                                  @"fabim",
                                  @"marcella",
                                  @"fabio",
                                  @"fabim2",
                                  @"diogo"
                                ],
            @"5_other"       : @[
                                  @"lion",
                                  @"cheetara",
                                  @"lucio",    
                                  @"coffee"
                                ]
        };
    }
    return _peopleToThank;
}
#define GI_PEOPLE_TO_THANK @{      \
}

- (UILabel *)credits {
    if (!_credits) {
        _credits = [UILabel label];
        _credits.text = NSLocalizedStringFromTable(@"credits", @"game_over", nil);
        _credits.backgroundColor = [UIColor clearColor];
        _credits.font = [UIFont guessItCreditsFont];
        _credits.textColor = self.ui.textColor;
        _credits.shadowColor = self.ui.shadowColor;
        _credits.shadowOffset = CGSizeMake(0.f, -1.f);
        [_credits sizeToFit];
    }
    return _credits;
}

- (UILabel *)thankYou {
    if (!_thankYou) {
        _thankYou = [UILabel label];
        _thankYou.text = NSLocalizedStringFromTable(@"thank_you", @"game_over", nil);
        _thankYou.backgroundColor = [UIColor clearColor];
        _thankYou.font = [UIFont guessItCreditsThankYouFont];
        _thankYou.textColor = self.ui.textColor;
        _thankYou.shadowColor = self.ui.shadowColor;
        _thankYou.shadowOffset = CGSizeMake(0.f, -1.f);
        [_thankYou sizeToFit];
    }
    return _thankYou;
}

#pragma mark - UIView Methods

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

    self.credits.center = CGPointMake(center.x, 40.f);
    self.thankYou.center = CGPointMake(center.x, self.height - self.thankYou.height);

    for (NSInteger i = 0; i < self.roleLabels.count; i++) {
        UILabel *roleLabel = self.roleLabels[i];
        UILabel *personLabel = self.personLabels[i];

        CGFloat y = 75.f + (17.f * i);

        roleLabel.frame = CGRectMake(0.f, y + 3.f, 142.f, roleLabel.height);
        personLabel.frame = CGRectMake(145.f, y, self.width - 145.f, personLabel.height);
    }
}

#pragma mark - Private Interface

- (void)_initialize {
    self.backgroundColor = self.ui.backgroundColor;

    [self addSubview:self.credits];
    [self addSubview:self.thankYou];

    self.roleLabels = [NSMutableArray array];
    self.personLabels = [NSMutableArray array];

    NSArray *sortedKeys = [self.peopleToThank.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];

    NSArray *cats = @[@"lion", @"cheetara"];
    for (NSString *role in sortedKeys) {
        NSArray *persons = [self.peopleToThank objectForKey:role];
        for (NSString *person in persons) {
            UILabel *roleLabel = [UILabel label];
            roleLabel.backgroundColor = [UIColor clearColor];
            roleLabel.textColor = [self.ui.secondaryTextColor colorWithAlphaComponent:0.8f];
            roleLabel.textAlignment = NSTextAlignmentRight;
            roleLabel.font = [UIFont guessItCreditsRoleFont];
            roleLabel.text = NSLocalizedStringFromTable([role substringFromIndex:2], @"game_over", nil);
            [roleLabel sizeToFit];

            UILabel *personLabel = [UILabel label];
            personLabel.backgroundColor = [UIColor clearColor];
            personLabel.textColor = self.ui.secondaryTextColor;
            personLabel.font = [UIFont guessItCreditsPersonFont];
            personLabel.text = [NSLocalizedStringFromTable(person, @"game_over", nil) uppercaseString];
            [personLabel sizeToFit];

            if ([cats containsObject:person]) {
                personLabel.userInteractionEnabled = YES;
                id tap = [UITapGestureRecognizer gestureRecognizerWithTarget:self
                                                                      action:@selector(_catSoundEasterEgg:)];
                [personLabel addGestureRecognizer:tap];
            }

            [self.roleLabels addObject:roleLabel];
            [self.personLabels addObject:personLabel];

            [self addSubview:roleLabel];
            [self addSubview:personLabel];
        }
    }
}

- (void)_catSoundEasterEgg:(UIGestureRecognizer *)gestureRecognizer {
    [[GIConfiguration sharedInstance].game.sound playCatEasterEggSound];
}

@end
