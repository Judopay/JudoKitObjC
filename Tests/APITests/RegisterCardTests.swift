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
import CoreLocation
@testable import JudoKitObjC

class RegisterCardTests: JudoTestCase {
    
    func testRegisterCard() {
        let payment = judo.registerCard(withJudoId: myJudoId, amount: nil, reference: validReference)
        XCTAssertNotNil(payment)
    }
    
    func testJudoMakeValidRegisterCard() {
        // Given I have a Register Card
        let payment = judo.registerCard(withJudoId: myJudoId, amount: nil, reference: validReference)
        
        // When I provide all the required fields
        payment.card = validVisaTestCard
        
        // Then I should be able to register a card
        let expectation = self.expectation(description: "payment expectation")
        
        payment.send(completion: { (response, error) -> () in
            if let error = error {
                XCTFail("api call failed with error: \(error)")
            }
            XCTAssertNotNil(response)
            XCTAssertNotNil(response?.items?.first)
            expectation.fulfill()
        })
        
        XCTAssertNotNil(payment)
        XCTAssertEqual(payment.judoId, myJudoId)
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testJudoMakeValidRegisterCardWithDeviceSignals() {
        // Given I have a Register Card
        let payment = judo.registerCard(withJudoId: myJudoId, amount: nil, reference: validReference)
        
        // When I provide all the required fields
        payment.card = validVisaTestCard
        
        // Then I should be able to register a card
        let expectation = self.expectation(description: "payment expectation")
        
        judo.send(withCompletion: payment, completion: { (response, error) in
            if let error = error {
                XCTFail("api call failed with error: \(error)")
            }
            XCTAssertNotNil(response)
            XCTAssertNotNil(response?.items?.first)
            expectation.fulfill()
        })
        
        XCTAssertNotNil(payment)
        XCTAssertEqual(payment.judoId, myJudoId)
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testJudoMakePaymentWithoutReference() {
        // Given I have a Register Card
        // When I do not provide a consumer reference
        let payment = judo.registerCard(withJudoId: myJudoId, amount: nil, reference: invalidReference)
        
        payment.card = validVisaTestCard
        
        // Then I should receive an error
        let expectation = self.expectation(description: "payment expectation")
        
        payment.send(completion: { (response, error) -> () in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            XCTAssertEqual(error!._code, Int(JudoError.errorGeneral_Model_Error.rawValue))
            
            expectation.fulfill()
        })
        
        XCTAssertNotNil(payment)
        XCTAssertEqual(payment.judoId, myJudoId)
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    
}
