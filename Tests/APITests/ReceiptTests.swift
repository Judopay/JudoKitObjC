//
//  ReceiptTests.swift
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

class ReceiptTests: JudoTestCase {
    
    /**
     * GIVEN: I make a payment with valid parameters and get a valid receipt ID
     *
     * WHEN:  I use the receipt ID to create a JPReceipt object and call the 'send' method
     *
     * THEN:  I should get back a succesful response and no error for a specific receipt
     */
    func test_OnValidReceiptID_JPReceiptReturnsValidResponse() {

        let initialPayment = judo.payment(withJudoId: myJudoId,
                                          amount: JPAmount(amount: "0.01", currency: "GBP"),
                                          reference: JPReference(consumerReference: UUID().uuidString))
        
        initialPayment.card = validVisaTestCard
        
        let expectation = self.expectation(description: "testReceipt")
        
        initialPayment.send(completion: { (response, error) -> () in
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
            }
            
            guard let receiptId = response?.items?.first?.receiptId as String? else {
                XCTFail("Receipt ID must not be nil on valid payment configuration")
                return
            }

            XCTAssertFalse(receiptId.isEmpty,
                          "Receipt ID must not be empty on valid payment configuration")
            
            let receipt = self.judo.receipt(receiptId);
            
            receipt.send(completion: { (response, error) -> () in
                
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
        
        self.waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    /**
     * GIVEN: I create a JPReceipt object without any receipt ID
     *
     * WHEN:  I call the 'send' method of the JPReceipt object
     *
     * THEN:  I should get back a succesful response and no error for all receipts
     */
    func test_OnNoReceiptID_JPReceiptReturnsValidResponse() {

        let expectation = self.expectation(description: "testAllReceipts")
        
        let receipt = judo.receipt(nil)
        
        receipt.send(completion: { (response, error) -> () in
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
            }
            
            XCTAssertNotNil(response,
                            "Response must not be nil on valid receipt")
            
            XCTAssertNotNil(response?.items?.first,
                            "Response must contain at least one JPTransactionData object")
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30.0, handler: nil)
        
    }
    
    /**
     * GIVEN: I create a JPReceipt object and a JPPagination object
     *
     * WHEN:  I call the 'list' method and provide the pagination object
     *
     * THEN:  I should get back a succesful paginated response and no error
     */
    func test_OnPaginationProvided_JPReceiptReturnsValidResponse() {

        let page = JPPagination(offset: 8, pageSize: 4, sort: "time-ascending")
        
        let expectation = self.expectation(description: "testReceiptPagination")

        let receipt = judo.receipt(nil)

        receipt.list(with: page) { (response, error) -> () in
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
                return
            }
            
            guard let response = response else {
                XCTFail("Valid JPResponse must be returned on valid configuration")
                return
            }
            
            XCTAssertEqual(response.items?.count, 4,
                           "Item count must match the one specified in the JPPagination object")
            
            XCTAssertEqual(response.pagination!.offset, 8,
                           "Item offset must match the one specified in the JPPagination object")

            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 30.0, handler: nil)
    }
    
}
