//
//  IDEALManagerTests.swift
//  JudoKitObjCTests
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

class IDEALManagerTests: JudoTestCase {
    
    private var idealManager: JPIDealService!
    
    override func setUp() {
        super.setUp()
        idealManager = JPIDealService(judoId: myJudoId,
                                    amount: 0.01,
                                    reference: JPReference(consumerReference: "MYR3F3R3NC3"),
                                    session: judo.apiSession,
                                    paymentMetadata: nil)
    }
    
    override func tearDown() {
        idealManager = nil
        super.tearDown()
    }
    
    /**
     * GIVEN: I have a valid iDEAL bank title and identifier code
     *
     * WHEN: I make a request for a redirect URL with the correct iDEAL bank details
     *
     * THEN: I should get back the order ID and the checksum
     */
    func test_onJPIDealBankSelection_ReturnRedirectURL() {
        
        let expectation = self.expectation(description: "redirectSuccesful")
        
        idealManager.redirectURL(for: JPIDealBank(type: .ABN)) { orderId, checksum, error in
            XCTAssertFalse(orderId?.isEmpty ?? true)
            XCTAssertFalse(checksum?.isEmpty ?? true)
            XCTAssertNil(error)
            expectation.fulfill()
        };
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    /**
     * GIVEN: I have a valid checksum and order ID
     *
     * WHEN: I make a request for the transaction status and the status is pending for 60 seconds
     *
     * THEN: I should get back a failed transaction status and no error
     */
    func test_onIDEALStatusPolling_ReturnTransactionStatus() {
        
        let expectation = self.expectation(description: "pollSuccesful")
        
        idealManager.pollTransactionStatus(forOrderId: "0RD3R1D", checksum: "CH3CK5VM") { response, error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 100.0)
    }
    
}
