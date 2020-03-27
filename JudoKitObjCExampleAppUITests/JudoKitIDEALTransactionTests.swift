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
    
    override func tearDown() {
        deleteApp();
        super.tearDown();
    }
    
    func deleteApp() {
        XCUIApplication().terminate()
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let icon = springboard.icons["JudoKitObjCExampleApp"]
        if icon.exists {
            let iconFrame = icon.frame
            let springboardFrame = springboard.frame
            icon.press(forDuration: 4)

            springboard.coordinate(withNormalizedOffset: CGVector(dx: (iconFrame.minX + 3) / springboardFrame.maxX, dy: (iconFrame.minY + 3) / springboardFrame.maxY)).tap()

            
            let deleteButton = springboard.alerts.buttons["Delete"]
            let existsPredicate = NSPredicate(format: "exists == 1")
            
            expectation(for: existsPredicate, evaluatedWith: deleteButton, handler: nil)
            waitForExpectations(timeout: kTestCaseTimeout, handler: nil)
            
            deleteButton.tap()
        }
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
        
        
        if (app.staticTexts["Select iDEAL bank"].exists) {
            app.staticTexts["Select iDEAL bank"].tap()
            let idealCells = app.tables.cells.containing(.cell, identifier: "IDEALBankCell")
            idealCells.firstMatch.tap()
        }
        
        XCTAssertTrue(app.staticTexts["Selected bank:"].exists)
        XCTAssertFalse(app.staticTexts["Select iDEAL bank"].exists)
        
        app.textFields.firstMatch.tap()
        app.textFields.firstMatch.typeText("iDEAL Bank")
        
        XCTAssertTrue(app.navigationBars.buttons["Pay"].exists)
        XCTAssertTrue(app.navigationBars.buttons["Pay"].isEnabled)
        
        XCTAssertTrue(app.buttons["Pay Button"].exists)
        XCTAssertTrue(app.buttons["Pay Button"].isEnabled)
    }
    
}
