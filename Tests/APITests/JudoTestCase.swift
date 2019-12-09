//
//  JudoTestCase.swift
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

class JudoTestCase: XCTestCase {
    
    // Judo Session
    let judo = JudoKit(token: token, secret: secret)
    
    let invalidJudo = JudoKit(token: "a3xQdxP6iHdWg1zy",
                              secret: "2094c2f5484ba42557917aad2b2c2d294a35dddadb93de3c35d6910e6c461bfb")
    
    // Visa Card
    let validVisaTestCard = JPCard(cardNumber: "4976000000003436", cardholderName: nil, expiryDate: "12/20", secureCode: "452")
    let declinedVisaTestCard = JPCard(cardNumber: "4221690000004963", cardholderName: nil, expiryDate: "12/20", secureCode: "125")
    
    // VCO Result
    let validVCOResult = JPVCOResult(callId: "2587385100467218001",
                                     encryptedKey: "xJRr2tLAs0n0ztToEMhhG8ELBg3mi7TKLVuqn4pA3FAHhgvR29y1YUhVMdrradFw6gk6+XwF05JEdL6uSWhjH8ZMZoBUsHbglqtg0pnm8tbDQzmaBzztLnOaPbwVYLe8",
                                     encryptedPaymentData: "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")
}

extension JudoTestCase {
    
    // Test Setup Methods
    override func setUp() {
        super.setUp()
        judo.apiSession.sandboxed = true
    }
    
    override func tearDown() {
        judo.apiSession.sandboxed = false
        super.tearDown()
    }
    
    // Helper assessment method
    func assert(error: Error?, as judoError: JudoError) {
        
        guard let error = (error as NSError?) else {
            XCTFail("Error must be returned on when accessing an invalid JudoKit session")
            return
        }
        
        XCTAssertEqual(error.code, Int(judoError.rawValue),
                       "Error must return code: \(error.code) instead of \(judoError.rawValue)")
    }
}
