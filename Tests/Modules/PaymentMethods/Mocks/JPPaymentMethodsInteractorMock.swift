//
//  JPPaymentMethodsInteractorMock.swift
//  JudoKitObjC
//
//  Copyright (c) 2020 Alternative Payments Ltd
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

import Foundation

class JPPaymentMethodsInteractorMock: JPPaymentMethodsInteractor {
    func getStoredCardDetails() -> [JPStoredCardDetails]! {
        
        let calendar = Calendar.current
        
        let todaysDate = Date()
        let dateInTwoMonths = calendar.date(byAdding: .month, value: 1, to: todaysDate)!
        let expiredDate = calendar.date(byAdding: .month, value: -1, to: todaysDate)!
        let notExpiredDate = calendar.date(byAdding: .month, value: 3, to: todaysDate)!

        let dateFormater = DateFormatter()
        dateFormater.dateFormat = (kMonthYearDateFormat)
        
        let expiresSoonDateAsString = dateFormater.string(from: dateInTwoMonths)
        let expiredDateAsString = dateFormater.string(from: expiredDate)
        let notExpiredDateAsString = dateFormater.string(from: notExpiredDate)
        
        let validCard = JPStoredCardDetails(lastFour: "1111", expiryDate: notExpiredDateAsString, cardNetwork: .networkVisa, cardToken: "token")!
        let expiresSoonCard = JPStoredCardDetails(lastFour: "1111", expiryDate: expiresSoonDateAsString, cardNetwork: .networkVisa, cardToken: "token")!
        let expirdCard = JPStoredCardDetails(lastFour: "1111", expiryDate: expiredDateAsString, cardNetwork: .networkVisa, cardToken: "token")!
        
        return [validCard, expiresSoonCard, expirdCard]
    }
    
    func selectCard(at index: Int) {
        
    }
    
    func getAmount() -> JPAmount! {
        let amount = JPAmount("1.0", currency: "EUR");
        return amount
    }
    
    func getPaymentMethods() -> [JPPaymentMethod]! {
        return [JPPaymentMethod.card()]
    }
    
    func paymentTransaction(withToken token: String!, andCompletion completion: JudoCompletionBlock!) {
        
    }
    
    func startApplePay(completion: JudoCompletionBlock!) {
        let response = JPResponse()
        completion(response,nil)
    }
    
    func deleteCard(with index: Int) {
        
    }
    
    func setCardAsSelectedAtInded(_ index: Int) {
        
    }
    
    func isApplePaySetUp() -> Bool {
        return false
    }
    
    func handle3DSecureTransaction(fromError error: Error!, completion: JudoCompletionBlock!) {
        
    }
    
}
