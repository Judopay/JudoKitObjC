//
//  JudoKitAddCardTests.swift
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

class JudoKitAddCardTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func test_OnSaveCardTap_DisplayAddCardFlow() {
        let app = XCUIApplication()
        app.tables.staticTexts["Save card"].tap()
        
        XCTAssertTrue(app.textFields["Card Number"].exists)
        XCTAssertTrue(app.textFields["Cardholder Name"].exists)
        XCTAssertTrue(app.textFields["MM/YY"].exists)
        XCTAssertTrue(app.textFields["CVV"].exists)
        XCTAssertTrue(app.buttons["ADD CARD"].exists)
        XCTAssertTrue(app.buttons["Cancel"].exists)
        XCTAssertFalse(app.buttons["ADD CARD"].isEnabled)
    }
    
    func test_OnInvalidCardDetails_DisableAddCardButton() {
        let app = XCUIApplication()
        app.tables.staticTexts["Save card"].tap()
        
        app.textFields["Card Number"].tap()
        app.textFields["Card Number"].typeText("4141 4141 4141 4141")
        
        app.textFields["Cardholder Name"].tap()
        app.textFields["Cardholder Name"].typeText("Hello")
        
        app.textFields["MM/YY"].tap()
        app.textFields["MM/YY"].typeText("11/19")
        
        app.textFields["CVV"].tap()
        app.textFields["CVV"].typeText("123")
        
        XCTAssertFalse(app.buttons["ADD CARD"].isEnabled)
    }
    
    func test_OnValidCardDetails_EnableAddCardButton() {
        let app = XCUIApplication()
        app.tables.staticTexts["Save card"].tap()
        
        app.textFields["Card Number"].tap()
        app.textFields["Card Number"].typeText("4111 1111 1111 1111")
        
        app.textFields["Cardholder Name"].tap()
        app.textFields["Cardholder Name"].typeText("Hello")
        
        app.textFields["MM/YY"].tap()
        app.textFields["MM/YY"].typeText("12/20")
        
        app.textFields["CVV"].tap()
        app.textFields["CVV"].typeText("341")
        
        XCTAssertTrue(app.buttons["ADD CARD"].isEnabled)
    }
    
    func test_OnCancelButtonTap_DismissAddCardView() {
        let app = XCUIApplication()
        app.tables.staticTexts["Save card"].tap()
        app.buttons["Cancel"].tap()
        
        XCTAssertFalse(app.textFields["Card Number"].exists)
        XCTAssertFalse(app.textFields["Cardholder Name"].exists)
        XCTAssertFalse(app.textFields["MM/YY"].exists)
        XCTAssertFalse(app.textFields["CVV"].exists)
        XCTAssertFalse(app.buttons["ADD CARD"].exists)
        XCTAssertFalse(app.buttons["Cancel"].exists)
    }
    
    func test_OnAVSEnabled_DisplayCountryAndPostcode() {
        let app = XCUIApplication()
        app.buttons["Settings"].tap()
        app.switches.firstMatch.tap()
        app.buttons["Close"].tap()
        app.tables.staticTexts["Save card"].tap()
        
        XCTAssertTrue(app.textFields["Country"].exists)
        XCTAssertTrue(app.textFields["Postcode"].exists)
    }
    
    func test_OnAVSEnabled_ValidateCountryAndPostcode() {
        let app = XCUIApplication()
        app.buttons["Settings"].tap()
        app.switches.firstMatch.tap()
        app.buttons["Close"].tap()
        app.tables.staticTexts["Save card"].tap()
        
        app.textFields["Card Number"].tap()
        app.textFields["Card Number"].typeText("4111 1111 1111 1111")
        
        app.textFields["Cardholder Name"].tap()
        app.textFields["Cardholder Name"].typeText("Hello")
        
        app.textFields["MM/YY"].tap()
        app.textFields["MM/YY"].typeText("12/20")
        
        app.textFields["CVV"].tap()
        app.textFields["CVV"].typeText("341")
        
        XCTAssertFalse(app.buttons["ADD CARD"].isEnabled)
    }
    
}
