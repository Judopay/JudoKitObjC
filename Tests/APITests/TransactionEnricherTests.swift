//
//  TransactionEnricherTests.swift
//
//  Copyright (c) 2019 Alternative Payments Ltd
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

class TransactionEnricherTests: JudoTestCase {
    
    /**
     * GIVEN: I have an enriched JPPayment object
     *
     *  WHEN: I make a payment with the enriched object
     *
     *  THEN: JPPayment's `paymentDetails` must be populated with valid data
     */
    func testEnrichPaymentTransaction() {
        
        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        payment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "expectation")
        
        payment.send(completion: { (response, error) -> () in
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30.0) { error in
            XCTAssertNotNil(payment.paymentDetail)
        }
    }
    
    /**
     * GIVEN: I have an enriched JPPreAuth object
     *
     *  WHEN: I make a preAuth with the enriched object
     *
     *  THEN: JPPreAuth `paymentDetails` must be populated with valid data
     */
    func testEnrichPreAuthTransaction() {
        let preAuth = judo.preAuth(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        preAuth.card = validVisaTestCard
        let expectation = self.expectation(description: "expectation")
        
        preAuth.send(completion: { (response, error) -> () in
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30.0) { error in
            XCTAssertNotNil(preAuth.paymentDetail)
        }
    }
    
    /**
     * GIVEN: I have an enriched JPRegisterCard object
     *
     *  WHEN: I make a card registration with the enriched object
     *
     *  THEN: JPRegisterCard `paymentDetails` must be populated with valid data
     */
    func testEnrichRegisterCardTransaction() {
        let registerCard = judo.registerCard(withJudoId: myJudoId,
                                             reference: JPReference(consumerReference: UUID().uuidString))
        registerCard.card = validVisaTestCard
        let expectation = self.expectation(description: "expectation")

        registerCard.send(completion: { (response, error) -> () in
            expectation.fulfill()
        })

        self.waitForExpectations(timeout: 30.0) { error in
            XCTAssertNotNil(registerCard.paymentDetail)
        }
    }

    /**
     * GIVEN: I have an enriched JPSaveCard object
     *
     *  WHEN: I make a card save with the enriched object
     *
     *  THEN: JPSaveCard `paymentDetails` must be populated with valid data
     */
    func testNotEnrichSaveCardTransaction() {
        let saveCard = self.judo.saveCard(withJudoId: myJudoId,
                                          reference: JPReference(consumerReference: UUID().uuidString))
        let expectation = self.expectation(description: "expectation")

        saveCard.send(completion: { (response, error) -> () in
            expectation.fulfill()
        })

        self.waitForExpectations(timeout: 30.0) { error in
            XCTAssertNil(saveCard.paymentDetail)
        }
    }
    
    /**
     * GIVEN: I have an enriched JPPayment object with
     *
     *  WHEN: I make a payment with the enriched object
     *
     *  THEN: JPPayment should have valid SDK info stored
     */
    func testEnrichTransactionWithSDKInfo() {
        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        payment.card = validVisaTestCard
        let expectation = self.expectation(description: "expectation")
        
        payment.send(completion: { (response, error) -> () in
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30.0) { error in
            let dictionary = payment.paymentDetail!.toDictionary()["SDK_INFO"] as! [String: String]
            
            XCTAssertNotNil(dictionary)
            XCTAssertEqual(dictionary["Version"] as String?, JudoKitVersion)
            XCTAssertEqual(dictionary["Name"] as String?, "iOS-ObjC")
        }
    }
    
    /**
     * GIVEN: I have an enriched JPPayment object
     *
     *  WHEN: I make a payment with the enriched object
     *
     *  THEN: JPPayment should have valid consumer device info stored
     */
    func testEnrichTransactionWithConsumerDevice() {
        let payment = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        payment.card = validVisaTestCard
        let expectation = self.expectation(description: "expectation")
        
        payment.send(completion: { (response, error) -> () in
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30.0) { error in
            let dictionary = payment.paymentDetail!.toDictionary()["ConsumerDevice"] as! [String: Any]
            
            XCTAssertNotNil(dictionary)
            XCTAssertNotNil(dictionary["IpAddress"])
            XCTAssertNotNil(dictionary["ThreeDSecure"])
            XCTAssertNotNil(dictionary["ClientDetails"])
            XCTAssertNotNil(dictionary["GeoLocation"])
            XCTAssertEqual(dictionary["PaymentType"] as! String, "ECOMM")
        }
    }

}
