//
//  TransactionTests.swift
//  JudoKitObjCTests
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

import XCTest
@testable import JudoKitObjC

class TransactionTests: JudoTestCase {
    
    /**
     * GIVEN: I want to make a payment with valid amount, Judo ID and reference
     *
     *  WHEN: I select valid card for transaction and make the payment
     *
     *  THEN: I should obtain a valid JPResponse and no error
     */
    func test_OnValidCard_ReturnSuccesfulResponse() {
        
        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testValidVisaCard")
        
        payment.send(completion: { (response, error) -> () in
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
            }
            
            XCTAssertNotNil(response,
                            "Response must not be nil on valid receipt")
            
            XCTAssertNotNil(response?.items?.first,
                            "Response must contain at least one JPTransactionData object")
            
            XCTAssertEqual(response?.items?.first?.result, TransactionResult.success,
                           "Response should return a succesful transaction result")
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    /**
     * GIVEN: I want to make a payment with valid amount, Judo ID and reference
     *
     *  WHEN: I select an invalid card for transaction and make the payment
     *
     *  THEN: I should obtain an error and no response
     */
    func test_OnValidCard_ReturnDeclinedError() {
        
        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        payment.card = declinedVisaTestCard
        
        let expectation = self.expectation(description: "testInvalidCard")
        
        payment.send(completion: { [weak self] (response, error) -> () in
            XCTAssertNil(response, "Response must be nil when invalid card has been passed")
            self?.assert(error: error, as: .errorTransactionDeclined)
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30.0, handler: nil)
    }
    
}
