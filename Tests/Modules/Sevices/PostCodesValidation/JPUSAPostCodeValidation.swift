//
//  JPUSAPostCodeValidation.swift
//  JudoKitObjCTests
//
//  Copyright (c) 2020 Alternative Payments Ltd
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

class JPUSAPostCodeValidation: XCTestCase {
    let validationService = JPCardValidationService()
    var sut: JPTransactionInteractor! = nil
    let configuration = JPConfiguration(judoID: "judoId",
                                        amount: JPAmount("0.01", currency: "GBR"),
                                     reference: JPReference(consumerReference: "consumerReference"))

    override func setUp() {
        configuration.supportedCardNetworks = [.networkVisa, .networkMasterCard, .networkAMEX, .networkDinersClub]
        validationService.validateCountryInput("USA")
        sut = JPTransactionInteractorImpl(cardValidationService: validationService, transactionService: nil, configuration:configuration, completion: nil)
    }
    
    func testValidCode_US() {
        let result = sut.validatePostalCodeInput("12345")
        XCTAssertTrue(result!.isValid)
    }
    
    func testValidCodeWithSpaces_US() {
        let result = sut.validatePostalCodeInput("12345-6789")
        XCTAssertTrue(result!.isValid)
    }
    
    func testInValidCodeMiddleCharacter_US() {
        let result = sut.validatePostalCodeInput("1234@")
        XCTAssertFalse(result!.isValid)
    }
    
    func testInValidCodeShort_US() {
        let result = sut.validatePostalCodeInput("1234")
        XCTAssertFalse(result!.isValid)
    }
    
    func testInValidLastCharatcer_US() {
        let result = sut.validatePostalCodeInput("12345-678@")
        XCTAssertFalse(result!.isValid)
    }
    
    func testInValidCodeWithSpaces_US() {
        let result = sut.validatePostalCodeInput("12345 6789")
        XCTAssertTrue(result!.isValid)
    }
    
    func testInValidCodeError_US() {
        let result = sut.validatePostalCodeInput("abcde-fghj")!
        XCTAssertEqual(result.errorMessage, "Invalid ZIP code entered")
        XCTAssertFalse(result.isValid)
    }
    
    func testEmptyCode_US() {
        let result = sut.validatePostalCodeInput("")
        XCTAssertFalse(result!.isValid)
    }
}
