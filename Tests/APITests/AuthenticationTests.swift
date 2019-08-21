//
//  AuthenticationTests.swift
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

class AuthenticationTests: JudoTestCase {
    
    /**
     * GIVEN: I have a valid token / secret and a valid Judo ID
     *
     * WHEN:  I access the API and make a request
     *
     * THEN:  I get back a valid JPTransaction object
     */
    func test_CreateValidJudoTransactionRequest() {
        
        let consumerReference = UUID().uuidString;
        
        let request = judo.transaction(for: .payment,
                                              judoId: myJudoId,
                                              amount: JPAmount(amount: "0.01", currency: "GBP"),
                                              reference: JPReference(consumerReference: consumerReference))
        
        XCTAssertNotNil(request,
                        "JPTransaction object must not be nil")
        XCTAssertEqual(request?.amount?.amount, "0.01",
                       "JPTransaction object must be initialized with correct amount")
        XCTAssertEqual(request?.amount?.currency, "GBP",
                       "JPTransaction object must be initialized with correct currency")
        XCTAssertEqual(request?.judoId, myJudoId,
                       "JPTransaction object must be initialized with valid Judo ID")
        XCTAssertEqual(request?.reference?.consumerReference, consumerReference,
                       "JPTransaction object must be initialized with valid consumer reference")
        
    }
    
    /**
     * GIVEN: I have an invalid token / secret and a valid Judo ID
     *
     * WHEN:  I access the API and attept to make a transaction
     *
     * THEN:  I get back an authentication error
     */
    func test_OnInvalidTokenAndSecret_ReturnAuthenticationError() {
        
        let payment = invalidJudo.payment(withJudoId: myJudoId,
                                                 amount: JPAmount(amount: "0.01", currency: "GBP"),
                                                 reference: JPReference(consumerReference: UUID().uuidString))
        
        payment.card = self.validVisaTestCard
        
        let expectation = self.expectation(description: "testInvalidTokenAndSecret")
        
        payment.send { [weak self] (response, error) in
            self?.assert(error: error, as: .errorAuthenticationFailure)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    /**
     * GIVEN: I have a valid token / secret and an non-existent but valid Judo ID
     *
     * WHEN:  I access the API and attept to make a transaction
     *
     * THEN:  I get back an invalid account error
     */
    func test_OnNonExistentJudoID_ReturnAccountNotFoundError() {

        let expectation = self.expectation(description: "testNonExistentJudoID")
        
        let payment = judo.payment(withJudoId: "1000009",
                                          amount: JPAmount(amount: "0.01", currency: "GBP"),
                                          reference: JPReference(consumerReference: UUID().uuidString))
        
        payment.card = validVisaTestCard
        
        payment.send { [weak self] (response, error) in
            self?.assert(error: error, as: .errorAccountLocationNotFound);
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    /**
     * GIVEN: I have a valid token / secret and an invalid Judo ID
     *
     * WHEN:  I access the API and attept to make a transaction
     *
     * THEN:  I get back an invalid model error
     */
    func test_OnInvalidJudoID_ReturnInvalidModelError() {
        
        let expectation = self.expectation(description: "testInvalidJudoID")
        
        let payment = judo.payment(withJudoId: "invalid_judo_id",
                                          amount: JPAmount(amount: "0.01", currency: "GBP"),
                                          reference: JPReference(consumerReference: UUID().uuidString))
        
        payment.card = validVisaTestCard
        
        payment.send { [weak self] (response, error) in
            self?.assert(error: error, as: .errorGeneral_Model_Error);
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    /**
     * GIVEN: I have a valid token, secret and Judo ID
     *
     * WHEN:  I access the API and attept to make a transaction
     *
     * THEN:  I get back a valid response and no error
     */
    func test_OnValidParameters_ReturnValidTransaction() {

        let payment = judo.payment(withJudoId: myJudoId,
                                          amount: JPAmount(amount: "0.01", currency: "GBP"),
                                          reference: JPReference(consumerReference: UUID().uuidString))
        
        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testValidTransaction")
        
        payment.send { (response, error) in
            
            XCTAssertNil(error, "Error must be nil on valid transaction")
            XCTAssertNotNil(response, "Response must not be nil on valid transaction")
            XCTAssertNotNil(response?.items?.first, "Response must contain at least on JPTransactionData objects")
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
}
