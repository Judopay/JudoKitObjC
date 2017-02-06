//
//  JudoWallet.m
//  JudoKitObjC
//
//  Copyright (c) 2016 Alternative Payments Ltd
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JudoWallet.h"
#import "JPSession.h"
#import "JudoWalletManagementViewController.h"

@interface JudoWallet()

@property (nonnull, nonatomic, strong) JudoKit *judoKit;

@end

@implementation JudoWallet

- (nonnull instancetype)initWithToken:(nonnull NSString *)token secret:(nonnull NSString *)secret {
    JudoKit *judoKit = [[JudoKit alloc] initWithToken:token secret:secret];
    return [self initWithJudoKit:judoKit];
}

- (nonnull instancetype)initWithJudoKit:(nonnull JudoKit *)judoKit {
    self = [super init];
    
    if (self) {
        self.judoKit = judoKit;
    }
    
    return self;
}

- (void)manage {
    JudoWalletManagementViewController *vc = [JudoWalletManagementViewController new];
    [self initiateAndShow:vc];
}

- (void)payment {

}

- (void)nonPresentPayment {

}

- (void)isSandboxed:(BOOL)sandboxed {
    self.judoKit.apiSession.sandboxed = sandboxed;
}

- (void)setTheme:(nonnull JPTheme *)theme {
    self.judoKit.theme = theme;
}

- (void)initiateAndShow:(JudoWalletManagementViewController *)viewController {
    //viewController.theme = self.theme;
    //self.activeViewController = viewController;
    [self showViewController:[[UINavigationController alloc] initWithRootViewController:viewController]];
}

- (void)showViewController:(UIViewController *)vc {
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    while (rootViewController.presentedViewController) {
        rootViewController = rootViewController.presentedViewController;
        
        if ([rootViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = (UINavigationController *) rootViewController;
            rootViewController = navigationController.viewControllers.lastObject;
        }
        
        if ([rootViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabBarController = (UITabBarController *) rootViewController;
            rootViewController = tabBarController.selectedViewController;
        }
    }
    
    [rootViewController presentViewController:vc animated:YES completion:nil];
}

@end
