//
//  DedupTestCase.swift
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


class DedupTestCase: JudoTestCase {

    /**
     * GIVEN: JudoKit's payment method is called with valid parameters
     *
     * THEN:  A valid JPPayment object must be initialized and returned
     */
    func test_JPPaymentInitialization() {
        
        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        XCTAssertNotNil(payment,
                        "A valid JPPayment object must be created when correctly initialized")
        
        XCTAssertEqual(payment.judoId, myJudoId,
                       "The JudoID stored in the JPPayment object does not match the one passed")
    }
    
    /**
     * GIVEN: I create a valid payment transaction
     *
     * WHEN:  I create another payment transaction with a different reference
     *
     * THEN:  The transaction succeeds and a JPResponse object is returned
     */
    func test_OnDifferentReferences_AllowDuplicateTransactions() {
        
        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "payment expectation")
        
        payment.send(completion: { [weak self] (response, error) -> () in
            
            guard let self = self else {
                XCTFail()
                expectation.fulfill()
                return
            }
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
                expectation.fulfill()
                return
            }
            
            let payment2 = self.judo.payment(withJudoId: myJudoId,
                                             amount: JPAmount(amount: "0.01", currency: "GBP"),
                                             reference: JPReference(consumerReference: UUID().uuidString))
            
            payment2.card = self.validVisaTestCard
            
            payment2.send(completion: { (response, error) in
                
                if let error = error {
                    XCTFail("API call failed with error: \(error)")
                    expectation.fulfill()
                    return
                }
                
                XCTAssertNotNil(response,
                                "Second transaction with different reference must return valid JPResponse object")
                
                XCTAssertNotNil(response?.items?.first,
                                "Returned JPResponse object must contain at least one JPTransactionData object")
                
                expectation.fulfill()
            })
            
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I create a valid payment transaction
     *
     * WHEN:  I create another payment transaction with the same reference
     *
     * THEN:  The transaction fails and a 'Duplicate Transaction' error returns
     */
    func test_OnDifferentReferences_DenyDuplicateTransactions() {
        
        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))

        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "payment expectation")
        
        payment.send(completion: { (response, error) -> () in
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
                return
            }
            
            payment.send(completion: { [weak self] (response, error) in
                XCTAssertNil(response, "JPResponse should not be returned on duplicate transactions")
                self?.assert(error: error, as: .errorDuplicateTransaction)
                expectation.fulfill()
            })
            
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
}
