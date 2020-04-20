//
//  JPPaymentMethodsInteractorTest.swift
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

class JPPaymentMethodsInteractorTest: XCTestCase {
    var sut: JPPaymentMethodsInteractor!
    let configuration = JPConfiguration(judoID: "judoId", amount: JPAmount("fv", currency: "GBR"), reference: JPReference(consumerReference: "consumerReference"))

    override func setUp() {
        super.setUp()
        configuration.supportedCardNetworks = [.networkVisa, .networkMasterCard, .networkAMEX]
        let service = JPTransactionService()
        sut = JPPaymentMethodsInteractorImpl(mode: .serverToServer, configuration: configuration, transactionService: service, completion: nil)
    }

    func testServerToServer()  {
        let completion: JudoCompletionBlock = { (response, error) in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
        }
        sut.paymentTransaction(withToken: "", andCompletion: completion)
    }
    
    func testServerToServerApple()  {
        let completion: JudoCompletionBlock = { (response, error) in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
        }
        sut.startApplePay(completion: completion)
    }
}
