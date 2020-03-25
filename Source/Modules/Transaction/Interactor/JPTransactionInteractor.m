//
//  JPTransactionInteractor.m
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

#import "JPTransactionInteractor.h"
#import "JP3DSService.h"
#import "JPCard.h"
#import "JPCardStorage.h"
#import "JPCardValidationService.h"
#import "JPCountry.h"
#import "JPKeychainService.h"
#import "JPReference.h"
#import "JPSession.h"
#import "JPStoredCardDetails.h"
#import "JPTransactionService.h"
#import "JPTransactionViewModel.h"
#import "NSError+Additions.h"
#import "NSString+Additions.h"

@interface JPTransactionInteractorImpl ()
@property (nonatomic, strong) JudoCompletionBlock completionHandler;
@property (nonatomic, strong) JPCardValidationService *cardValidationService;
@property (nonatomic, strong) JPConfiguration *configuration;
@property (nonatomic, strong) JPTransactionService *transactionService;
@property (nonatomic, strong) JP3DSService *threeDSecureService;
@end

@implementation JPTransactionInteractorImpl

#pragma mark - Initializers

- (instancetype)initWithCardValidationService:(JPCardValidationService *)cardValidationService
                           transactionService:(JPTransactionService *)transactionService
                                configuration:(JPConfiguration *)configuration
                                   completion:(JudoCompletionBlock)completion {

    if (self = [super init]) {
        self.cardValidationService = cardValidationService;
        self.transactionService = transactionService;
        self.configuration = configuration;
        self.completionHandler = completion;
    }
    return self;
}

#pragma mark - Interactor Protocol Methods

- (BOOL)isAVSEnabled {
    return self.configuration.uiConfiguration.isAVSEnabled;
}

- (TransactionType)transactionType {
    return self.transactionService.transactionType;
}

- (JPAddress *)getConfiguredCardAddress {
    return self.configuration.cardAddress.copy;
}

- (void)handleCameraPermissionsWithCompletion:(void (^)(AVAuthorizationStatus))completion {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                 completionHandler:^(BOOL granted) {
                                     completion(granted ? AVAuthorizationStatusAuthorized : AVAuthorizationStatusDenied);
                                 }];
    } else {
        completion(status);
    }
}

- (void)sendTransactionWithCard:(JPCard *)card
              completionHandler:(JudoCompletionBlock)completionHandler {

#if DEBUG
    // TODO: Temporary duplicate transaction solution
    // Generates a new consumer reference for each Payment/PreAuth transaction

    BOOL isPayment = (self.transactionService.transactionType == TransactionTypePayment);
    BOOL isPreAuth = (self.transactionService.transactionType == TransactionTypePreAuth);

    if (isPayment || isPreAuth) {
        self.configuration.reference = [JPReference consumerReference:NSUUID.UUID.UUIDString];
    }
#endif

    JPTransaction *transaction = [self.transactionService transactionWithConfiguration:self.configuration];
    transaction.card = card;

    self.threeDSecureService.transaction = transaction;
    [transaction sendWithCompletion:completionHandler];
}

- (void)completeTransactionWithResponse:(JPResponse *)response error:(NSError *)error {
    if (self.completionHandler)
        self.completionHandler(response, error);
}

- (void)updateKeychainWithCardModel:(JPTransactionViewModel *)viewModel andToken:(NSString *)token {

    CardNetwork cardNetwork = viewModel.cardNumberViewModel.cardNetwork;
    NSString *cardNumberString = viewModel.cardNumberViewModel.text;

    NSString *lastFour = [cardNumberString substringFromIndex:cardNumberString.length - 4];
    NSString *expiryDate = viewModel.expiryDateViewModel.text;

    JPStoredCardDetails *storedCardDetails = [JPStoredCardDetails cardDetailsWithLastFour:lastFour
                                                                               expiryDate:expiryDate
                                                                              cardNetwork:cardNetwork
                                                                                cardToken:token];
    storedCardDetails.cardTitle = [self defaultCardTitleForCardNetwork:cardNetwork];
    storedCardDetails.patternType = JPCardPattern.random.type;
    [JPCardStorage.sharedInstance addCardDetails:storedCardDetails];
}

- (NSString *)defaultCardTitleForCardNetwork:(CardNetwork)network {
    switch (network) {
        case CardNetworkVisa:
            return @"default_visa_card_title".localized;

        case CardNetworkAMEX:
            return @"default_amex_card_title".localized;

        case CardNetworkMaestro:
            return @"default_maestro_card_title".localized;

        case CardNetworkMasterCard:
            return @"default_mastercard_card_title".localized;

        case CardNetworkChinaUnionPay:
            return @"default_chinaunionpay_card_title".localized;

        case CardNetworkJCB:
            return @"default_jcb_card_title".localized;

        case CardNetworkDiscover:
            return @"default_discover_card_title".localized;

        case CardNetworkDinersClub:
            return @"default_dinnersclub_card_title".localized;

        default:
            return @"";
    }
}

- (void)resetCardValidationResults {
    [self.cardValidationService resetCardValidationResults];
}

- (void)handle3DSecureTransactionFromError:(NSError *)error
                                completion:(JudoCompletionBlock)completion {
    [self.threeDSecureService invoke3DSecureViewControllerWithError:error
                                                         completion:completion];
}

- (NSArray<NSString *> *)getSelectableCountryNames {
    return @[
        [JPCountry countryWithType:JPCountryTypeUK].name,
        [JPCountry countryWithType:JPCountryTypeUSA].name,
        [JPCountry countryWithType:JPCountryTypeCanada].name,
        [JPCountry countryWithType:JPCountryTypeOther].name,
    ];
}

- (JPValidationResult *)validateCardNumberInput:(NSString *)input {
    return [self.cardValidationService validateCardNumberInput:input
                                          forSupportedNetworks:self.supportedNetworks];
}

- (JPValidationResult *)validateCardholderNameInput:(NSString *)input {
    return [self.cardValidationService validateCarholderNameInput:input];
}

- (JPValidationResult *)validateExpiryDateInput:(NSString *)input {
    return [self.cardValidationService validateExpiryDateInput:input];
}

- (JPValidationResult *)validateSecureCodeInput:(NSString *)input {
    return [self.cardValidationService validateSecureCodeInput:input];
}

- (JPValidationResult *)validateCountryInput:(NSString *)input {
    return [self.cardValidationService validateCountryInput:input];
}

- (JPValidationResult *)validatePostalCodeInput:(NSString *)input {
    return [self.cardValidationService validatePostalCodeInput:input];
}

- (JP3DSService *)threeDSecureService {
    if (!_threeDSecureService) {
        _threeDSecureService = [JP3DSService new];
    }
    return _threeDSecureService;
}

- (CardNetwork)supportedNetworks {
    if (self.configuration.supportedCardNetworks) {
        return self.configuration.supportedCardNetworks;
    }
    return CardNetworkVisa | CardNetworkAMEX | CardNetworkMaestro | CardNetworkMasterCard;
}

@end
