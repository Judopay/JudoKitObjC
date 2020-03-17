//
//  JPTransactionServiceTest.swift
//  JudoKitObjCTests
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

import XCTest

class JPTransactionServiceTest: XCTestCase {
    
    let transactionService = JPTransactionService(token: "TOKEN", andSecret: "SECRET")
    lazy var transactionAmmount = JPAmount("100.0", currency: "EUR")
    lazy var transactionReference = JPReference(consumerReference: "consumerReference",
                                                paymentReference: "PaymentReference")
    lazy var transactionConfigurations = JPConfiguration(judoID: "JUDAID",
                                                         amount: self.transactionAmmount,
                                                         reference: self.transactionReference)
    
    
    
    func testTransactionWithConfigurations() {
        let transaction = transactionService.transaction(with: self.transactionConfigurations)
        XCTAssertEqual(transaction.amount!.amount, self.transactionAmmount.amount)
        XCTAssertEqual(transaction.amount!.currency, self.transactionAmmount.currency)
        XCTAssertEqual(transaction.reference!.consumerReference, self.transactionReference.consumerReference)
        XCTAssertEqual(transaction.reference!.paymentReference, self.transactionReference.paymentReference)
    }
    
    func testListTransactionsOfType() {
        self.transactionService.listTransactions(of: .checkCard,
                                                  paginated: JPPagination(offset: 1,
                                                                          pageSize: 2,
                                                                          sort: ""),
                                                  completion: { (response, error) in
                                                    XCTAssertNotNil(response)
        })
    }
    
    func testreceiptForReceiptId(){
        let receipt = self.transactionService.receipt(forReceiptId: "123")
        XCTAssertEqual(receipt.receiptId, "123")
    }
    
}
