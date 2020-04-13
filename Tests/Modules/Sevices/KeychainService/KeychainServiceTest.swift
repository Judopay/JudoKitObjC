//
//  KeychainServiceTest.swift
//  JudoKitObjCTests
//
//  Created by Andrei Galkin on 4/10/20.
//  Copyright © 2020 Judo Payments. All rights reserved.
//

import XCTest
@testable import JudoKitObjC

class KeychainServiceTest: XCTestCase {
    
    func testSaveObject_withString() throws {
        let saveResult = JPKeychainService.save("testObject", forKey: "testKey")
        
        XCTAssertTrue(saveResult)
        XCTAssertEqual(JPKeychainService.getObjectForKey("testKey") as! String, "testObject")
    }
    
    func testSaveObject_withStringDoubleTime() throws {
        let saveResult = JPKeychainService.save("testObject", forKey: "testKey")
        
        XCTAssertTrue(saveResult)
        XCTAssertEqual(JPKeychainService.getObjectForKey("testKey") as! String, "testObject")
        
        let saveSuccessivelyResult = JPKeychainService.save("testObject2", forKey: "testKey")
        
        XCTAssertTrue(saveSuccessivelyResult)
        XCTAssertEqual(JPKeychainService.getObjectForKey("testKey") as! String, "testObject2")
    }
    
    func testSaveObject_withArray() throws {
        let saveResult = JPKeychainService.save(["test1", "test2", "test3"], forKey: "testKey")
        
        XCTAssertTrue(saveResult)
        XCTAssertEqual(JPKeychainService.getObjectForKey("testKey") as! Array<String>, ["test1", "test2", "test3"])
    }
    
    func testSaveObject_withDict() throws {
        let testDict = [ "testKey": "testValue",
                         "testObject": [ "testInternalKey": "testInternalObject" ]] as [String : Any]
        let saveResult = JPKeychainService.save(testDict, forKey: "testKey")
        
        XCTAssertTrue(saveResult)
        
        let dictObject = (JPKeychainService.getObjectForKey("testKey") as! [String: Any])
        
        XCTAssertEqual(dictObject["testKey"] as! String, "testValue")
        XCTAssertEqual(dictObject["testObject"] as! [String: String], [ "testInternalKey": "testInternalObject" ])
    }
    
    func testSaveObject_withEncodableObject() throws {
        let cardDetails = JPCardDetails(cardNumber: "1234 2345", expiryMonth: 10, expiryYear: 1990)
        let saveResult = JPKeychainService.save(cardDetails, forKey: "testKey")
        
        XCTAssertTrue(saveResult)
        
        let cardDetailsObject = (JPKeychainService.getObjectForKey("testKey") as! JPCardDetails)
        
        XCTAssertEqual(cardDetailsObject.cardNumber, nil)
        XCTAssertEqual(cardDetailsObject.endDate, "10/90")
    }
    
    func testDeleteObject() throws {
        let testDict = [ "testKey": "testValue"] as [String : String]
        let saveResult = JPKeychainService.save(testDict, forKey: "testKey")
        
        XCTAssertTrue(saveResult)
        
        let deleteResult = JPKeychainService.deleteObject(forKey: "testKey")
        
        XCTAssertTrue(deleteResult)
        XCTAssertNil(JPKeychainService.getObjectForKey("testKey"))
        
        let deleteSuccessivelyResult = JPKeychainService.deleteObject(forKey: "testKey")
        
        XCTAssertFalse(deleteSuccessivelyResult)
    }

}
