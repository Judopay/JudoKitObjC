//
//  TrackingTests.swift
//  JudoKitObjCTests
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
@testable import JudoKitObjC

class FieldTrackingTests : JudoTestCase {

    var sut = JPFieldTracking()
    var fieldSessions = [String:[JPTrackedField]]()
    var keystrokes = 0
    
    override func tearDown() {
        self.sut = JPFieldTracking()
        self.fieldSessions = [String:[JPTrackedField]]()
        self.keystrokes = 0
    }
    
    func simulateSession(fieldName: String, whenFocued: Date, whenEdited:[(String,Int,Date,Bool)]?, whenBlured: Date) {
        
        var sessions = [JPTrackedField]()
        var initialValue = ""
        
        if let fieldSessions = self.fieldSessions[fieldName] {
            sessions = fieldSessions
            let currentLength = sessions.last?.currentLength
            initialValue = String(repeating: "a", count: currentLength!)
        }
        else {
            sessions = [JPTrackedField]()
        }
        
        let trackedField = JPTrackedField()
        trackedField.whenFocused = self.dateToString(date: whenFocued)
        trackedField.isConsideredValid = false
        
        var pastedFields = [String]()
        
        self.sut.textFieldDidBeginEditing(self.generateField(name: fieldName, value: initialValue, isConsideredValid: false, dateOfAction: whenFocued))
        
        if let whenEdited = whenEdited {
            for (index, edit) in whenEdited.enumerated() {
                let (value, keyStrokes, edited, pasted) = edit
                
                if pasted {
                    pastedFields.append(self.dateToString(date: edited)!)
                }
            
                if index == 0 {
                    trackedField.whenEditingBegan = self.dateToString(date: edited)
                }
                
                self.sut.didChangeInputText(self.generateField(name: fieldName, value: value, isConsideredValid: false, dateOfAction: edited))
                
                trackedField.totalKeystrokes += keyStrokes
            }
        }

        trackedField.whenBlured = self.dateToString(date: whenBlured)
        self.sut.textFieldDidEndEditing(self.generateField(name: fieldName, value: "", isConsideredValid: false, dateOfAction: whenBlured))
    
        trackedField.whenPasted = NSMutableArray(array: pastedFields)
        
        sessions.append(trackedField)
        self.fieldSessions[fieldName] = sessions
    }
    
    func createFieldName() -> String {
        return UUID().uuidString
    }
    
    func test_FieldFocusShouldCreateNewFieldSession() {
        let fieldOneKey = self.createFieldName()
        
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: nil, whenBlured: Date())
        
        let expectedMetaData = JPFieldMetaDataGenerator.generate(as: self.fieldSessions)
        
        let actualMetaData = sut.trackingAsDictionary()
        
        self.assertMetaDataEqual(lhs: actualMetaData, rhs: expectedMetaData)
    }

    func test_WhenFieldSessionIsPresentFieldEditingMustUpdateThatFieldSession() {
        let fieldOneKey = self.createFieldName()
        
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: [("q",1,Date(),false)], whenBlured: Date())
        
        let expectedMetaData = JPFieldMetaDataGenerator.generate(as: self.fieldSessions)
        
        let actualMetaData = sut.trackingAsDictionary()
        
        self.assertMetaDataEqual(lhs: actualMetaData, rhs: expectedMetaData)
    }

    func test_WhenFieldSessionIsPresentFieldBluringMustUpdateThatFieldSession() {
        let fieldOneKey = self.createFieldName()
        
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: nil, whenBlured: Date())
        
        let expectedMetaData = JPFieldMetaDataGenerator.generate(as: self.fieldSessions)
        
        let actualMetaData = sut.trackingAsDictionary()
        
        self.assertMetaDataEqual(lhs: actualMetaData, rhs: expectedMetaData)
    }

    func test_FieldFocusAndFieldBluringSingleFieldNTimesMustCreateNDistinctFieldSessions() {
        let fieldOneKey = self.createFieldName()
        
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: nil, whenBlured: Date())
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: nil, whenBlured: Date())
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: nil, whenBlured: Date())
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: nil, whenBlured: Date())
        
        let expectedMetaData = JPFieldMetaDataGenerator.generate(as: self.fieldSessions)
        
        let actualMetaData = sut.trackingAsDictionary()
        
        self.assertMetaDataEqual(lhs: actualMetaData, rhs: expectedMetaData)
    }
    
    func test_TotalKeystrokesForAFieldMustBeTheAbsoluteSumOFIndividualFieldSessions() {
        let fieldOneKey = self.createFieldName()
        let fieldTwoKey = self.createFieldName()
        
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: [("q",1,Date(),false),("qw",1,Date(),false)], whenBlured: Date())
        self.simulateSession(fieldName: fieldTwoKey, whenFocued: Date(), whenEdited: [("h",1,Date(),false),("he",1,Date(),false),("hel",1,Date(),false),("hell",1,Date(),false)], whenBlured: Date())
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: [("qwe",1,Date(),false)], whenBlured: Date())
        
        let expectedMetaData = JPFieldMetaDataGenerator.generate(as: self.fieldSessions)
        
        let actualMetaData = sut.trackingAsDictionary()
        
        self.assertMetaDataEqual(lhs: actualMetaData, rhs: expectedMetaData)
    }
    
    func test_IncreasingFieldValueLengthByOneCharacterIsNotConsideredToBeAPastedEntry() {
        let fieldOneKey = self.createFieldName()
        
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: [("q",1,Date(),false)], whenBlured: Date())
        
        let expectedMetaData = JPFieldMetaDataGenerator.generate(as: self.fieldSessions)
        
        let actualMetaData = sut.trackingAsDictionary()
        
        //ass
        self.assertMetaDataEqual(lhs: actualMetaData, rhs: expectedMetaData)
    }
    
    func test_IncreasingFieldValueLengthByMoreThanOneCharacterIsConsideredToBeAPastedEntry() {
        let fieldOneKey = self.createFieldName()
        
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: [("qq",2,Date(),true)], whenBlured: Date())
        
        let expectedMetaData = JPFieldMetaDataGenerator.generate(as: self.fieldSessions)
        
        let actualMetaData = sut.trackingAsDictionary()
        
        //ass
        self.assertMetaDataEqual(lhs: actualMetaData, rhs: expectedMetaData)
    }
    
    func test_DecreasingFieldValueLengthByOneCharacterIsNotConsideredToBeAPastedEntry() {
        let fieldOneKey = self.createFieldName()
        
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: [("q",1,Date(),false),("qq",1,Date(),false),("q",1,Date(),false)], whenBlured: Date())
        
        let expectedMetaData = JPFieldMetaDataGenerator.generate(as: self.fieldSessions)
        
        let actualMetaData = sut.trackingAsDictionary()
        
        //ass
        self.assertMetaDataEqual(lhs: actualMetaData, rhs: expectedMetaData)
    }
    
    func test_DecreasingFieldValueLengthByMoreThanOneCharacterIsConsideredToBeAPastedEntry() {
        let fieldOneKey = self.createFieldName()
        
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: [("q",1,Date(),false),("qq",1,Date(),false),("",2,Date(),true)], whenBlured: Date())
        
        let expectedMetaData = JPFieldMetaDataGenerator.generate(as: self.fieldSessions)
        
        let actualMetaData = sut.trackingAsDictionary()
        
        //ass
        self.assertMetaDataEqual(lhs: actualMetaData, rhs: expectedMetaData)
    }
    
    func test_FieldFocusAndFieldBluringBetweenNDistinctFieldsResultsNDistinctFieldMetaDataEntries() {
        let fieldOneKey = self.createFieldName()
        let fieldTwoKey = self.createFieldName()
        let fieldThreeKey = self.createFieldName()
        
        self.simulateSession(fieldName: fieldOneKey, whenFocued: Date(), whenEdited: [("q",1,Date(),false)], whenBlured: Date())
        self.simulateSession(fieldName: fieldTwoKey, whenFocued: Date(), whenEdited: [("w",1,Date(),false)], whenBlured: Date())
        self.simulateSession(fieldName: fieldThreeKey, whenFocued: Date(), whenEdited: [("e",1,Date(),false)], whenBlured: Date())
        
        let expectedMetaData = JPFieldMetaDataGenerator.generate(as: self.fieldSessions)
        
        let actualMetaData = sut.trackingAsDictionary()
        
        self.assertMetaDataEqual(lhs: actualMetaData, rhs: expectedMetaData)
    }
    
    func assertMetaDataEqual(lhs: [String:Any], rhs: [String:Any]) {
        XCTAssertTrue(NSDictionary(dictionary: lhs).isEqual(to: rhs))
        
    }
    
    func generateField(name: String, value: String, isConsideredValid: Bool, dateOfAction: Date) -> JPField {
        return JPField(name: name, value: value, isConsideredValid: isConsideredValid, dateOfAction: dateOfAction)
    }
    
    func dateToString(date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormat.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        return dateFormat.string(from: date)
    }
}
