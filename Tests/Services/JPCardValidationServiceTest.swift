//
//  JPCardValidationServiceTest.swift
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

class JPCardValidationServiceTest: XCTestCase {
    
    let cardValidationService = JPCardValidationService()
    
    func testValidateCardNumberInputForSupportedCardNetworksValid(){
        let validationResult =  self.cardValidationService.validateCardNumberInput("4532152527461378",
                                                                                   forSupportedNetworks: .networkVisa)
        XCTAssertEqual(validationResult!.isValid, true)
        XCTAssertEqual(validationResult!.isInputAllowed, true)
        XCTAssertEqual(validationResult!.errorMessage, nil)
        XCTAssertEqual(validationResult!.cardNetwork, CardNetwork.networkVisa)
        XCTAssertEqual(validationResult!.formattedInput, "4532 1525 2746 1378")
    }
    
    func testValidateCardNumberInputForSupportedCardNetworksUnknownCardNetwork(){
        let validationResult =  self.cardValidationService.validateCardNumberInput("96210017863322",
                                                                                   forSupportedNetworks: .networksAll)
        XCTAssertEqual(validationResult!.isValid, false)
        XCTAssertEqual(validationResult!.isInputAllowed, true)
        XCTAssertEqual(validationResult!.errorMessage, nil)
        XCTAssertEqual(validationResult!.cardNetwork, CardNetwork.init(rawValue: 0))
        XCTAssertEqual(validationResult!.formattedInput, "96210017863322")
    }
    
    func testValidateCardNumberInputForSupportedCardNetworksSpecificLength(){
        let validationResult =  self.cardValidationService.validateCardNumberInput("1234567890987654",
                                                                                   forSupportedNetworks: .networksAll)
        XCTAssertEqual(validationResult!.isValid, false)
        XCTAssertEqual(validationResult!.isInputAllowed, true)
        XCTAssertEqual(validationResult!.errorMessage, "Unknown Card Network is not supported")
        XCTAssertEqual(validationResult!.cardNetwork, CardNetwork.init(rawValue: 0))
        XCTAssertEqual(validationResult!.formattedInput, "1234567890987654")
    }
    
    
    func testValidateCarholderNameInputValid(){
        let validationResult = self.cardValidationService.validateCarholderNameInput("John Doe")
        XCTAssertTrue(validationResult!.isValid)
    }
    
    func testValidateCarholderNameInputInvalid(){
        let validationResult = self.cardValidationService.validateCarholderNameInput("Joe")
        XCTAssertFalse(validationResult!.isValid)
    }
    
    func testValidateExpiryDateInputValid() {
        let validationResult = self.cardValidationService.validateExpiryDateInput("09/224")
        XCTAssertTrue(validationResult!.isValid)
    }
    
    func testValidateExpiryDateInputInvalid() {
        var validationResult = self.cardValidationService.validateExpiryDateInput("")
        XCTAssertFalse(validationResult!.isValid)
        validationResult = self.cardValidationService.validateExpiryDateInput("2")
        XCTAssertFalse(validationResult!.isValid)
        validationResult = self.cardValidationService.validateExpiryDateInput("22")
        XCTAssertFalse(validationResult!.isValid)
        validationResult = self.cardValidationService.validateExpiryDateInput("22/")
        XCTAssertFalse(validationResult!.isValid)
        validationResult = self.cardValidationService.validateExpiryDateInput("22/1")
        XCTAssertFalse(validationResult!.isValid)
        validationResult = self.cardValidationService.validateExpiryDateInput("20/12")
        XCTAssertFalse(validationResult!.isValid)
    }
    
    func testValidateSecureCodeInputValid(){
        let validationResult = self.cardValidationService.validateSecureCodeInput("123")
        XCTAssertTrue(validationResult!.isValid)
    }
    
    func testValidateSecureCodeInputInvalid(){
        cardValidationService.validateCardNumberInput("4532152527461378", forSupportedNetworks: .networksAll)
        var validationResult = self.cardValidationService.validateSecureCodeInput("122")
        validationResult = cardValidationService.validateSecureCodeInput("12223")
        XCTAssertTrue(validationResult!.isValid)
    }
    
    func testValidateCountryInputValid() {
        let validationResult = self.cardValidationService.validateCountryInput("US")
        XCTAssertTrue(validationResult!.isValid)
        
    }
    
    func testValidateCountryInputInvalid() {
        let validationResult = self.cardValidationService.validateCountryInput("MOLDOVA")
        XCTAssertTrue(validationResult!.isValid)
    }
    
    func testValidatePostalCodeInputUKInvalid() {
        self.cardValidationService.validateCountryInput("UK")
        let validationResult = cardValidationService.validatePostalCodeInput("ND3100")
        XCTAssertFalse(validationResult!.isValid)
    }
    
    func testValidatePostalCodeInputUKValid() {
        self.cardValidationService.validateCountryInput("UK")
        let validationResult = cardValidationService.validatePostalCodeInput("BL9 5QU")
        XCTAssertTrue(validationResult!.isValid)
    }
    
    
    func testValidatePostalCodeInputUSAInvalid() {
        self.cardValidationService.validateCountryInput("USA")
        let validationResult = cardValidationService.validatePostalCodeInput("ND310")
        XCTAssertFalse(validationResult!.isValid)
    }
    
    func testValidatePostalCodeInputUSAValid() {
        self.cardValidationService.validateCountryInput("USA")
        let validationResult = cardValidationService.validatePostalCodeInput("98513")
        XCTAssertTrue(validationResult!.isValid)
    }
    
    
    func testValidatePostalCodeInputCanadaInvalid() {
        self.cardValidationService.validateCountryInput("Canada")
        let validationResult = cardValidationService.validatePostalCodeInput("ND310")
        XCTAssertFalse(validationResult!.isValid)
    }
    
    func testValidatePostalCodeInputCanadaValid() {
        self.cardValidationService.validateCountryInput("Canada")
        let validationResult = self.cardValidationService.validatePostalCodeInput("H3J 2T4")
        XCTAssertTrue(validationResult!.isValid)
    }
    
    func testValidatePostalCodeInputOtherValid(){
        self.cardValidationService.validateCountryInput("Other")
        let validationResult = cardValidationService.validatePostalCodeInput("MD3100")
        XCTAssertTrue(validationResult!.isValid)
    }

}
