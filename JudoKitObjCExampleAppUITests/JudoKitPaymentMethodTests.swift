//
//  JudoKitPaymentMethodTests.swift
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

class JudoKitPaymentMethodTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testTappingOnPaymentMethodNavigatesToPaymentMethodScreen() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Payment Method"].tap()

        let navigation = app.navigationBars["Payment Method"]
        let existsPredicate = NSPredicate(format: "exists == 1")

        expectation(for: existsPredicate, evaluatedWith: navigation, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPaymentMethodScreenPresentedWithDefaultSettingsContainsAllOptions() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Payment Method"].tap()

        let cardPaymentButton = app.buttons["Card Payment"]
        let applePayButton = app.buttons["Buy with Apple Pay"]
        let headingLabel = app.staticTexts["Please select from one of the payment methods listed below:"]

        let existsPredicate = NSPredicate(format: "exists == 1")

        expectation(for: existsPredicate, evaluatedWith: cardPaymentButton, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: applePayButton, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: headingLabel, handler: nil)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testTappingOnCardPaymentButtonNavigatesToCardDetailsInputScreen() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Payment Method"].tap()

        app.buttons["Card Payment"].tap()

        let navigation = app.navigationBars["Payment"]
        let existsPredicate = NSPredicate(format: "exists == 1")

        expectation(for: existsPredicate, evaluatedWith: navigation, handler: nil)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testTappingBackButtonFromCardDetailsInputScreenUserGoBackToPaymentMethodScreen() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Payment Method"].tap()

        app.buttons["Card Payment"].tap()

        app.buttons["Back"].tap()

        let navigation = app.navigationBars["Payment Method"]
        let existsPredicate = NSPredicate(format: "exists == 1")

        expectation(for: existsPredicate, evaluatedWith: navigation, handler: nil)
         waitForExpectations(timeout: 20, handler: nil)
    }

    func testTappingOnPaymentMethodNavigatesToPaymentMethodScreenAndVISAPaymentSucceedes() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Payment Method"].tap()

        app.buttons["Card Payment"].tap()

        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.secureTextFields["Card number"].typeText("4976000000003436")

        let expiryDateTextField = elementsQuery.textFields["Expiry date"]
        expiryDateTextField.typeText("1220")

        let cvv2TextField = elementsQuery.secureTextFields["CVV2"]
        cvv2TextField.typeText("452")

        app.buttons.matching(identifier: "Pay").element(boundBy: 1).tap()

        let button = app.buttons["Home"]
        let existsPredicate = NSPredicate(format: "exists == 1")

        expectation(for: existsPredicate, evaluatedWith: button, handler: nil)
         waitForExpectations(timeout: 20, handler: nil)

        button.tap()
    }

}
