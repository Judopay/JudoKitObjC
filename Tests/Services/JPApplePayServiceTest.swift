//
//  JPApplePayServiceTest.swift
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
import Mockingjay
@testable import JudoKitObjC


class JPApplePayServiceTest: XCTestCase {
    
    var appleService: JPApplePayService?
    
    override func setUp() {
        let paymentSummaryItems = [JPPaymentSummaryItem(label: "item 1", amount: 0.01),
                        JPPaymentSummaryItem(label: "item 2", amount: 0.02),
                        JPPaymentSummaryItem(label: "Judo Pay", amount: 0.03)]
        
        let applePayConfigurations = JPApplePayConfiguration(merchantId: "merchantId",
                                                             currency: "EUR",
                                                             countryCode: "GB{",
                                                             paymentSummaryItems: paymentSummaryItems)
        
        let transactionService = JPTransactionService(token: "TransactionServiceTokem",
                                                      andSecret: "TransactionTokenSecret")
        
        self.appleService = JPApplePayService(configuration: applePayConfigurations,
                                              transactionService: transactionService)
            
    }
    
    
    func testIsApplePaySupported() {
        let isApplePaySupported = JPApplePayService.isApplePaySupported()
        XCTAssertTrue(isApplePaySupported)
    }
    
    func testIsApplePaySetUp() {
       let isApplePaySetUp = self.appleService!.isApplePaySetUp()
        XCTAssertTrue(isApplePaySetUp)
    }
}
