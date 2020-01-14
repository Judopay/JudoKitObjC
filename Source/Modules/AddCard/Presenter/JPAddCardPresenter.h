//
//  JPAddCardPresenter.h
//  JudoKitObjC
//
//  Copyright (c) 2019 Alternative Payments Ltd
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

#import "JPAddCardViewModel.h"
#import <Foundation/Foundation.h>

@protocol JPAddCardView, JPAddCardRouter, JPAddCardInteractor;

@protocol JPAddCardPresenter

/**
 * A method that is called when the view initially loads to prepare the initial view model
 */
- (void)prepareInitialViewModel;

/**
 * A method that updates the view model whenever a input field value changes
 */
- (void)handleInputChange:(NSString *)input forType:(JPInputType)type;

/**
 * A method that handles Add Card button tap
 */
- (void)handleAddCardButtonTap;

@end

@interface JPAddCardPresenterImpl : NSObject <JPAddCardPresenter>

/**
 * A weak reference to the view that adops the  JPAddCardView protocol
 */
@property (nonatomic, weak) id<JPAddCardView> view;

/**
 * A strong reference to the router that adops the  JPAddCardRouter protocol
 */
@property (nonatomic, strong) id<JPAddCardRouter> router;

/**
 * A strong reference to the interactor that adops the  JPAddCardInteractor protocol
 */
@property (nonatomic, strong) id<JPAddCardInteractor> interactor;

@end
