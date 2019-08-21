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
    
    /**
     * GIVEN: I call JudoKit's `registerCard` method with valid Judo ID and reference
     *
     * THEN:  I should be able to initialize a valid JPRegisterCard object
     */
    func test_OnValidParameters_JPRegisterCardInitializesSuccesfully() {
        let registration = judo.registerCard(withJudoId: myJudoId,
                                             reference: JPReference(consumerReference: UUID().uuidString))
        
        XCTAssertNotNil(registration,
                        "JPRegisterCard should be succesfully initialized with valid parameters")
    }
    
    /**
     * GIVEN: I have a valid JPRegisterCard object
     *
     * WHEN:  I call its 'send' method to register the card
     *
     * THEN:  I should get back a succesful response and no error
     */
    func test_OnValidJPRegisterCard_ValidJPResponeMustBeReturned() {
        
        let registration = judo.registerCard(withJudoId: myJudoId,
                                             reference: JPReference(consumerReference: UUID().uuidString))
        
        
        registration.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testRegistration")
        
        registration.send(completion: { (response, error) -> () in
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
            }
            
            XCTAssertNotNil(response,
                            "Response must not be nil on valid receipt")
            
            XCTAssertNotNil(response?.items?.first,
                            "Response must contain at least one JPTransactionData object")
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I have a JPRegisterCard object with an invalid reference
     *
     * WHEN:  I call its 'send' method to register the card
     *
     * THEN:  I should get back an error and no response
     */
    func test_OnJPRegisterCardWithInvalidReference_ReturnError() {
        
        let registration = judo.registerCard(withJudoId: myJudoId,
                                             reference: JPReference(consumerReference: ""))
        
        registration.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testInvalidReference")
        
        registration.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response,
                         "JPResponse must be nil on JPRegisterCard with invalid reference")
            
            self?.assert(error: error, as: .errorGeneral_Model_Error)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    
}
