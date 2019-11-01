//
//  PostCodeValidationTests.swift
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
@testable import JudoKitObjC

class PostCodeValidationTests: XCTestCase {
    
    func test_OnValidUKPostcode_ReturnTrue() {
        let postcodeInputField = PostCodeInputField()
        postcodeInputField.billingCountry = BillingCountry.UK
        postcodeInputField.textField.text = "FK208QT"
        XCTAssertTrue(postcodeInputField.isValid)
    }
    
    func test_OnInvalidUKPostcode_ReturnFalse() {
        let postcodeInputField = PostCodeInputField()
        postcodeInputField.billingCountry = BillingCountry.UK
        postcodeInputField.textField.text = "ABCDEF"
        XCTAssertFalse(postcodeInputField.isValid)
    }
    
    func test_OnValidCanadaPostcode_ReturnTrue() {
        let postcodeInputField = PostCodeInputField()
        postcodeInputField.billingCountry = BillingCountry.canada
        postcodeInputField.textField.text = "K1A0B1"
        XCTAssertTrue(postcodeInputField.isValid)
    }
    
    func test_OnInvalidCanadaPostcode_ReturnFalse() {
        let postcodeInputField = PostCodeInputField()
        postcodeInputField.billingCountry = BillingCountry.canada
        postcodeInputField.textField.text = "Z1AD11"
        XCTAssertFalse(postcodeInputField.isValid)
    }
    
    func test_OnValidUSPostcode_ReturnTrue() {
        let postcodeInputField = PostCodeInputField()
        postcodeInputField.billingCountry = BillingCountry.USA
        postcodeInputField.textField.text = "85055"
        XCTAssertTrue(postcodeInputField.isValid)
    }
    
    func test_OnInvalidUSPostcode_ReturnFalse() {
        let postcodeInputField = PostCodeInputField()
        postcodeInputField.billingCountry = BillingCountry.USA
        postcodeInputField.textField.text = "ABC123"
        XCTAssertFalse(postcodeInputField.isValid)
    }
    
    func test_OnValidOtherPostcode_ReturnTrue() {
        let postcodeInputField = PostCodeInputField()
        postcodeInputField.billingCountry = BillingCountry.other
        postcodeInputField.textField.text = "123456"
        XCTAssertTrue(postcodeInputField.isValid)
    }
    
    func test_OnInvalidOtherPostcode_ReturnFalse() {
        let postcodeInputField = PostCodeInputField()
        postcodeInputField.billingCountry = BillingCountry.other
        postcodeInputField.textField.text = "A12345"
        XCTAssertFalse(postcodeInputField.isValid)
    }
}
