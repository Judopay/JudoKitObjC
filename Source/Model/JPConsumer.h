//
//  JPConsumer.h
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

/**
 *  Consumer stores information about a reference and a consumer token to be used in any kind of token transaction.
 */
@interface JPConsumer : NSObject

/**
 *  Our unique reference for this Consumer. Used in conjunction with the card token in repeat transactions.
 */
@property (nonatomic, strong) NSString *_Nonnull consumerToken;

/**
 *  Your reference for this Consumer as you sent in your request.
 */
@property (nonatomic, strong) NSString *_Nonnull consumerReference;

/**
 *  Designated initializer
 *
 *  @param dictionary the consumer dictionary which was return from the judo REST API
 *
 *  @return a JPConsumer object
 */
- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
