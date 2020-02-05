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

        enterCardDetails(with: "4976 0000 0000 3436")

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

        enterCardDetails(with: "4976 0000 0000 3436")

        app.cells.staticTexts["Card for shopping"].firstMatch.tap()

        XCTAssertTrue(app.staticTexts["•••• •••• •••• 1111"].waitForExistence(timeout: 3.0))
        XCTAssertTrue(app.staticTexts["12/20"].waitForExistence(timeout: 3.0))
    }

    func test_OnSuccessfulPayment_DismissPaymentMethodScreen() {

        let app = XCUIApplication();
        app.tables.staticTexts["Payment Method"].tap()
        app.buttons["ADD CARD"].tap()

        enterCardDetails(with: "4976 0000 0000 3436")

        app.cells.staticTexts["Card for shopping"].firstMatch.tap()
        app.buttons["PAY NOW"].tap();

        XCTAssertTrue(app.tables.staticTexts["Payment Method"].waitForExistence(timeout: 30))
    }

    func test_OnFailedPayment_DisplayAlert() {
        let app = XCUIApplication();
        app.tables.staticTexts["Payment Method"].tap();
        app.buttons["ADD CARD"].tap();

        enterCardDetails(with: "4111 1111 1111 1111")

        app.cells.staticTexts["Card for shopping"].firstMatch.tap()
        app.buttons["PAY NOW"].tap();

        XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 30))
    }

    func test_swipeToDeletCard(){
        let app = XCUIApplication();
        app.tables.staticTexts["Payment Method"].tap()
        app.buttons["ADD CARD"].tap()
        enterCardDetails(with: "4976 0000 0000 3436")

        app.buttons["ADD CARD"].tap()
        enterCardDetails(with: "4111 1111 1111 1111")
        sleep(1)
        app.cells.staticTexts["Card for shopping"].firstMatch.tap()
        XCTAssert(app.tables.cells.count == 5, "table view has \(app.tables.cells.count)")

        let tablesQuery = app.tables.cells
        sleep(1)
        tablesQuery.element(boundBy: 3).swipeLeft()
        tablesQuery.element(boundBy: 3).buttons["Delete"].tap()
        sleep(1)
        app.alerts.buttons["Delete"].tap()
        sleep(1)

        XCTAssert(app.tables.children(matching: .cell).count == 4, "table view has \(app.tables.children(matching: .cell).count) cells")
    }

    func test_editToDeleteCard(){
        let app = XCUIApplication();
        app.tables.staticTexts["Payment Method"].tap()
        app.buttons["ADD CARD"].tap()
        enterCardDetails(with: "4976 0000 0000 3436")

        app.buttons["ADD CARD"].tap()
        enterCardDetails(with: "4111 1111 1111 1111")
        sleep(1)
        app.cells.staticTexts["Card for shopping"].firstMatch.tap()
        XCTAssert(app.tables.cells.count == 5, "table view has \(app.tables.cells.count)")

        let tablesQuery = app.tables.cells
        let editButton = tablesQuery.buttons["EDIT"]
        editButton.tap()
        tablesQuery.buttons["Delete Card for shopping, Visa Ending 3436"].tap()
        tablesQuery.buttons["trailing0"].tap()
        sleep(1)
        app.alerts.buttons["Delete"].tap()
        tablesQuery.buttons["DONE"].tap()
        XCTAssert(app.tables.children(matching: .cell).count == 4, "table view has \(app.tables.children(matching: .cell).count) cells")
        
        editButton.tap()
        tablesQuery.buttons["Delete Card for shopping, Visa Ending 1111"].tap()
        tablesQuery.buttons["trailing0"].tap()
        app.alerts.buttons["Delete"].tap()
        XCTAssert(app.tables.children(matching: .cell).count == 2, "table view has \(app.tables.children(matching: .cell).count) cells")
    }

    func enterCardDetails(with number:String) {

        let app = XCUIApplication()

        app.textFields["Card Number"].tap()
        app.textFields["Card Number"].typeText(number)

        app.textFields["Cardholder Name"].tap()
        app.textFields["Cardholder Name"].typeText("Hello")

        app.textFields["MM/YY"].tap()
        app.textFields["MM/YY"].typeText("1220")

        app.textFields["CVV"].tap()
        app.textFields["CVV"].typeText("452")

        app.buttons["ADD CARD"].firstMatch.tap()
    }
}
