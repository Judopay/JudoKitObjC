//
//  JudoKitCheckCardTests.swift
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

class JudoKitCheckCardTests: XCTestCase {

    private let existsPredicate = NSPredicate(format: "exists == 1")
    
    override func setUp() {
        super.setUp();
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func test_OnCheckCardTap_DisplayCheckCardForm() {
        let app = XCUIApplication()
        app.tables.staticTexts["Check card"].tap()
        XCTAssertTrue(app.navigationBars["Check Card"].exists);
    }
    
    func test_OnCheckCardValidParameters_DisplayDetailsScreen() {
        let app = XCUIApplication()
        app.tables.staticTexts["Check card"].tap()
        
        app.secureTextFields["Card number"].typeText("4976000000003436")
        app.textFields["Expiry date"].typeText("1220")
        app.secureTextFields["CVV2"].typeText("452")

        app.buttons["Pay"].firstMatch.tap()
        
        let cardDetailsNavigation = app.navigationBars["Payment receipt"]
        
        let detailsExpectation = expectation(for: existsPredicate,
                                             evaluatedWith: cardDetailsNavigation,
                                             handler: nil)
        
        wait(for: [detailsExpectation], timeout: 20.0)
    }
    
    func test_OnCheckCardInvalidParameters_DisplayErrorAlert() {
        let app = XCUIApplication()
        app.tables.staticTexts["Check card"].tap()
        
        app.secureTextFields["Card number"].typeText("5500 0000 0000 0004")
        app.textFields["Expiry date"].typeText("1228")
        app.secureTextFields["CVC2"].typeText("999")

        app.buttons["Pay"].firstMatch.tap()
        
        let errorAlert = app.alerts.firstMatch.staticTexts["Error"];
        
        let errorAlertExpectation = expectation(for: existsPredicate,
                                                evaluatedWith: errorAlert,
                                                handler: nil)
        
        wait(for: [errorAlertExpectation], timeout: 20.0)
    }
}
