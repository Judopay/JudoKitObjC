//
//  PaymentTests.swift
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
import CoreLocation
@testable import JudoKitObjC

class PaymentTests: JudoTestCase {
    
    /**
     * GIVEN: I call JudoKit's payment method with valid parameters
     *
     * THEN:  A valid JPPayment object must be returned
     */
    func test_JPPaymentInitialization() {
        let references = JPReference(consumerReference: UUID().uuidString)
        let amount = JPAmount(amount: "30", currency: "GBP")
        
        let payment = judo.payment(withJudoId: myJudoId, amount: amount, reference: references)
        XCTAssertNotNil(payment)
    }
    
    /**
     * GIVEN: I initialize JPPayment correctly
     *
     * WHEN:  I call JPPayment's 'send' method
     *
     * THEN:  A JPResponse object and no error must be returned
     */
    func test_OnValidJPPayment_ReturnResponse() {

        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testValidJPPayment")
        
        payment.send { (response, error) in
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
            }
            
            XCTAssertNotNil(response,
                            "Response must not be nil on valid JPPayment configuration")
            
            XCTAssertNotNil(response?.items?.first,
                            "Response must contain at least one JPTransactionData object on valid Collection configuration")
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPayment with Singapore dollars
     *
     * WHEN:  I call JPPayment's 'send' method
     *
     * THEN:  A JPResponse object and no error must be returned
     */
    func test_OnPaymentWithSingaporeDollars_ReturnResponse() {

        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "17.72", currency: "SGD"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testSingaporeDollars")
        
        payment.send(completion: { (response, error) -> () in
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
            }
            
            XCTAssertNotNil(response,
                            "Response must not be nil on valid JPPayment configuration")
            
            XCTAssertNotNil(response?.items?.first,
                            "Response must contain at least one JPTransactionData object on valid Collection configuration")
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPayment with an invalid amount
     *
     * WHEN:  I call JPPayment's 'send' method
     *
     * THEN:  An error and no JPResponse must be returned
     */
    func test_OnPaymentWithoutAmount_ReturnError() {

        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testInvalidAmount")
        
        payment.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response, "JPResponse must be nil on incorrect configuration")
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })

        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPayment with an invalid currency
     *
     * WHEN:  I call JPPayment's 'send' method
     *
     * THEN:  An error and no JPResponse must be returned
     */
    func test_OnPaymentWithoutCurrency_ReturnError() {

        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: ""),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testInvalidCurrency")
        
        payment.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response, "JPResponse must be nil on incorrect configuration")
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPayment with an invalid reference
     *
     * WHEN:  I call JPPayment's 'send' method
     *
     * THEN:  An error and no JPResponse must be returned
     */
    func test_OnPaymentWithoutReference_ReturnError() {

        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: ""))
        
        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testInvalidCurrency")
        
        payment.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response, "JPResponse must be nil on incorrect configuration")
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPayment with an empty payment reference
     *
     * WHEN:  I call JPPayment's 'send' method
     *
     * THEN:  An error and no JPResponse must be returned
     */
    func test_OnPaymentWithEmptyPaymentReference_ReturnError() {

        let reference = JPReference(consumerReference: UUID().uuidString,
                                    paymentReference: "")
        
        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: reference)
        
        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testEmptyPaymentReference")
        
        payment.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response, "JPResponse must be nil on incorrect configuration")
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPayment with a payment reference that contains
     *        whitespaces only
     *
     * WHEN:  I call JPPayment's 'send' method
     *
     * THEN:  An error and no JPResponse must be returned
     */
    func test_OnPaymentWithWhitespacePaymentReference_ReturnError() {

        let reference = JPReference(consumerReference: UUID().uuidString,
                                    paymentReference: " ")
        
        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: reference)
        
        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testEmptyPaymentReference")
        
        payment.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response, "JPResponse must be nil on incorrect configuration")
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I initialize JPPayment with a payment reference that contains
     *        more than 50 characters
     *
     * WHEN:  I call JPPayment's 'send' method
     *
     * THEN:  An error and no JPResponse must be returned
     */
    func test_OnPaymentWithLongPaymentReference_ReturnError() {
 
        let reference = JPReference(consumerReference: UUID().uuidString,
                                    paymentReference: String(repeating: "a", count: 51))
        
        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: reference)
        
        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testEmptyPaymentReference")
        
        payment.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response, "JPResponse must be nil on incorrect configuration")
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
}
