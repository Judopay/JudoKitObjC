//
//  PBBAService.h
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

#import <Foundation/Foundation.h>
#import "JPSession.h"

@class JPAmount, JPReference, JPSession;

@interface PBBAService : NSObject

/**
 * Creates an instance of an PBBAService object
 *
 * @param judoId           The Judo ID of the merchant to receive the iDeal transaction
 * @param amount           The amount provided by the merchant
 * @param reference    Holds consumer and payment reference and a meta data dictionary which can hold any kind of JSON formatted information up to 1024 characters
 * @param session         An instance of JPSession that is used to make API requests
 * @param paymentMetadata                       Freeformat optional JSON metadata
 */
- (nonnull instancetype)initWithJudoId:(nonnull NSString *)judoId
                                amount:(nonnull JPAmount *)amount
                             reference:(nonnull JPReference *)reference
                               session:(nonnull JPSession *)session
                       paymentMetadata:(nullable NSDictionary *)paymentMetadata;

/**
 * Method used for returning a redirect URL based on the specified PBBA parameters
 *
 * @param completion  A completion block that either returns the redirect URL string or returns an error
 */
- (void)redirectURLWithCompletion:(nonnull JudoCompletionBlock)completion;

@end

