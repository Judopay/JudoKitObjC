//
//  PreAuthTests.swift
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

class PreAuthTests: JudoTestCase {
    
    /**
     * GIVEN: I call JudoKit's preAuth method with valid parameters
     *
     * THEN:  A valid JPPreAuth object must be returned
     */
    func test_JPPreAuthInitialization() {
        let references = JPReference(consumerReference: UUID().uuidString)
        let amount = JPAmount(amount: "30", currency: "GBP")
        
        let preAuth = judo.preAuth(withJudoId: myJudoId, amount: amount, reference: references)
        XCTAssertNotNil(preAuth)
    }
    
    /**
     * GIVEN: I initialize JPPreAuth correctly
     *
     * WHEN:  I call JPPreAuth 'send' method
     *
     * THEN:  A JPResponse object and no error must be returned
     */
    func test_OnValidJPPreAuth_ReturnResponse() {
        
        let preAuth = judo.preAuth(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        preAuth.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testValidJPPreAuth")
        
        preAuth.send(completion: { (response, error) -> () in
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
            }
            
            XCTAssertNotNil(response,
                            "Response must not be nil on valid JPPreAuth configuration")
            
            XCTAssertNotNil(response?.items?.first,
                            "Response must contain at least one JPTransactionData object on valid Collection configuration")
            
            expectation.fulfill()
        })

        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPreAuth with Singapore dollars
     *
     * WHEN:  I call JPPreAuth 'send' method
     *
     * THEN:  A JPResponse object and no error must be returned
     */
    func test_OnPreAuthWithSingaporeDollars_ReturnResponse() {
        
        let preAuth = judo.preAuth(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "17.72", currency: "SGD"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        preAuth.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testSingaporeDollars")
        
        preAuth.send(completion: { (response, error) -> () in
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
            }
            
            XCTAssertNotNil(response,
                            "Response must not be nil on valid JPPreAuth configuration")
            
            XCTAssertNotNil(response?.items?.first,
                            "Response must contain at least one JPTransactionData object on valid Collection configuration")
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPreAuth with an invalid amount
     *
     * WHEN:  I call JPPreAuth 'send' method
     *
     * THEN:  An error and no JPResponse must be returned
     */
    func test_OnPreAuthWithoutAmount_ReturnError() {
        
        let preAuth = judo.preAuth(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        preAuth.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testInvalidAmount")
        
        preAuth.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response, "JPResponse must be nil on incorrect configuration")
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPreAuth with an invalid currency
     *
     * WHEN:  I call JPPreAuth 'send' method
     *
     * THEN:  An error and no JPResponse must be returned
     */
    func test_OnPreAuthWithoutCurrency_ReturnError() {
        
        let preAuth = judo.preAuth(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: ""),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        preAuth.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testInvalidCurrency")
        
        preAuth.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response, "JPResponse must be nil on incorrect configuration")
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }

    /**
     * GIVEN: I initialize JPPreAuth with an invalid reference
     *
     * WHEN:  I call JPPreAuth 'send' method
     *
     * THEN:  An error and no JPResponse must be returned
     */
    func test_OnPreAuthWithoutReference_ReturnError() {
        
        let preAuth = judo.preAuth(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: ""))
        
        preAuth.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testInvalidCurrency")
        
        preAuth.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response, "JPResponse must be nil on incorrect configuration")
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPreAuth with an empty payment reference
     *
     * WHEN:  I call JPPreAuth 'send' method
     *
     * THEN:  An error and no JPResponse must be returned
     */
    func test_OnPreAuthWithEmptyPaymentReference_ReturnError() {
        
        let reference = JPReference(consumerReference: UUID().uuidString,
                                    paymentReference: "")
        
        let preAuth = judo.preAuth(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: reference)
        
        preAuth.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testEmptyPaymentReference")
        
        preAuth.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response, "JPResponse must be nil on incorrect configuration")
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPreAuth with a payment reference that contains
     *        whitespaces only
     *
     * WHEN:  I call JPPreAuth 'send' method
     *
     * THEN:  An error and no JPResponse must be returned
     */
    func test_OnPreAuthWithWhitespacePaymentReference_ReturnError() {
        
        let reference = JPReference(consumerReference: UUID().uuidString,
                                    paymentReference: " ")
        
        let preAuth = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: reference)
        
        preAuth.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testEmptyPaymentReference")
        
        preAuth.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response, "JPResponse must be nil on incorrect configuration")
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPreAuth with a payment reference that contains
     *        more than 50 characters
     *
     * WHEN:  I call JPPreAuth 'send' method
     *
     * THEN:  An error and no JPResponse must be returned
     */
    func test_OnPreAuthWithLongPaymentReference_ReturnError() {
        
        let reference = JPReference(consumerReference: UUID().uuidString,
                                    paymentReference: String(repeating: "a", count: 51))
        
        let preAuth = judo.preAuth(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: reference)
        
        preAuth.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testEmptyPaymentReference")
        
        preAuth.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response, "JPResponse must be nil on incorrect configuration")
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
}
