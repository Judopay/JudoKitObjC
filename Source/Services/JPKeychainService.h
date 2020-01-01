//
//  JPKeychainService.h
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

@interface JPKeychainService : NSObject

/**
 * A method that saves an object to the keychain with a specific key
 *
 * @param key - a NSString value that identifies the object
 *
 * @returns YES if the object was saved successfully, NO otherwise
 */
+ (BOOL)saveObject:(id)object forKey:(NSString *)key;

/**
 * A method that returns an object from the keychain based on a specified key
 *
 * @param key - a NSString value that identifies the object
 *
 * @returns id - a pointer to any type
 */
+ (id)getObjectForKey:(NSString *)key;

/**
 * A method that deletes a value from the keychain based on a specified key
 *
 * @param key - a NSString value that identifies the object
 *
 * @return YES if the object was deleted successfully, NO otherwise
 */
+ (BOOL)deleteObjectForKey:(NSString *)key;

@end
