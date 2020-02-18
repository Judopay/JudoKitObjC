//
//  JudoKitTokenPaymentTests.swift
//  JudoKitSwiftExample
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

class JudoKitTokenPaymentTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testVISATokenPayment() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Register card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.secureTextFields["Card number"].typeText("4976000000003436")
        
        let expiryDateTextField = elementsQuery.textFields["Expiry date"]
        expiryDateTextField.typeText("1220")
        
        let cvv2TextField = elementsQuery.secureTextFields["CVV2"]
        cvv2TextField.typeText("452")
        
        app.buttons["Add card"].tap()
        
        let tableQuery = tablesQuery.staticTexts["Token payment"]
        let tableQueryExistsPredicate = NSPredicate(format: "exists == 1")
        
        expectation(for: tableQueryExistsPredicate, evaluatedWith: tableQuery, handler: nil)
        waitForExpectations(timeout: kTestCaseTimeout, handler: nil)
        
        tableQuery.tap()
        
        let cvv2TextField2 = elementsQuery.secureTextFields["CVV"]
        cvv2TextField2.typeText("452")
        
        app.buttons.matching(identifier: "Pay").element(boundBy: 1).tap()
        
        let button = app.buttons["Home"]
        let existsPredicate = NSPredicate(format: "exists == 1")
        
        expectation(for: existsPredicate, evaluatedWith: button, handler: nil)
        waitForExpectations(timeout: kTestCaseTimeout, handler: nil)
        
        button.tap()
    }
    
    func testMaestroTokenPayment() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Register card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.secureTextFields["Card number"].typeText("6759000000005462")
        
        let startDateTextField = elementsQuery.textFields["Start date"]
        startDateTextField.tap()
        startDateTextField.typeText("0110")
        
        let expiryDateTextField = elementsQuery.textFields["Expiry date"]
        expiryDateTextField.tap()
        expiryDateTextField.typeText("1220")
        
        let cvvTextField = elementsQuery.secureTextFields["CVV"]
        cvvTextField.typeText("789")
        
        app.buttons["Add card"].tap()
        
        let tableQuery = tablesQuery.staticTexts["Token payment"]
        let tableQueryExistsPredicate = NSPredicate(format: "exists == 1")
        
        expectation(for: tableQueryExistsPredicate, evaluatedWith: tableQuery, handler: nil)
        waitForExpectations(timeout: kTestCaseTimeout, handler: nil)
        
        tableQuery.tap()
        
        let startDateTextField2 = elementsQuery.textFields["Start date"]
        startDateTextField2.tap()
        startDateTextField2.typeText("0110")
        
        let cvvTextField2 = elementsQuery.secureTextFields["CVV"]
        cvvTextField2.tap()
        cvvTextField2.typeText("789")
        
        app.buttons.matching(identifier: "Pay").element(boundBy: 1).tap()
        
        let button = app.buttons["Home"]
        let existsPredicate = NSPredicate(format: "exists == 1")
        
        expectation(for: existsPredicate, evaluatedWith: button, handler: nil)
        waitForExpectations(timeout: kTestCaseTimeout, handler: nil)
        
        button.tap()
    }

    func testSaveCardWithVISATokenPayment() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Save card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.secureTextFields["Card number"].typeText("4976000000003436")

        let expiryDateTextField = elementsQuery.textFields["Expiry date"]
        expiryDateTextField.typeText("1220")

        let cvv2TextField = elementsQuery.secureTextFields["CVV2"]
        cvv2TextField.typeText("452")

        app.buttons["Add card"].tap()

        let tableQuery = tablesQuery.staticTexts["Token payment"]
        let tableQueryExistsPredicate = NSPredicate(format: "exists == 1")

        expectation(for: tableQueryExistsPredicate, evaluatedWith: tableQuery, handler: nil)
        waitForExpectations(timeout: 15, handler: nil)

        tableQuery.tap()

        let cvv2TextField2 = elementsQuery.secureTextFields["CVV"]
        cvv2TextField2.typeText("452")

        app.buttons.matching(identifier: "Pay").element(boundBy: 1).tap()

        let button = app.buttons["Home"]
        let existsPredicate = NSPredicate(format: "exists == 1")

        expectation(for: existsPredicate, evaluatedWith: button, handler: nil)
        waitForExpectations(timeout: kTestCaseTimeout, handler: nil)

        button.tap()
    }

    func testSaveCardWithMaestroTokenPayment() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Save card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.secureTextFields["Card number"].typeText("6759000000005462")

        let startDateTextField = elementsQuery.textFields["Start date"]
        startDateTextField.tap()
        startDateTextField.typeText("0110")

        let expiryDateTextField = elementsQuery.textFields["Expiry date"]
        expiryDateTextField.tap()
        expiryDateTextField.typeText("1220")

        let cvvTextField = elementsQuery.secureTextFields["CVV"]
        cvvTextField.typeText("789")

        app.buttons["Add card"].tap()

        let tableQuery = tablesQuery.staticTexts["Token payment"]
        let tableQueryExistsPredicate = NSPredicate(format: "exists == 1")

        expectation(for: tableQueryExistsPredicate, evaluatedWith: tableQuery, handler: nil)
        waitForExpectations(timeout: kTestCaseTimeout, handler: nil)

        tableQuery.tap()

        let startDateTextField2 = elementsQuery.textFields["Start date"]
        startDateTextField2.tap()
        startDateTextField2.typeText("0110")

        let cvvTextField2 = elementsQuery.secureTextFields["CVV"]
        cvvTextField2.tap()
        cvvTextField2.typeText("789")

        app.buttons.matching(identifier: "Pay").element(boundBy: 1).tap()

        let button = app.buttons["Home"]
        let existsPredicate = NSPredicate(format: "exists == 1")

        expectation(for: existsPredicate, evaluatedWith: button, handler: nil)
        waitForExpectations(timeout: kTestCaseTimeout, handler: nil)

        button.tap()
    }
}
