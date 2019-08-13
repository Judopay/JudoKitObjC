//
//  ApplePayButtonViewController.h
//  JudoKitObjCExampleApp
//
//  Created by Gheorghe Cojocaru on 8/13/19.
//  Copyright © 2019 Judo Payments. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JudoKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplePayButtonViewController : UIViewController
- (instancetype _Nonnull)initWithCurrentSession:(nonnull JudoKit *)session;

@end

NS_ASSUME_NONNULL_END
