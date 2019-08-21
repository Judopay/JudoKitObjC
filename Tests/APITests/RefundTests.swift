//
//  RefundTests.swift
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

class RefundTests: JudoTestCase {
    
    /**
     * GIVEN: I make a transaction and get a valid receipt ID and amount
     *
     * WHEN:  I create a JPRefund object with the receipt ID and amount and call 'send'
     *
     * THEN:  I should get back a succesful response and no error
     */
    func test_OnValidReceiptIDAndAmount_ReturnValidResponse() {
        
        let expectation = self.expectation(description: "testRefund")
        
        let preAuth = judo.payment(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        preAuth.card = validVisaTestCard
        
        preAuth.send(completion: { (response, error) -> () in
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
                return
            }
            
            guard let receiptId = response?.items?.first?.receiptId else {
                XCTFail("Receipt ID was not available in response.")
                return
            }
            
            guard let amount = response?.items?.first?.amount else {
                XCTFail("Amount was not available in response.")
                return
            }
            
            let refund = self.judo.refund(withReceiptId: receiptId, amount: amount)
            
            refund.send(completion: { (response, error) -> () in

                if let error = error {
                    XCTFail("API call failed with error: \(error)")
                }
                
                XCTAssertNotNil(response,
                                "Response must not be nil on valid receipt")
                
                XCTAssertNotNil(response?.items?.first,
                                "Response must contain at least one JPTransactionData object")
                
                expectation.fulfill();
            })
            
            XCTAssertNotNil(refund)
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
        
    }
    
}
