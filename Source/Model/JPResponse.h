//
//  JPResponse.h
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

@class JPPagination;
@class JPTransactionData;

/**
 *   Response object is created out of the JSON response of the judo API for seamless handling of values returned in any call. The response object can hold multiple transaction objects and supports pagination if available. In most cases (successful Payment, Pre-auth, RegisterCard or SaveCard operation) a Response object will hold one TransactionData object. Supporting CollectionType protocol, you can access the elements by subscripting `let transactionData = response[0]` or using the available variable `response.first` as a more readable approach.
 */
@interface JPResponse : NSObject

/**
 *  The array that contains the transaction response objects
 */
@property (nonatomic, strong) NSArray<JPTransactionData *> *_Nullable items;

/**
 *  The current pagination response
 */
@property (nonatomic, strong) JPPagination *_Nullable pagination;

/**
 *  Initialize a Response object with pagination if available
 *
 *  @param pagination the pagination information for the response
 *
 *  @return a JPResponse object
 */
- (nonnull instancetype)initWithPagination:(nullable JPPagination *)pagination;

/**
 *  Add a array of element on to the items
 *
 *  @param items an array containing raw NSDictionary items
 */
- (void)appendItems:(nonnull NSArray *)items;

/**
 *  Add an element on to the items
 *
 *  @param item the element to add to the items Array
 */
- (void)appendItem:(nonnull NSDictionary *)item;

@end
