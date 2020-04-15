//
//  JPCanadaPostCodeValidation.swift
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

class JPCanadaPostCodeValidation: XCTestCase {
    var configuration: JPConfiguration! = nil
    let validationService = JPCardValidationService()
    var interactor: JPTransactionInteractor! = nil
    lazy var reference = JPReference(consumerReference: "consumerReference")
    
    override func setUp() {
        let amount = JPAmount("0.01", currency: "GBR")
        configuration = JPConfiguration(judoID: "judoId", amount: amount, reference: reference)
        configuration.supportedCardNetworks = [.networkVisa, .networkMasterCard, .networkAMEX, .networkDinersClub]
        validationService.validateCountryInput("Canada")
        interactor = JPTransactionInteractorImpl(cardValidationService: validationService, transactionService: nil, configuration:configuration, completion: nil)
    }
    
    func testValidCode_Canada() {
        let result = interactor.validatePostalCodeInput("A1A1A1")!
        XCTAssertEqual(result.formattedInput, "A1A 1A1")
        XCTAssertTrue(result.isValid)
    }
    
    func testValidCodeWithSpaces_Canada() {
        let result = interactor.validatePostalCodeInput("A1A 1A1")!
        XCTAssertEqual(result.formattedInput, "A1A 1A1")
        XCTAssertTrue(result.isValid)
    }
    
    func testInValidRegexSpecialSymbols_Canada() {
        let result = interactor.validatePostalCodeInput("A1! 1A1")!
        XCTAssertEqual(result.errorMessage, "Invalid postcode entered")
        XCTAssertFalse(result.isValid)
    }
    
    func testEmptyCode_Canada() {
        let result = interactor.validatePostalCodeInput("")
        XCTAssertFalse(result!.isValid)
    }
    
    func testInValidRegexUndersScore_Canada() {
        let result = interactor.validatePostalCodeInput("A11_1A1")!
        XCTAssertEqual(result.errorMessage, "Invalid postcode entered")
        XCTAssertFalse(result.isValid)
    }
}
