//
//  LoadingButton.m
//  JudoKitObjC
//
//  Created by Mihai Petrenco on 12/2/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import "LoadingButton.h"
#import "UIView+Constraints.h"

@interface LoadingButton ()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSString *buttonTitle;
@end

@implementation LoadingButton

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupActivityIndicator];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupActivityIndicator];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupActivityIndicator];
    }
    return self;
}

- (void)setupActivityIndicator {
    [self addSubview:self.activityIndicator];
    [self.activityIndicator pinToView:self withPadding:0.0];
}

- (void)startLoading {
    self.buttonTitle = self.titleLabel.text;
    [self setTitle:@"" forState:UIControlStateNormal];
    [self.activityIndicator startAnimating];
}

- (void)stopLoading {
    [self setTitle:self.buttonTitle forState:UIControlStateNormal];
    [self.activityIndicator stopAnimating];
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        _activityIndicator.hidesWhenStopped = YES;
    }
    return _activityIndicator;
}

@end
