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

class JPConfigurationValidationServiceTest: XCTestCase {
    var amount: JPAmount!
    var configuration: JPConfiguration!
    let consumerReference = "judoPay-sample-app"
    var configValidation: JPConfigurationValidationService!
    lazy var reference = JPReference(consumerReference: consumerReference)

    override func setUp() {
        configValidation = JPConfigurationValidationServiceImp()
        amount = JPAmount("fv", currency: "GBR")
        configuration = JPConfiguration(judoID: "judoId", amount: self.amount, reference: reference)
        configuration.supportedCardNetworks = [.networkVisa, .networkMasterCard, .networkAMEX]
    }
    
    func testInvalidCharacters() {
        let isValid = configValidation.isTransactionValid(with: configuration, validationType: .transaction, transactionType: .payment) { (response, errror) in
            XCTAssertEqual(errror!.localizedDescription, "Amount should be a number")
        }
        XCTAssertFalse(isValid)
    }
    
    func testEmptyCurrency() {
        amount = JPAmount("0.1", currency: "")
        configuration.amount = amount
        let isValid = configValidation.isTransactionValid(with: configuration, validationType: .transaction, transactionType: .payment) { (response, errror) in
            XCTAssertEqual(errror!.localizedDescription, "Currency cannot be empty")
        }
        XCTAssertFalse(isValid)
    }
    
    func testNilJudoId() {
        configuration = nil
        let isValid = configValidation.isTransactionValid(with: configuration, validationType: .transaction, transactionType: .payment) { (response, errror) in
            XCTAssertEqual(errror!.localizedDescription, "JudoId cannot be null or empty")
        }
        XCTAssertFalse(isValid)
    }
    
    func testConsumerReferenceInvalid() {
        let reference40Characters = String(repeating: "J", count: Int(kMaximumLengthForConsumerReference + 1))
        configuration.reference = JPReference(consumerReference: reference40Characters)
        let isValid = configValidation.isTransactionValid(with: configuration, validationType: .transaction, transactionType: .payment) { (response, errror) in
            XCTAssertEqual(errror!.localizedDescription, "Consumer Reference is invalid")
        }
        XCTAssertFalse(isValid)
    }
}
