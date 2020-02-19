//
//  ListTests.swift
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

class ListTests: JudoTestCase {
    
    func testJudoListPayments() {
        let expectation = self.expectation(description: "list all payments expectation")
        
        self.judo.list(JPPayment.self, paginated: nil, completion: { (response, error) in
            if let error = error {
                XCTFail("api call failed with error: \(error)")
            }
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: kTestCaseTimeout, handler: nil)
    }
    
    func testJudoPaginatedListPayments() {
        // Given
        let offset = 3
        let pageSize = 5
        let pagination = JPPagination(offset: NSNumber(value: offset), pageSize: NSNumber(value: pageSize), sort: "time-descending")
        
        let expectation = self.expectation(description: "list all payments for given pagination")
        
        // When
        self.judo.list(JPPayment.self, paginated: pagination, completion: { (response, error) in
            // Then
            if let error = error {
                XCTFail("api call failed with error: \(error)")
            } else {
//                XCTAssertEqual(response!.items!.count, pageSize)
                XCTAssertEqual(response!.pagination!.offset, offset)
            }
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: kTestCaseTimeout, handler: nil)
    }
    
    
    func testJudoListPreAuths() {
        
        let expectation = self.expectation(description: "list all preauths expectation")
        
        self.judo.list(JPPreAuth.self, paginated: nil, completion: { (response, error) in
            if let error = error {
                XCTFail("api call failed with error: \(error)")
            }
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: kTestCaseTimeout, handler: nil)
    }
    
}
