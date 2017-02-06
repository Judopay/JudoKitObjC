//
//  WalletServiceTests.swift
//  JudoKit
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

class WalletServiceTests : JudoTestCase {
    
    private var repo = InMemoryWalletRepository()
    private var sut = WalletService(walletRepository: InMemoryWalletRepository())
    
    override func setUp() {
        self.repo = InMemoryWalletRepository()
        self.sut = WalletService(walletRepository: self.repo)
    }
    
    func test_AddingFirstCardMustBeSetAsDefault() {
        //arr
        let addedCard = self.buildWalletCard(isDefault: false)
        
        //act
        try! self.sut.add(addedCard)
        
        //assert
        let retrievedCard = self.sut.get(addedCard.walletId)
        
        XCTAssertNotNil(retrievedCard)
        XCTAssertTrue(retrievedCard!.defaultPaymentMethod)
    }
    
    func test_AddingSecondCardMustNotBeSetAsDefault() {
        //arr
        let firstAddedCard = self.buildWalletCard(isDefault: false)
        let secondAddedCard = self.buildWalletCard(isDefault: false)
        
        //act
        try! self.sut.add(firstAddedCard)
        try! self.sut.add(secondAddedCard)
        
        //assert
        let firstRetrievedCard = self.sut.get(firstAddedCard.walletId)
        let secondRetrievedCard = self.sut.get(secondAddedCard.walletId)
        
        XCTAssertNotNil(firstRetrievedCard)
        XCTAssertTrue(firstRetrievedCard!.defaultPaymentMethod)
        XCTAssertNotNil(secondAddedCard)
        XCTAssertFalse(secondRetrievedCard!.defaultPaymentMethod)
    }
    
    func test_AddingSecondCardAsDefaultMustBeSetAsDefault() {
        //arr
        let firstAddedCard = self.buildWalletCard(isDefault: false)
        let secondAddedCard = self.buildWalletCard(isDefault: true)
        
        //act
        try! self.sut.add(firstAddedCard)
        try! self.sut.add(secondAddedCard)
        
        //assert
        let firstRetrievedCard = self.sut.get(firstAddedCard.walletId)
        let secondRetrievedCard = self.sut.get(secondAddedCard.walletId)
        
        XCTAssertNotNil(firstRetrievedCard)
        XCTAssertFalse(firstRetrievedCard!.defaultPaymentMethod)
        XCTAssertNotNil(secondAddedCard)
        XCTAssertTrue(secondRetrievedCard!.defaultPaymentMethod)
    }

    func test_UpdatingDefaultCardMustPerserveItAsDefault() {
        //arr
        let firstAddedCard = self.buildWalletCard(isDefault: false)
        let secondAddedCard = self.buildWalletCard(isDefault: true)
        
        //act
        try! self.sut.add(firstAddedCard)
        try! self.sut.add(secondAddedCard)
        try! self.sut.update(secondAddedCard.withAssignedCardName("My updated name"))
        
        let firstRetrievedCard = self.sut.get(firstAddedCard.walletId)
        let secondRetrievedCard = self.sut.get(secondAddedCard.walletId)
        
        XCTAssertNotNil(firstRetrievedCard)
        XCTAssertFalse(firstRetrievedCard!.defaultPaymentMethod)
        XCTAssertNotNil(secondAddedCard)
        XCTAssertTrue(secondRetrievedCard!.defaultPaymentMethod)
    }
    
    /*func test_UpdatingDefaultCardToNonDefaultMustThrowException() {
        //arr
        let firstAddedCard = self.buildWalletCard(isDefault: false)
        let secondAddedCard = self.buildWalletCard(isDefault: true)
        
        //act
        try! self.sut.add(firstAddedCard)
        try! self.sut.add(secondAddedCard)
        
        //act //assert
        do {
            try self.sut.update(secondAddedCard.withNonDefaultCard())
            XCTFail()
        } catch let error as Error {
            let walletError = error as! WalletError
            XCTAssertNotNil(walletError)
            XCTAssertNotNil(walletError.description())
            XCTAssertTrue(walletError.description() == WalletError.cannotResignDefaultCard.description())
        }
    }*/
    
    func test_UpdatingCardAsDefaultMustSetCardAsDefault() {
        //arr
        let firstAddedCard = self.buildWalletCard(isDefault: true)
        let secondAddedCard = self.buildWalletCard(isDefault: false)
        
        //act
        try! self.sut.add(firstAddedCard)
        try! self.sut.add(secondAddedCard)
        //Update the second card.
        try! self.sut.update(secondAddedCard.withDefault())
        
        //assert
        let firstRetrievedCard = self.sut.get(firstAddedCard.walletId)
        let secondRetrievedCard = self.sut.get(secondAddedCard.walletId)
        
        XCTAssertNotNil(firstRetrievedCard)
        XCTAssertFalse(firstRetrievedCard!.defaultPaymentMethod)
        XCTAssertNotNil(secondAddedCard)
        XCTAssertTrue(secondRetrievedCard!.defaultPaymentMethod)
    }
    
    /*func test_UpdatingCardWithUUIDThatDoesNotExistMustThrowException() {
        //arr
        let firstAddedCard = self.buildWalletCard(isDefault: true)
        
        //act //assert
        do {
            try self.sut.update(card: firstAddedCard)
            XCTFail()
        } catch let error as Error {
            let walletError = error as! WalletError
            XCTAssertNotNil(walletError)
            XCTAssertNotNil(walletError.description())
            XCTAssertTrue(walletError.description() == WalletError.unknownWalletCard.description())
        }
    }*/

    func test_TryingToUpdateCardWithUUIDThatExistsMustReplaceThatCard() {
        //arr
        let firstAddedCard = self.buildWalletCard(isDefault: false)
        
        //act
        try! self.sut.add(firstAddedCard)
        
        let retrievedCard = self.sut.get(firstAddedCard.walletId)!
        let newAssignedName = self.uuidString()
        
        try! self.sut.update(retrievedCard.withAssignedCardName(newAssignedName))
        
        //assert
        let firstRetrievedCard = self.sut.get(firstAddedCard.walletId)
        XCTAssertNotNil(firstRetrievedCard)
        XCTAssertEqual(firstAddedCard.walletId, firstRetrievedCard!.walletId)
        XCTAssertEqual(newAssignedName, firstRetrievedCard!.assignedName)
    }
    
    /*func test_AttemptingToRemoveDefaultCardWhenWalletHasMoreThanOneCardMustThrowException() {
        //arr
        let firstAddedCard = self.buildWalletCard(isDefault: false)
        let secondAddedCard = self.buildWalletCard(isDefault: true)
        
        //act
        try! self.sut.add(firstAddedCard)
        try! self.sut.add(secondAddedCard)
        
        //assert
        do {
            try self.sut.remove(secondAddedCard)
            XCTFail()
        } catch let error as Error {
            let walletError = error as! WalletError
            XCTAssertNotNil(walletError)
            XCTAssertNotNil(walletError.description())
            XCTAssertTrue(walletError.description() == WalletError.cannotRemoveDefaultCard.description())
        }
    }*/
    
    func test_AttemptingToRemoveDefaultCardWhenWalletHasSingleCardMustNotThrowException() {
        //arr
        let firstAddedCard = self.buildWalletCard(isDefault: false)
        let secondAddedCard = self.buildWalletCard(isDefault: true)
        
        //act
        try! self.sut.add(firstAddedCard)
        try! self.sut.add(secondAddedCard)
        
        try! self.sut.remove(firstAddedCard)
        try! self.sut.remove(secondAddedCard)
        
        //assert
        let cards = self.sut.get()
        XCTAssertTrue(cards.count == 0)
    }
    
    func test_WhenACardHasExpiredItMustBeIndicatedAsExpired() {
        //arr
        let firstAddedCard = self.buildWalletCard(expiryDate: "01/01")
        
        //act
        let expired = firstAddedCard.hasCardExpired()
        
        //assert
        XCTAssertTrue(expired)
    }
    
    func test_WhenACardHasNotExpiredItMustBeIndicatedAsNotExpired() {
        //arr
        let firstAddedCard = self.buildWalletCard(expiryDate: "01/25")
        
        //act
        let expired = firstAddedCard.hasCardExpired()
        
        //assert
        XCTAssertFalse(expired)
    }
    
    func test_RemovingCardWithUUIDThatDoesNotExistMustNotThrowException() {
        //arr
        let firstAddedCard = self.buildWalletCard(isDefault: false)
        
        //act assert
        try! self.sut.remove(firstAddedCard)
    }

    func test_CallingGetDefaultCardMustReturnDefaultCard() {
        //arr
        let firstAddedCard = self.buildWalletCard(isDefault: false)
        let secondAddedCard = self.buildWalletCard(isDefault: false)
        let thirdAddedCard = self.buildWalletCard(isDefault: true)
        let forthAddedCard = self.buildWalletCard(isDefault: false)
        
        //act
        try! self.sut.add(firstAddedCard)
        try! self.sut.add(secondAddedCard)
        try! self.sut.add(thirdAddedCard)
        try! self.sut.add(forthAddedCard)
        
        //assert
        let retrievedCard = self.sut.getDefault()
        XCTAssertNotNil(retrievedCard)
        XCTAssertEqual(retrievedCard!.walletId, thirdAddedCard.walletId)
    }
    
    func test_CardListMustBePrioritised() {
        let firstAddedCard = self.buildWalletCard(isDefault: false, alias: "first")
        let secondAddedCard = self.buildWalletCard(isDefault: false, alias: "second")
        let thirdAddedCard = self.buildWalletCard(isDefault: true, alias: "third")
        let forthAddedCard = self.buildWalletCard(isDefault: false, alias: "forth")
        let fifthAddedCard = self.buildWalletCard(isDefault: false, alias: "fifth")
        
        try! self.sut.add(firstAddedCard)
        try! self.sut.add(secondAddedCard)
        try! self.sut.add(thirdAddedCard)
        //3,1,2
        try! self.sut.add(forthAddedCard)
        try! self.sut.add(fifthAddedCard)
        
        try! self.sut.remove(secondAddedCard)
        try! self.sut.update(firstAddedCard.withAssignedCardName("first-updated"))
        
        let walletCards = self.sut.get()
        XCTAssertEqual(walletCards.count, 4)
        XCTAssertEqual(walletCards[0].walletId, thirdAddedCard.walletId)
        XCTAssertEqual(walletCards[1].walletId, fifthAddedCard.walletId)
        XCTAssertEqual(walletCards[2].walletId, forthAddedCard.walletId)
        XCTAssertEqual(walletCards[3].walletId, firstAddedCard.walletId)
    }
    
   /* func test_TryingToAddACardOverLimitThreasholdMustThrowException() {
        //arr
        let firstNCards = (1...sut.maxNumberOfCardsAllowed).map {
            return self.buildWalletCard(isDefault: false, alias: String(describing: $0))
        }
        
        for card in firstNCards {
            try! self.sut.add(card)
        }
        
        //act //assert
        do {
            let throwingCard = self.buildWalletCard(isDefault: false, alias: "Throwing card")
            try self.sut.add(throwingCard)
            XCTFail()
        } catch let error {
            let walletError = error as! WalletError
            XCTAssertNotNil(walletError)
            XCTAssertNotNil(walletError.description())
            XCTAssertTrue(walletError.description() == WalletError.walletCardLimitPassed.description())
        }
    }*/
    
    private func buildWalletCard(isDefault: Bool) -> WalletCard {
        return self.buildWalletCard(isDefault: isDefault, alias: self.uuidString())
    }
    
    private func buildWalletCard(expiryDate: String) -> WalletCard {
        return WalletCard(cardData: self.uuidString(), expiryDate: expiryDate, cardToken: self.uuidString(), cardType: 1, assignedName: self.uuidString(), defaultPaymentMethod: false)
    }
    
    private func buildWalletCard(isDefault: Bool, alias: String) -> WalletCard {
        return WalletCard(cardData: self.uuidString(), expiryDate: self.uuidString(), cardToken: self.uuidString(), cardType: 1, assignedName: alias, defaultPaymentMethod: isDefault)
    }
    
    private func uuidString() -> String {
        return UUID().uuidString
    }
}
