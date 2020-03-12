//
//  ApplePayTests.swift
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
@testable import JudoKitObjC

class ApplePayTests: JudoTestCase {
    
    var configuration: JPApplePayConfiguration!
    var manager: JPApplePayService!
    
    override func setUp() {
        super.setUp()
        
        let items = [
            JPPaymentSummaryItem(label: "Item 1", amount: NSDecimalNumber(string: "0.01")),
            JPPaymentSummaryItem(label: "Item 2", amount: NSDecimalNumber(string: "0.02")),
            JPPaymentSummaryItem(label: "Tim Apple", amount: NSDecimalNumber(string: "0.03"))
        ]
        
        configuration = JPApplePayConfiguration(judoId: myJudoId,
                                              reference: "consumer reference",
                                              merchantId: "",
                                              currency: "GBP",
                                              countryCode: "GB",
                                              paymentSummaryItems: items)
        
        manager = JPApplePayService(configuration: configuration)
    }
    
    override func tearDown() {
        manager = nil
        configuration = nil
        
        super.tearDown()
    }
    
    /**
     * GIVEN:  JPApplePayConfiguration is initialized
     *
     *  THEN:  default values for merchant capabilities, supported card networks, transaction type,
     *         shipping type and returned contact info must be set.
     */
    func test_OnJPApplePayConfigurationInitialization_DefaultValuesAreRespected() {
        XCTAssertEqual(configuration.merchantCapabilities, MerchantCapability.capability3DS,
                       "Configuration's merchantCapabilities does not default to 3D Security")
        XCTAssertTrue(configuration.supportedCardNetworks.contains(NSNumber(value: CardNetwork.networkVisa.rawValue)),
                       "Configuration's supportedCardNetworks does not contain Visa")
        XCTAssertTrue(configuration.supportedCardNetworks.contains(NSNumber(value: CardNetwork.networkAMEX.rawValue)),
                      "Configuration's supportedCardNetworks does not contain AmEx")
        XCTAssertTrue(configuration.supportedCardNetworks.contains(NSNumber(value: CardNetwork.networkMasterCard.rawValue)),
                      "Configuration's supportedCardNetworks does not contain MasterCard")

        if #available(iOS 12.0, *) {
            XCTAssertTrue(configuration.supportedCardNetworks.contains(NSNumber(value: CardNetwork.networkMaestro.rawValue)),
                          "Configuration's supportedCardNetworks does not contain Maestro")
        }
        
        XCTAssertEqual(configuration.transactionType, TransactionType.payment,
                       "Configuration's transactionType does not default to Payment")
        XCTAssertEqual(configuration.shippingType, PaymentShippingType.ShippingTypeShipping,
                       "Configuration's shippingType does not default to Shipping")
        XCTAssertEqual(configuration.returnedContactInfo, ReturnedInfo.billingContacts,
                       "Configuration's returnedContactInfo does not default to Billing")
    }
    
    /**
     * GIVEN:  JPApplePayConfiguration is initialized correctly
     *
     *  THEN:  JPApplePayService should return a PKAuthorizationViewController object when calling
     *         its "pkPaymentAuthorizationViewController" instance method
     */
    func test_OnValidConfiguration_ManagerReturnsValidPKAuthorizationViewController() {
        XCTAssertNotNil(manager.pkPaymentAuthorizationViewController(),
                        "PKPaymentAuthorizationViewController must be initialized on valid configuration")
        XCTAssertTrue(manager.pkPaymentAuthorizationViewController()!.isKind(of: PKPaymentAuthorizationViewController.self),
                      "Returned controller must be of type PKPaymentAuthorizationViewController")
    }
    
    /**
     * GIVEN:  JPApplePayConfiguration is initialized incorrectly
     *
     *  THEN:  JPApplePayService should return nil when calling
     *         its "pkPaymentAuthorizationViewController" instance method
     */
    func test_OnInvalidConfiguration_ManagerReturnsNilPKAuthorizationViewController() {
        configuration.paymentSummaryItems = [];
        XCTAssertNil(manager.pkPaymentAuthorizationViewController(),
                    "PKPaymentAuthorizationViewController must be nil on invalid configuration")
    }
    
    /**
     * GIVEN:  JPApplePayConfiguration is initialized correctly
     *
     *  THEN:  JPApplePayService should return a valid JPAmount object when calling
     *         its "jpAmount" instance method
     */
    func test_OnValidConfiguration_ManagerGeneratesCorrectJPAmount() {
        XCTAssertNotNil(manager.jpAmount(),
                        "JPAmount must not be nil on correct configuration")
        XCTAssertEqual(manager.jpAmount().amount, "0.03",
                       "JPAmount does not display the correct amount")
        XCTAssertEqual(manager.jpAmount().currency, "GBP",
                       "JPAmount does not display the correct currency")
    }
    
    /**
     * GIVEN:  JPApplePayConfiguration is initialized incorrectly
     *
     *  THEN:  JPApplePayService should return a JPAmount object with empty amount
     *         when calling its "jpAmount" instance method
     */
    func test_OnInvalidConfiguration_ManagerGeneratesEmptyJPAmount() {
        configuration = JPApplePayConfiguration()
        manager = JPApplePayService(configuration: configuration)
        XCTAssertEqual(manager.jpAmount().amount, "",
                        "JPAmount must have empty on incorrect configuration")
    }
    
    /**
     * GIVEN:  JPApplePayConfiguration is initialized correctly
     *
     *  THEN:  JPApplePayService should return a valid JPReference object when calling
     *         its "jpReference" instance method
     */
    func test_OnValidConfiguration_ManagerGeneratesCorrectJPReference() {
        XCTAssertEqual(manager.jpReference().consumerReference, "consumer reference",
                       "JPReference's consumerReference must match the one specified")
    }
    
    /**
     * GIVEN:  JPApplePayConfiguration is initialized incorrectly
     *
     *  THEN:  JPApplePayService should return a JPReference object with empty consumerReference when
     *         calling its "jpReference" instance method
     */
    func test_OnInvalidConfiguration_ManagerGeneratesCorrectJPReference() {
        configuration = JPApplePayConfiguration()
        manager = JPApplePayService(configuration: configuration)
        XCTAssertEqual(manager.jpReference().consumerReference, "",
                       "JPReference must have empty consumerReference on incorrect configuration")
    }
    
    /**
     * GIVEN:  JPApplePayService wants to convert a valid PKContact to JPContactInformation
     *
     *  THEN:  a JPContactInformation object is returned with all PKContact properties set
     */
    func test_OnConversionFromPKContact_ReturnValidJPContactInformation() {
        
        var name = PersonNameComponents()
        name.givenName = "Tim"
        name.familyName = "Apple"
        
        let pkContact = PKContact();
        pkContact.name = name;
        pkContact.emailAddress = "tim.apple@email.com"
        
        let information = manager.contactInformation(fromPaymentContact: pkContact)
        XCTAssertNotNil(information, "JPContactInformation must not be nil")
        
        XCTAssertEqual(information?.name?.givenName, "Tim",
                       "Given name does not match the one specified in the PKContact object")
        XCTAssertEqual(information?.name?.familyName, "Apple",
                       "Family name does not match the one specified in the PKContact object")
        XCTAssertEqual(information?.emailAddress, "tim.apple@email.com",
                       "Email does not match the one specified in the PKContact object")
    }
}

