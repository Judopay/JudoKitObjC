//
//  JudoKitPaymentMethodsTests.swift
//  JudoKitSwiftExample
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

class JudoKitPaymentMethodsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchEnvironment = ["UITEST":"1"]
        app.launch()
    }
    
    func test_OnPaymentMethodSelection_DisplayPaymentMethodScreen() {
        let app = XCUIApplication();
        app.tables.staticTexts["Payment Method"].tap();
        
        XCTAssertTrue(app.staticTexts["Choose a Payment Method"].exists)
        XCTAssertTrue(app.staticTexts["You will pay"].exists)
        XCTAssertTrue(app.staticTexts["£0.01"].exists)
        XCTAssertTrue(app.staticTexts["You didn't connect any cards yet"].exists)
        
        XCTAssertFalse(app.buttons["PAY NOW"].isEnabled)
    }
    
    func test_OnSuccessfulAddCard_DisplayCardInList() {
        let app = XCUIApplication();
        app.tables.staticTexts["Payment Method"].tap();
        app.buttons["ADD CARD"].tap();
        
        enterCardDetails()
        
        XCTAssertTrue(app.staticTexts["Card for shopping"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Visa Ending 1111"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Connected cards"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["EDIT"].isEnabled)
        XCTAssertTrue(app.buttons["ADD CARD"].isEnabled)
    }
    
    func test_OnCardSelection_DisplayHeader() {
        
        let app = XCUIApplication();
        app.tables.staticTexts["Payment Method"].tap();
        app.buttons["ADD CARD"].tap();
        
        enterCardDetails()
        
        app.cells.staticTexts["Card for shopping"].firstMatch.tap()
        
        XCTAssertTrue(app.staticTexts["•••• •••• •••• 1111"].waitForExistence(timeout: 3.0))
        XCTAssertTrue(app.staticTexts["12/20"].waitForExistence(timeout: 3.0))
    }
    
    func enterCardDetails() {
        
        let app = XCUIApplication()
        
        app.textFields["Card Number"].tap()
        app.textFields["Card Number"].typeText("4111 1111 1111 1111")
        
        app.textFields["Cardholder Name"].tap()
        app.textFields["Cardholder Name"].typeText("Hello")
        
        app.textFields["MM/YY"].tap()
        app.textFields["MM/YY"].typeText("12/20")
        
        app.textFields["CVV"].tap()
        app.textFields["CVV"].typeText("341")
        
        app.buttons["ADD CARD"].firstMatch.tap();
    }
}
