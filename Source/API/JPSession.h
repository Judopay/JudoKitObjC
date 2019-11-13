//
//  JPSession.h
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

#import <Foundation/Foundation.h>

@class JPResponse;

typedef void (^JudoCompletionBlock)(JPResponse *_Nullable, NSError *_Nullable);

/**
 *  The Session class is a wrapper for all REST API calls
 */
@interface JPSession : NSObject

/**
 *  The endpoint for REST API calls to the judo API
 */
@property (nonatomic, strong, readonly) NSString *_Nonnull endpoint;

/**
 *  Token and secret are saved in the authorizationHeader for authentication of REST API calls
 */
@property (nonatomic, strong, readonly) NSString *_Nullable authorizationHeader;

/**
 *  identifying whether developers are using their own UI or the Judo Out of the box UI
 */
@property (nonatomic, assign) BOOL uiClientMode;

/**
 *  Set the app to sandboxed mode
 */
@property (nonatomic, assign) BOOL sandboxed;

/**
 *  POST Helper Method for accessing the judo REST API
 *
 *  @param path       the path
 *  @param parameters information that is set in the HTTP Body
 *  @param completion completion callblack block with the results
 */
- (void)POST:(nonnull NSString *)path parameters:(nullable NSDictionary *)parameters completion:(nonnull JudoCompletionBlock)completion;

/**
 *  PUT Helper Method for accessing the judo REST API - PUT should only be accessed for 3DS transactions to fulfill the transaction
 *
 *  @param path       the path
 *  @param parameters information that is set in the HTTP Body
 *  @param completion completion callblack block with the results
 */
- (void)PUT:(nonnull NSString *)path parameters:(nullable NSDictionary *)parameters completion:(nonnull JudoCompletionBlock)completion;

/**
 *  GET Helper Method for accessing the judo REST API
 *
 *  @param path       the path
 *  @param parameters information that is set in the HTTP Body
 *  @param completion completion callblack block with the results
 */
- (void)GET:(nonnull NSString *)path parameters:(nullable NSDictionary *)parameters completion:(nonnull JudoCompletionBlock)completion;

@end
