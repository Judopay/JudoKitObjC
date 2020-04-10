//
//  CardStorageTest.swift
//  JudoKitObjC
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

class CardStorageTest: XCTestCase {
    
    func testSetCardAsDefaultAtIndex() {
        self.addTestCardsInStorage()
        JPCardStorage.sharedInstance()?.setCardDefaultState(true, at: 2);
        let storedCardsDetails:[JPStoredCardDetails] = JPCardStorage.sharedInstance()?.fetchStoredCardDetails() as! [JPStoredCardDetails]
        let selectedCard = storedCardsDetails[0];
        XCTAssert(selectedCard.cardLastFour == "3333")
        XCTAssert(selectedCard.expiryDate == "23/23")
        XCTAssert(selectedCard.cardNetwork == .networkJCB)
        XCTAssert(selectedCard.cardToken == "cardToken3")
    }
    
    func addTestCardsInStorage() {
        let firstStoredCard = JPStoredCardDetails(lastFour: "1111", expiryDate: "11/21", cardNetwork: .networkVisa, cardToken: "cardToken1")
        let secondStoredCard = JPStoredCardDetails(lastFour: "2222", expiryDate: "22/22", cardNetwork: .networkMasterCard, cardToken: "cardToken2")
        let thirdStoredCard = JPStoredCardDetails(lastFour: "3333", expiryDate: "23/23", cardNetwork: .networkJCB, cardToken: "cardToken3")
        let forthStoredCard = JPStoredCardDetails(lastFour: "4444", expiryDate: "24/24", cardNetwork: .networkAMEX, cardToken: "cardToken4")
        
        JPCardStorage.sharedInstance()?.deleteCardDetails()
        JPCardStorage.sharedInstance()?.add(firstStoredCard)
        JPCardStorage.sharedInstance()?.add(secondStoredCard)
        JPCardStorage.sharedInstance()?.add(thirdStoredCard)
        JPCardStorage.sharedInstance()?.add(forthStoredCard)

    }
}
