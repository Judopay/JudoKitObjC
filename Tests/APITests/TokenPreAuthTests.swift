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

class TokenPreAuthTests: JudoTestCase {
    
    /**
     * GIVEN: I have registered a card and obtained a valid consumer and card token
     *
     * WHEN:  I make a preAuth with an initialized JPPaymentToken
     *
     * THEN:  I should get back a valid JPResponse and no error
     */
    func test_OnValidJPPaymentToken_ReturnValidJPResponse() {
        
        let reference = JPReference(consumerReference: UUID().uuidString)
        
        let registerCard = judo.registerCard(withJudoId: myJudoId,
                                             reference: reference)
        
        registerCard.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testTokenPayment")
        
        registerCard.send(completion: { [weak self] (response, error) -> () in
            
            guard let self = self else { return }
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
            }
            
            guard let consumerToken = response?.items?.first?.consumer.consumerToken else {
                XCTFail("No consumer token found in response")
                return
            }
            guard let cardToken = response?.items?.first?.cardDetails?.cardToken else {
                XCTFail("No card token found in response")
                return
            }
            
            let paymentToken = JPPaymentToken(consumerToken: consumerToken, cardToken: cardToken)
            
            paymentToken.secureCode = self.validVisaTestCard.secureCode
            
            let preAuth = self.judo.preAuth(withJudoId: myJudoId,
                                            amount: JPAmount(amount: "0.01", currency: "GBP"),
                                            reference: reference)
            
            preAuth.paymentToken = paymentToken
            
            preAuth.send(completion: { (response, error) -> () in
                
                if let error = error {
                    XCTFail("API call failed with error: \(error)")
                }
                
                XCTAssertNotNil(response,
                                "Response must not be nil on valid receipt")
                
                XCTAssertNotNil(response?.items?.first,
                                "Response must contain at least one JPTransactionData object")
                
                expectation.fulfill()
            })
            
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I have a JPRegisterCard object and registered the card
     *
     * WHEN:  I make a preAuth without passing a JPPaymentToken
     *
     * THEN:  I should get back an error and no response
     */
    func test_OnNoJPPaymentToken_ReturnError() {
        
        let registerCard = judo.registerCard(withJudoId: myJudoId,
                                             reference: JPReference(consumerReference: UUID().uuidString))
        
        registerCard.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testNoTokenPayment")
        
        registerCard.send(completion: { [weak self] (_, error) -> () in
            
            guard let self = self else { return }
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
            }
            
            let preAuth = self.judo.preAuth(withJudoId: myJudoId,
                                            amount: JPAmount(amount: "0.01", currency: "GBP"),
                                            reference: JPReference(consumerReference: UUID().uuidString))
            
            preAuth.send(completion: { [weak self] (response, error) -> () in
                XCTAssertNil(response, "Response must be nil when no preAuth token has been passed")
                self?.assert(error: error, as: .errorPaymentMethodMissing)
                expectation.fulfill()
            })
            
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I have registered the card with some reference ID
     *
     * WHEN: I make a preAuth with a different reference ID
     *
     * THEN:  I should get back an error and no response
     */
    func test_OnWrongReferencePassed_ReturnError() {
        
        let registerCard = judo.registerCard(withJudoId: myJudoId,
                                             reference: JPReference(consumerReference: UUID().uuidString))
        registerCard.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testDifferentReferences")
        
        registerCard.send(completion: { [weak self] (response, error) -> () in
            
            guard let self = self else { return }
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
            }
            
            guard let consumerToken = response?.items?.first?.consumer.consumerToken else {
                XCTFail("No consumer token found in response")
                return
            }
            guard let cardToken = response?.items?.first?.cardDetails?.cardToken else {
                XCTFail("No card token found in response")
                return
            }
            
            let paymentToken = JPPaymentToken(consumerToken: consumerToken, cardToken: cardToken)
            
            paymentToken.secureCode = self.validVisaTestCard.secureCode
            
            let preAuth = self.judo.preAuth(withJudoId: myJudoId,
                                            amount: JPAmount(amount: "0.01", currency: "GBP"),
                                            reference: JPReference(consumerReference: UUID().uuidString))
            
            preAuth.paymentToken = paymentToken
            
            preAuth.send(completion: { [weak self] (response, error) -> () in
                XCTAssertNil(response, "Response must be nil when invalid reference has been passed")
                self?.assert(error: error, as: .errorCardTokenDoesntMatchConsumer)
                expectation.fulfill()
            })
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I have registered the card and got back card and consumer tokens
     *
     * WHEN:  I make a preAuth with an invalid amount
     *
     * THEN:  I should get back an error and no response
     */
    func test_OnTokenPreAuthWithoutAmount_ReturnError() {
        
        let reference = JPReference(consumerReference: UUID().uuidString)
        
        let registerCard = judo.registerCard(withJudoId: myJudoId,
                                             reference: reference)
        
        registerCard.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testInvalidAmount")
        
        registerCard.send(completion: { [weak self] (response, error) -> () in
            
            guard let self = self else { return }
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
            }
            
            guard let consumerToken = response?.items?.first?.consumer.consumerToken else {
                XCTFail("No consumer token found in response")
                return
            }
            guard let cardToken = response?.items?.first?.cardDetails?.cardToken else {
                XCTFail("No card token found in response")
                return
            }
            
            let paymentToken = JPPaymentToken(consumerToken: consumerToken, cardToken: cardToken)
            
            paymentToken.secureCode = self.validVisaTestCard.secureCode
            
            let preAuth = self.judo.preAuth(withJudoId: myJudoId,
                                            amount: JPAmount(amount: "", currency: "GBP"),
                                            reference: JPReference(consumerReference: UUID().uuidString))
            
            preAuth.paymentToken = paymentToken
            
            preAuth.send(completion: { [weak self] (response, error) -> () in
                XCTAssertNil(response, "Response must be nil when invalid amount has been passed")
                self?.assert(error: error, as: .errorGeneral_Model_Error)
                expectation.fulfill()
            })
            
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
}
