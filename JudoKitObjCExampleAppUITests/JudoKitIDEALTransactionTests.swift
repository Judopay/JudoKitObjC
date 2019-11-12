//
//  JudoKitIDEALTransactionTests.swift
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

class JudoKitIDEALTransactionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func test_OnLoad_DisplayIDEALOptions() {
        let app = XCUIApplication();
        XCTAssert(app.tables.staticTexts["iDEAL Transaction"].exists)
    }
    
    func test_OnNoBankSelected_DoNotDisplayPayButton() {
        let app = XCUIApplication()
        app.tables.staticTexts["iDEAL Transaction"].tap()
        
        XCTAssertTrue(app.staticTexts["Select iDEAL bank"].exists)
        XCTAssertFalse(app.staticTexts["Selected bank:"].exists)
        XCTAssertTrue(app.navigationBars.buttons["Pay"].exists)
        XCTAssertFalse(app.navigationBars.buttons["Pay"].isEnabled)
    }
    
    func test_OnBankSelection_DisplayBankList() {
        let app = XCUIApplication()
        app.tables.staticTexts["iDEAL Transaction"].tap()
        app.staticTexts["Select iDEAL bank"].tap()
        let idealCells = app.tables.cells.containing(.cell, identifier: "IDEALBankCell")
        XCTAssertEqual(idealCells.count, 12);
    }
    
    func test_OnBankSelection_EnablePayButton() {
        let app = XCUIApplication()
        app.tables.staticTexts["iDEAL Transaction"].tap()
        app.staticTexts["Select iDEAL bank"].tap()
        app.cells.firstMatch.tap()
        
        XCTAssertTrue(app.staticTexts["Selected bank:"].exists)
        XCTAssertFalse(app.staticTexts["Select iDEAL bank"].exists)
        
        XCTAssertTrue(app.navigationBars.buttons["Pay"].exists)
        XCTAssertTrue(app.navigationBars.buttons["Pay"].isEnabled)
        
        XCTAssertTrue(app.buttons["Pay Button"].exists)
        XCTAssertTrue(app.buttons["Pay Button"].isEnabled)
    }
    
}
