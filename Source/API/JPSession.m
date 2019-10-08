//
//  JPSession.m
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

#import "JPSession.h"
#import "Functions.h"
#import "JPPagination.h"
#import "JPResponse.h"
#import "JPTransactionData.h"
#import "JudoKit.h"
#import "NSError+Judo.h"
#import <TrustKit/TrustKit.h>

static NSString *const JPAPIVersion = @"5.6.0";
static NSString *const JPContentTypeJSON = @"application/json";
static NSString *const JPJudoSDK = @"Judo-SDK";
static NSString *const JPCustomUI = @"Custom-UI";

static NSString *const HTTPHeaderFieldContentType = @"Content-Type";
static NSString *const HTTPHeaderFieldAccept = @"Accept";
static NSString *const HTTPHeaderFieldAPIVersion = @"API-Version";
static NSString *const HTTPHeaderFieldUserAgent = @"User-Agent";
static NSString *const HTTPHeaderFieldClientMode = @"UI-Client-Mode";
static NSString *const HTTPHeaderFieldAuthorization = @"Authorization";

static NSString *const HTTPMethodGET = @"GET";
static NSString *const HTTPMethodPOST = @"POST";
static NSString *const HTTPMethodPUT = @"PUT";

@interface JPSession () <NSURLSessionDelegate>

@property (nonatomic, strong, readwrite) NSString *endpoint;
@property (nonatomic, strong, readwrite) NSString *authorizationHeader;
@property (nonatomic, strong, readwrite) TrustKit *trustKit;

@end

@implementation JPSession

- (instancetype)init {
    self = [super init];

    if (!self)
        return self;

    NSDictionary *trustKitConfig =
        @{
            kTSKPinnedDomains : @{
                @"judopay-sandbox.com" : @{
                    kTSKPublicKeyHashes : @[
                        @"mpCgFwbYmjH0jpQ3EruXVo+/S73NOAtPeqtGJE8OdZ0=",
                        @"SRjoMmxuXogV8jKdDUKPgRrk9YihOLsrx7ila3iDns4="
                    ],
                    kTSKIncludeSubdomains : @YES
                },
                @"gw1.judopay.com" : @{
                    kTSKPublicKeyHashes : @[
                        @"SuY75QgkSNBlMtHNPeW9AayE7KNDAypMBHlJH9GEhXs=",
                        @"c4zbAoMygSbepJKqU3322FvFv5unm+TWZROW3FHU1o8=",
                    ],
                    kTSKIncludeSubdomains : @YES
                }
            }
        };

    self.trustKit = [[TrustKit alloc] initWithConfiguration:trustKitConfig];

    return self;
}

#pragma mark - REST API

- (void)apiCall:(NSString *)HTTPMethod
           path:(NSString *)path
     parameters:(NSDictionary *)parameters
     completion:(JudoCompletionBlock)completion {

    NSMutableURLRequest *request = [self judoRequest:[NSString stringWithFormat:@"%@%@", self.endpoint, path]];

    request.HTTPMethod = HTTPMethod;

    if (parameters) {
        NSError *error = nil;
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:parameters
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
    }

    NSURLSessionDataTask *task = [self task:request completion:completion];

    [task resume];
}

- (void)POST:(NSString *)path parameters:(NSDictionary *)parameters completion:(JudoCompletionBlock)completion {
    [self apiCall:HTTPMethodPOST path:path parameters:parameters completion:completion];
}

- (void)PUT:(NSString *)path parameters:(NSDictionary *)parameters completion:(JudoCompletionBlock)completion {
    [self apiCall:HTTPMethodPUT path:path parameters:parameters completion:completion];
}

- (void)GET:(NSString *)path parameters:(NSDictionary *)parameters completion:(JudoCompletionBlock)completion {
    [self apiCall:HTTPMethodGET path:path parameters:parameters completion:completion];
}

- (NSMutableURLRequest *)judoRequest:(NSString *)url {
    // create request and configure headers
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request addValue:JPContentTypeJSON forHTTPHeaderField:HTTPHeaderFieldContentType];
    [request addValue:JPContentTypeJSON forHTTPHeaderField:HTTPHeaderFieldAccept];
    [request addValue:JPAPIVersion forHTTPHeaderField:HTTPHeaderFieldAPIVersion];

    // Adds the version and lang of the SDK to the header
    [request addValue:getUserAgent() forHTTPHeaderField:HTTPHeaderFieldUserAgent];
    NSString *uiClientModeString = JPJudoSDK;

    if (self.uiClientMode) {
        uiClientModeString = JPCustomUI;
    }

    [request addValue:uiClientModeString forHTTPHeaderField:HTTPHeaderFieldClientMode];

    // Check if token and secret have been set
    NSAssert(self.authorizationHeader, @"token and secret not set");

    // Set auth header
    [request addValue:self.authorizationHeader forHTTPHeaderField:HTTPHeaderFieldAuthorization];
    return request;
}

- (NSURLSessionDataTask *)task:(NSURLRequest *)request completion:(JudoCompletionBlock)completion { //!OCLINT

    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];

    return [urlSession dataTaskWithRequest:request
                         completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
                             if (!completion) {
                                 return;
                             }
                             // check if an error occurred
                             if (error || !data) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     completion(nil, error ? error : [NSError judoRequestFailedError]);
                                 });
                                 return;
                             }

                             // serialize json
                             __block NSError *jsonError = nil;

                             NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                                          options:NSJSONReadingAllowFragments
                                                                                            error:&jsonError];

                             if (jsonError || !responseJSON) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     if (!jsonError) {
                                         jsonError = [NSError judoJSONSerializationFailedWithError:jsonError];
                                     }
                                     completion(nil, jsonError);
                                 });
                                 return;
                             }

                             // check if API Error was returned
                             if (responseJSON[@"code"]) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     completion(nil, [NSError judoErrorFromDictionary:responseJSON]);
                                 });
                                 return;
                             }

                             // check if 3DS was requested
                             if (responseJSON[@"acsUrl"] && responseJSON[@"paReq"]) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     completion(nil, [NSError judo3DSRequestWithPayload:responseJSON]);
                                 });
                                 return;
                             }

                             JPPagination *pagination = nil;

                             if (responseJSON[@"offset"] && responseJSON[@"pageSize"] && responseJSON[@"sort"]) {
                                 pagination = [JPPagination paginationWithOffset:responseJSON[@"offset"]
                                                                        pageSize:responseJSON[@"pageSize"]
                                                                            sort:responseJSON[@"sort"]];
                             }

                             JPResponse *result = [[JPResponse alloc] initWithPagination:pagination];

                             if (responseJSON[@"results"]) {
                                 [result appendItems:responseJSON[@"results"]];
                             } else {
                                 [result appendItem:responseJSON];
                             }

                             dispatch_async(dispatch_get_main_queue(), ^{
                                 if (result.items.count == 1 && result.items.firstObject.result != TransactionResultSuccess) {
                                     completion(nil, [NSError judoErrorFromTransactionData:result.items.firstObject]);
                                 } else {
                                     completion(result, nil);
                                 }
                             });
                         }];
}

#pragma mark - URLSession SSL pinning

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *_Nullable))completionHandler {
    TSKPinningValidator *pinningValidator = [self.trustKit pinningValidator];
    // Pass the authentication challenge to the validator; if the validation fails, the connection will be blocked
    if (![pinningValidator handleChallenge:challenge completionHandler:completionHandler]) {
        // TrustKit did not handle this challenge: perhaps it was not for server trust
        // or the domain was not pinned. Fall back to the default behavior
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

#pragma mark - getters and setters

- (NSString *)endpoint {
    if (self.sandboxed) {
        return @"https://gw1.judopay-sandbox.com/";
    }

    return @"https://gw1.judopay.com/";
}

@end
