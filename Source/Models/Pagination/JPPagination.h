//
//  JPPagination.h
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
 *  class to save state of a paginated response
 */
@interface JPPagination : NSObject

/**
 *  "time-descending" or "time-ascending"
 */
@property (nonatomic, strong, readonly) NSString *_Nonnull sort;

/**
 *  the page size of the paginated response
 */
@property (nonatomic, assign, readonly) NSUInteger pageSize;

/**
 *  the offset of the paginated response
 */
@property (nonatomic, assign, readonly) NSUInteger offset;

/**
 *  convenient initializer for a JPPagination object
 *
 *  @param offset   the offset
 *  @param pageSize the pagesize
 *  @param sort     the sorting
 *
 *  @return a instance of JPPagination with the given parameters
 */
+ (nonnull instancetype)paginationWithOffset:(NSNumber *_Nonnull)offset pageSize:(NSNumber *_Nonnull)pageSize sort:(NSString *_Nonnull)sort;

@end
