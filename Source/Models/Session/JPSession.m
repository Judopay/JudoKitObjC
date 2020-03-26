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
#import "JPReachability.h"
#import "JPResponse.h"
#import "JPTransactionData.h"
#import "JudoKit.h"
#import "NSError+Additions.h"

#import <TrustKit/TrustKit.h>

@interface JPSession () <NSURLSessionDelegate>

@property (nonatomic, strong, readwrite) NSString *authorizationHeader;
@property (nonatomic, strong, readwrite) TrustKit *trustKit;
@property (nonatomic, strong, readwrite) JPReachability *reachability;

@end

@implementation JPSession

#pragma mark - Constants

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

static NSString *const kJudoBaseURL = @"https://api.judopay.com/";
static NSString *const kJudoSandboxBaseURL = @"https://api-sandbox.judopay.com/";

#pragma mark - Initializers

+ (instancetype)sessionWithAuthorizationHeader:(NSString *)header {
    return [[JPSession alloc] initWithAuthorizationHeader:header];
}

- (instancetype)initWithAuthorizationHeader:(NSString *)header {
    if (self = [super init]) {
        [self setupTrustKit];
        [self setupReachability];
        self.authorizationHeader = header;
    }
    return self;
}

#pragma mark - Setup methods

- (void)setupTrustKit {
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
}

- (void)setupReachability {
    NSURL *requestURL = [NSURL URLWithString:self.baseURL];
    self.reachability = [JPReachability reachabilityWithURL:requestURL];
}

#pragma mark - REST API methods

- (void)POST:(NSString *)path parameters:(NSDictionary *)parameters completion:(JudoCompletionBlock)completion {
    [self apiCall:HTTPMethodPOST path:path parameters:parameters completion:completion];
}

- (void)PUT:(NSString *)path parameters:(NSDictionary *)parameters completion:(JudoCompletionBlock)completion {
    [self apiCall:HTTPMethodPUT path:path parameters:parameters completion:completion];
}

- (void)GET:(NSString *)path parameters:(NSDictionary *)parameters completion:(JudoCompletionBlock)completion {
    [self apiCall:HTTPMethodGET path:path parameters:parameters completion:completion];
}

- (void)apiCall:(NSString *)HTTPMethod
           path:(NSString *)path
     parameters:(NSDictionary *)parameters
     completion:(JudoCompletionBlock)completion {

    if ([self.reachability isReachable]) {
        [self performRequestWithMethod:HTTPMethod
                                  path:path
                            parameters:parameters
                            completion:completion];
    } else {
        completion(nil, NSError.judoInternetConnectionError);
    }
}

- (void)performRequestWithMethod:(NSString *)HTTPMethod
                            path:(NSString *)path
                      parameters:(NSDictionary *)parameters
                      completion:(JudoCompletionBlock)completion {

    NSMutableURLRequest *request = [self judoRequest:path];
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

- (NSMutableURLRequest *)judoRequest:(NSString *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request addValue:JPContentTypeJSON forHTTPHeaderField:HTTPHeaderFieldContentType];
    [request addValue:JPContentTypeJSON forHTTPHeaderField:HTTPHeaderFieldAccept];
    [request addValue:JPAPIVersion forHTTPHeaderField:HTTPHeaderFieldAPIVersion];

    [request addValue:getUserAgent() forHTTPHeaderField:HTTPHeaderFieldUserAgent];
    NSString *uiClientModeString = JPJudoSDK;

    if (self.uiClientMode) {
        uiClientModeString = JPCustomUI;
    }

    [request addValue:uiClientModeString forHTTPHeaderField:HTTPHeaderFieldClientMode];
    NSAssert(self.authorizationHeader, @"token and secret not set");

    [request addValue:self.authorizationHeader forHTTPHeaderField:HTTPHeaderFieldAuthorization];
    return request;
}

- (NSURLSessionDataTask *)task:(NSURLRequest *)request
                    completion:(JudoCompletionBlock)completion {

    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfig
                                                             delegate:self
                                                        delegateQueue:nil];

    return [urlSession dataTaskWithRequest:request
                         completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
                             if (!completion) {
                                 return;
                             }

                             if (error || !data) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     completion(nil, error ? error : NSError.judoRequestFailedError);
                                 });
                                 return;
                             }

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

                             if (responseJSON[@"code"]) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     completion(nil, [NSError judoErrorFromDictionary:responseJSON]);
                                 });
                                 return;
                             }

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
                                 if (result.items.count == 1 && responseJSON[@"result"] != nil && result.items.firstObject.result != TransactionResultSuccess) {
                                     completion(nil, [NSError judoErrorFromTransactionData:result.items.firstObject]);
                                 } else {
                                     completion(result, nil);
                                 }
                             });
                         }];
}

#pragma mark - URLSession SSL pinning

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *_Nullable))completionHandler {
    TSKPinningValidator *pinningValidator = self.trustKit.pinningValidator;
    if (![pinningValidator handleChallenge:challenge completionHandler:completionHandler]) {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }

    [session finishTasksAndInvalidate];
}

#pragma mark - Getters

- (NSString *)baseURL {
    if (self.sandboxed) {
        return kJudoSandboxBaseURL;
    }

    return kJudoBaseURL;
}

@end
