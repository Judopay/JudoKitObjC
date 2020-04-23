//
//  JPConfigurationValidationServiceTest.swift
//  JudoKitObjCTests
//
//  Copyright (c) 2020 Alternative Payments Ltd
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

import XCTest
@testable import JudoKitObjC

class JPAppleConfigurationValidationServiceTest: XCTestCase {
    var amount: JPAmount!
    var configuration: JPConfiguration!
    let consumerReference = "judoPay-sample-app"
    var configValidation: JPConfigurationValidationService!
    lazy var reference = JPReference(consumerReference: consumerReference)
    
    var applePayConfigurations: JPApplePayConfiguration {
        let items = [JPPaymentSummaryItem(label: "item 1", amount: 0.01),
                     JPPaymentSummaryItem(label: "item 2", amount: 0.02),
                     JPPaymentSummaryItem(label: "Judo Pay", amount: 0.03)]
        let configurations = JPApplePayConfiguration(merchantId: "merchantId",
                                                     currency: "EUR",
                                                     countryCode: "GB",
                                                     paymentSummaryItems: items)
        return configurations
    }
    
    override func setUp() {
        configValidation = JPConfigurationValidationServiceImp()
        amount = JPAmount("fv", currency: "GBR")
        configuration = JPConfiguration(judoID: "judoId", amount: self.amount, reference: reference)
        configuration.supportedCardNetworks = [.networkVisa, .networkMasterCard, .networkAMEX]
        configuration.applePayConfiguration = applePayConfigurations
    }
    
    func testAppleConfigIfValid() {
        let isValid = configValidation.isTransactionValid(with: configuration, validationType: .applePay, transactionType:.void, completion: nil)
        XCTAssertTrue(isValid)
    }
    
    func testAppleConfigForNil() {
        configuration.applePayConfiguration = nil
        let isValid = configValidation.isTransactionValid(with: configuration, validationType: .applePay, transactionType: .void) { (response, errror) in
            XCTAssertEqual(errror!.localizedDescription, "Apple Configuration is empty")
        }
        XCTAssertFalse(isValid)
    }
    
    func testAppleConfigForPaymentSummaryItemsEmpty() {
        configuration.applePayConfiguration?.paymentSummaryItems.removeAll()
        let isValid = configValidation.isTransactionValid(with: configuration, validationType: .applePay, transactionType: .void) { (response, errror) in
            XCTAssertEqual(errror!.localizedDescription, "Payment items couldn't be empty")
        }
        XCTAssertFalse(isValid)
    }
    
    func testAppleConfigForShipingMethods() {
        configuration.applePayConfiguration?.requiredShippingContactFields = .postalAddress
        configuration.applePayConfiguration?.shippingMethods?.removeAll()
        let isValid = configValidation.isTransactionValid(with: configuration, validationType: .applePay, transactionType: .void) { (response, errror) in
            XCTAssertEqual(errror!.localizedDescription, "Specify shipinng methonds")
        }
        XCTAssertFalse(isValid)
    }
    
    func testAppleConfigForInvalidCountryCode() {
        configuration.applePayConfiguration?.countryCode = ""
        let isValid = configValidation.isTransactionValid(with: configuration, validationType: .applePay, transactionType: .void) { (response, errror) in
            XCTAssertEqual(errror!.localizedDescription, "Country Code is invalid")
        }
        XCTAssertFalse(isValid)
    }
    
    func testAppleConfigForInvalidMerchantId() {
        configuration.applePayConfiguration?.merchantId = ""
        let isValid = configValidation.isTransactionValid(with: configuration, validationType: .applePay, transactionType: .void) { (response, errror) in
            XCTAssertEqual(errror!.localizedDescription, "Merchant Id cannot be empty")
        }
        XCTAssertFalse(isValid)
    }
    
    func testAppleConfigForUnsuportedCurrency() {
        configuration.applePayConfiguration?.currency = "XYZ"
        let isValid = configValidation.isTransactionValid(with: configuration, validationType: .applePay, transactionType: .void) { (response, errror) in
            XCTAssertEqual(errror!.localizedDescription, "Unsuported Currency")
        }
        XCTAssertFalse(isValid)
    }
}
