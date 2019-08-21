//
//  CollectionTests.swift
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

class CollectionTests: JudoTestCase {
    
    /**
     * GIVEN: I have made a pre-authorization request and received a receipt ID
     *        and an amount
     *
     * WHEN:  I perform a collection with the receipt ID and the amount
     *
     * THEN:  I should receive a succesful response with at least one
     *        JPTransactionData item
     */
    func test_OnCollectionCreation_WithValidReceiptAndAmount_ReturnValidResponse() {
        
        let expectation = self.expectation(description: "testPreAuth")

        let preAuth = judo.preAuth(withJudoId: myJudoId,
                                   amount: JPAmount(amount: "0.01", currency: "GBP"),
                                   reference: JPReference(consumerReference: UUID().uuidString))
        
        XCTAssertNotNil(preAuth,
                        "A valid JPPreAuth object must be created when correctly initialized")
        
        XCTAssertEqual(preAuth.judoId, myJudoId,
                       "The JudoID stored in the PreAuth object does not match the one passed")
        
        preAuth.card = validVisaTestCard
        
        preAuth.send { (response, error) in
            
            if let error = error {
                XCTFail("API call failed with error: \(error)")
                expectation.fulfill()
                return
            }
            
            guard let receiptId = response?.items?.first?.receiptId else {
                XCTFail("Receipt ID was not available in response")
                return
            }
            
            guard let amount = response?.items?.first?.amount else {
                XCTFail("Amount was not available in response")
                return
            }
            
            let collection = self.judo.collection(withReceiptId: receiptId, amount: amount)
            
            collection.send(completion: { (response, error) -> () in
                
                if let error = error {
                    XCTFail("api call failed with error: \(error)")
                }
                
                XCTAssertNotNil(response,
                                "Response must not be nil on valid Collection configuration")
                
                XCTAssertNotNil(response?.items?.first,
                                "Response must contain at least one JPTransactionData object on valid Collection configuration")
                
                expectation.fulfill();
            })
            
            XCTAssertNotNil(collection)
        }
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
    /**
     * GIVEN: I intantiate a Collection with an invalid receipt ID
     *
     * WHEN:  I perform a collection with the receipt ID and the amount
     *
     * THEN:  I should receive an error and no response
     */
    func test_OnCollectionCreation_WithInvalidReceiptAndAmount_ReturnNil() {
        
        let expectation = self.expectation(description: "testCollection")
        
        let collection = self.judo.collection(withReceiptId: "invalid-receipt-id",
                                              amount: JPAmount(amount: "0.01", currency: "GBP"))
        
        collection.send(completion: { [weak self] (response, error) -> () in
            
            XCTAssertNil(response,
                            "Response must be nil on invalid Collection configuration")
            
            self?.assert(error: error, as: .errorUncaught_Error)
            
            expectation.fulfill();
        })
        
        self.waitForExpectations(timeout: 30, handler: nil)
    }
    
}
