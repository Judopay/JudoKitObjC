//
//  NSError+Judo.m
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

#import "NSError+Judo.h"
#import "JPTransactionData.h"

NSString * const JudoErrorDomain = @"com.judo.error";

NSString * const UnableToProcessRequestErrorDesc = @"Sorry, we're currently unable to process this request.";
NSString * const UnableToProcessRequestErrorTitle = @"Unable to process";

NSString * const JPErrorTitleKey = @"JPErrorTitleKey";

NSString * const ErrorRequestFailed = @"The request responded without data";
NSString * const ErrorPaymentMethodMissing = @"The payment method (card details, token or PKPayment) has not been set for a transaction that requires it (custom UI)";
NSString * const ErrorAmountMissing = @"The amount has not been set for a transaction that requires it (custom UI)";
NSString * const ErrorReferenceMissing = @"The reference has not been set for a transaction that requires it (custom UI)";
NSString * const ErrorResponseParseError = @"An error with a response from the backend API";
NSString * const ErrorUserDidCancel = @"Received when user cancels the payment journey";
NSString * const ErrorParameterError = @"A parameter entered into the dictionary (request body to Judo API) is not set";
NSString * const ErrorFailed3DSRequest = @"After receiving the 3DS payload, when the payload has faulty data, the WebView fails to load the 3DS Page or the resolution page";
NSString * const ErrorJailbrokenDeviceDisallowed = @"The device the code is currently running is jailbroken. Jailbroken devices are not allowed when instantiating a new Judo session";

NSString * const Error3DSRequest = @"Error when routing to 3DS";
NSString * const ErrorUnderlyingError = @"An error in the iOS system with an enclosed underlying error";
NSString * const ErrorTransactionDeclined = @"A transaction that was sent to the backend returned declined";

@implementation NSError (Judo)

+ (NSError *)judoJailbrokenDeviceDisallowedError {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorJailbrokenDeviceDisallowed userInfo:[self userDataDictWithDescription:UnableToProcessRequestErrorDesc failureReason:ErrorJailbrokenDeviceDisallowed title:UnableToProcessRequestErrorTitle]];
}

+ (NSError *)judoRequestFailedError {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorRequestFailed userInfo:[self userDataDictWithDescription:UnableToProcessRequestErrorDesc failureReason:ErrorRequestFailed title:UnableToProcessRequestErrorTitle]];
}

+ (NSError *)judoJSONSerializationFailedWithError:(nullable NSError *)error {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorJSONSerializationFailed userInfo:@{NSUnderlyingErrorKey:error}];
}

+ (NSError *)judoJudoIdMissingError {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorJudoIdMissing userInfo:@{}];
}

+ (NSError *)judoAmountMissingError {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorAmountMissing userInfo:[self userDataDictWithDescription:UnableToProcessRequestErrorDesc failureReason:ErrorAmountMissing title:UnableToProcessRequestErrorTitle]];
}

+ (NSError *)judoPaymentMethodMissingError {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorPaymentMethodMissing userInfo:[self userDataDictWithDescription:UnableToProcessRequestErrorDesc failureReason:ErrorPaymentMethodMissing title:UnableToProcessRequestErrorTitle]];
}

+ (NSError *)judoReferenceMissingError {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorReferenceMissing userInfo:[self userDataDictWithDescription:UnableToProcessRequestErrorDesc failureReason:ErrorReferenceMissing title:UnableToProcessRequestErrorTitle]];
}

+ (NSError *)judoDuplicateTransactionError {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorDuplicateTransaction userInfo:@{}];
}

+ (NSError *)judo3DSRequestFailedErrorWithUnderlyingError:(NSError *)underlyingError {
    if (underlyingError) {
        return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorFailed3DSRequest userInfo:[self userDataDictWithDescription:UnableToProcessRequestErrorDesc failureReason:ErrorFailed3DSRequest title:UnableToProcessRequestErrorTitle currentDict:@{NSUnderlyingErrorKey:underlyingError}]];
    }
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorFailed3DSRequest userInfo:[self userDataDictWithDescription:UnableToProcessRequestErrorDesc failureReason:ErrorFailed3DSRequest title:UnableToProcessRequestErrorTitle]];
}

+ (NSError *)judoErrorFromTransactionData:(JPTransactionData *)data {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorTransactionDeclined userInfo:data.rawData];
}

+ (NSError *)judoErrorFromDictionary:(NSDictionary *)dict {
    NSString *messageFromDict = dict[@"message"];
    NSString *errorMessage = messageFromDict == nil ? UnableToProcessRequestErrorDesc : messageFromDict;
    return [NSError errorWithDomain:JudoErrorDomain code:[dict[@"code"] integerValue] userInfo:[self userDataDictWithDescription:errorMessage failureReason:nil title:UnableToProcessRequestErrorTitle currentDict:dict]];
}

+ (NSError *)judoErrorFromError:(NSError *)error {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorUnderlyingError userInfo:@{NSUnderlyingErrorKey:error}];
}

+ (NSError *)judoUserDidCancelError {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorUserDidCancel userInfo:[self userDataDictWithDescription:nil failureReason:ErrorUserDidCancel title:nil]];
}

+ (NSError *)judoParameterError {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorParameterError userInfo:[self userDataDictWithDescription:UnableToProcessRequestErrorDesc failureReason:ErrorParameterError title:UnableToProcessRequestErrorTitle]];
}

+ (NSError *)judoInvalidCardNumberError {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorInvalidCardNumberError userInfo:@{NSLocalizedDescriptionKey:@"Check card number"}];
}

+ (NSError *)judoResponseParseError {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorResponseParseError userInfo:[self userDataDictWithDescription:UnableToProcessRequestErrorDesc failureReason:ErrorResponseParseError title:UnableToProcessRequestErrorTitle]];
}

+ (NSError *)judo3DSRequestWithPayload:(NSDictionary *)payload {
    return [NSError errorWithDomain:JudoErrorDomain code:JudoError3DSRequest userInfo:payload];
}

+ (NSError *)judoInputMismatchErrorWithMessage:(NSString *)message {
    if (message) {
        return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorInputMismatchError userInfo:@{NSLocalizedDescriptionKey:message}];
    }
    
    return [NSError errorWithDomain:JudoErrorDomain code:JudoErrorInputMismatchError userInfo:nil];
}

+ (NSDictionary *)userDataDictWithDescription:(NSString*)description failureReason:(NSString*)failureReason title:(NSString*)title{
    NSDictionary *newDict = [NSDictionary new];
    return [self userDataDictWithDescription:description failureReason:failureReason title:title currentDict:newDict];
}

+ (NSDictionary *)userDataDictWithDescription:(NSString *)description failureReason:(NSString *)failureReason title:(NSString*)title currentDict:(NSDictionary *)currentDict {
    NSMutableDictionary *mutableDict = [currentDict mutableCopy];
    if (description) {
        mutableDict[NSLocalizedDescriptionKey] = description;
    }
    if (failureReason) {
        mutableDict[NSLocalizedFailureReasonErrorKey] = failureReason;
    }
    
    if(title)
    {
        mutableDict[JPErrorTitleKey] = title;
    }
    
    return [mutableDict copy];
}

@end
