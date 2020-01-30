//
//  NSError+Judo.h
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

@class JPTransactionData;

NS_ASSUME_NONNULL_BEGIN

extern NSString *const JudoErrorDomain;

@interface NSError (Judo)

+ (NSError *)judoRequestFailedError;
+ (NSError *)judoJSONSerializationFailedWithError:(nullable NSError *)error;
+ (NSError *)judoJudoIdMissingError;
+ (NSError *)judoPaymentMethodMissingError;
+ (NSError *)judoAmountMissingError;
+ (NSError *)judoReferenceMissingError;
+ (NSError *)judoTokenMissingError;
+ (NSError *)judoDuplicateTransactionError;
+ (NSError *)judo3DSRequestFailedErrorWithUnderlyingError:(nullable NSError *)underlyingError;
+ (NSError *)judoUserDidCancelError;
+ (NSError *)judoParameterError;
+ (NSError *)judoInternetConnectionError;
+ (NSError *)judoApplePayConfigurationError;
+ (NSError *)judoResponseParseError;
+ (NSError *)judoMissingChecksumError;
+ (NSError *)judoRequestTimeoutError;
+ (NSError *)judoInvalidCardNumberError;
+ (NSError *)judoJailbrokenDeviceDisallowedError;
+ (NSError *)judoInputMismatchErrorWithMessage:(nullable NSString *)message;

+ (NSError *)judoErrorFromTransactionData:(JPTransactionData *)data;
+ (NSError *)judoErrorFromDictionary:(NSDictionary *)dict;
+ (NSError *)judoErrorFromError:(NSError *)error;
+ (NSError *)judo3DSRequestWithPayload:(NSDictionary *)payload;

@end

NS_ASSUME_NONNULL_END

typedef NS_ENUM(NSUInteger, JudoError) {
    JudoErrorRequestFailed,
    JudoErrorJSONSerializationFailed,
    JudoErrorJudoIdMissing,
    JudoErrorPaymentMethodMissing,
    JudoErrorAmountMissing,
    JudoErrorReferenceMissing,
    JudoErrorTokenMissing,
    JudoErrorDuplicateTransaction,
    JudoError3DSRequest,
    JudoErrorUnderlyingError,
    JudoErrorTransactionDeclined,
    JudoErrorFailed3DSRequest,
    JudoErrorInputMismatchError,
    JudoErrorUserDidCancel,
    JudoErrorParameterError,
    JudoErrorResponseParseError,
    JudoErrorInvalidApplePayConfiguration,
    JudoErrorInvalidCardNumberError,
    JudoErrorJailbrokenDeviceDisallowed,

    JudoErrorGeneral_Error = 0,
    JudoErrorGeneral_Model_Error = 1,
    JudoErrorUnauthorized = 7,
    JudoErrorPayment_System_Error = 9,
    JudoErrorPayment_Declined = 11,
    JudoErrorPayment_Failed = 12,
    JudoErrorTransaction_Not_Found = 19,
    JudoErrorValidation_Passed = 20,
    JudoErrorUncaught_Error = 21,
    JudoErrorServer_Error = 22,
    JudoErrorInvalid_From_Date = 23,
    JudoErrorInvalid_To_Date = 24,
    JudoErrorCantFindWebPayment = 25,
    JudoErrorGeneral_Error_Simple_Application = 26,
    JudoErrorInvalidApiVersion = 40,
    JudoErrorMissingApiVersion = 41,
    JudoErrorPreAuthExpired = 42,
    JudoErrorCollection_Original_Transaction_Wrong_Type = 43,
    JudoErrorCurrency_Must_Equal_Original_Transaction = 44,
    JudoErrorCannot_Collect_A_Voided_Transaction = 45,
    JudoErrorCollection_Exceeds_PreAuth = 46,
    JudoErrorRefund_Original_Transaction_Wrong_Type = 47,
    JudoErrorCannot_Refund_A_Voided_Transaction = 48,
    JudoErrorRefund_Exceeds_Original_Transaction = 49,
    JudoErrorVoid_Original_Transaction_Wrong_Type = 50,
    JudoErrorVoid_Original_Transaction_Is_Already_Void = 51,
    JudoErrorVoid_Original_Transaction_Has_Been_Collected = 52,
    JudoErrorVoid_Original_Transaction_Amount_Not_Equal_To_Preauth = 53,
    JudoErrorUnableToAccept = 54,
    JudoErrorAccountLocationNotFound = 55,
    JudoErrorAccessDeniedToTransaction = 56,
    JudoErrorNoConsumerForTransaction = 57,
    JudoErrorTransactionNotEnrolledInThreeDSecure = 58,
    JudoErrorTransactionAlreadyAuthorizedByThreeDSecure = 59,
    JudoErrorThreeDSecureNotSuccessful = 60,
    JudoErrorApUnableToDecrypt = 61,
    JudoErrorReferencedTransactionNotFound = 62,
    JudoErrorReferencedTransactionNotSuccessful = 63,
    JudoErrorTestCardNotAllowed = 64,
    JudoErrorCollection_Not_Valid = 65,
    JudoErrorRefund_Original_Transaction_Null = 66,
    JudoErrorRefund_Not_Valid = 67,
    JudoErrorVoid_Not_Valid = 68,
    JudoErrorUnknown = 69,
    JudoErrorCardTokenInvalid = 70,
    JudoErrorUnknownPaymentModel = 71,
    JudoErrorUnableToRouteTransaction = 72,
    JudoErrorCardTypeNotSupported = 73,
    JudoErrorCardCv2Invalid = 74,
    JudoErrorCardTokenDoesntMatchConsumer = 75,
    JudoErrorWebPaymentReferenceInvalid = 76,
    JudoErrorWebPaymentAccountLocationNotFound = 77,
    JudoErrorRegisterCardWithWrongTransactionType = 78,
    JudoErrorInvalidAmountToRegisterCard = 79,
    JudoErrorContentTypeNotSpecifiedOrUnsupported = 80,
    JudoErrorInternalErrorAuthenticating = 81,
    JudoErrorTransactionNotFound = 82,
    JudoErrorResourceNotFound = 83,
    JudoErrorLackOfPermissionsUnauthorized = 84,
    JudoErrorContentTypeNotSupported = 85,
    JudoErrorAuthenticationFailure = 403,
    JudoErrorNot_Found = 404,
    JudoErrorMustProcessPreAuthByToken = 4002,
    JudoErrorApplicationModelIsNull = 20000,
    JudoErrorApplicationModelRequiresReference = 20001,
    JudoErrorApplicationHasAlreadyGoneLive = 20002,
    JudoErrorMissingProductSelection = 20003,
    JudoErrorAccountNotInSandbox = 20004,
    JudoErrorApplicationRecIdRequired = 20005,
    JudoErrorRequestNotProperlyFormatted = 20006,
    JudoErrorNoApplicationReferenceFound = 20007,
    JudoErrorNotSupportedFileType = 20008,
    JudoErrorErrorWithFileUpload = 20009,
    JudoErrorEmptyApplicationReference = 20010,
    JudoErrorApplicationDoesNotExist = 20011,
    JudoErrorUnknownSortSpecified = 20013,
    JudoErrorPageSizeLessThanOne = 20014,
    JudoErrorPageSizeMoreThanFiveHundred = 20015,
    JudoErrorOffsetLessThanZero = 20016,
    JudoErrorInvalidMerchantId = 20017,
    JudoErrorMerchantIdNotFound = 20018,
    JudoErrorNoProductsWereFound = 20019,
    JudoErrorOnlyTheJudoPartnerCanSubmitSimpleApplications = 20020,
    JudoErrorUnableToParseDocument = 20021,
    JudoErrorUnableToFindADefaultAccountLocation = 20022,
    JudoErrorWebpaymentsShouldBeCreatedByPostingToUrl = 20023,
    JudoErrorInvalidMd = 20025,
    JudoErrorInvalidReceiptId = 20026,
};
