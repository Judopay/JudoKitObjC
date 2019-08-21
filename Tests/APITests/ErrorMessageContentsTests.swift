//
//  ErrorMessageContentsTests.swift
//  JudoKitObjCTests
//
//  Created by Ashley Barrett on 08/04/2016.
//  Copyright © 2016 Judo Payments. All rights reserved.
//

import XCTest

let UnableToProcessRequestErrorDesc = "Sorry, we're currently unable to process this request."
let UnableToProcessRequestErrorTitle = "Unable to process"

let ErrorRequestFailed = "The request responded without data"
let ErrorPaymentMethodMissing = "The payment method (card details, token or PKPayment) has not been set for a transaction that requires it (custom UI)"
let ErrorAmountMissing = "The amount has not been set for a transaction that requires it (custom UI)"
let ErrorReferenceMissing = "The reference has not been set for a transaction that requires it (custom UI)"
let ErrorResponseParseError = "An error with a response from the backend API"
let ErrorUserDidCancel = "Received when user cancels the payment journey"
let ErrorParameterError = "A parameter entered into the dictionary (request body to Judo API) is not set"
let ErrorFailed3DSRequest = "After receiving the 3DS payload, when the payload has faulty data, the WebView fails to load the 3DS Page or the resolution page"
let ErrorJailbrokenDeviceDisallowed = "The device the code is currently running is jailbroken. Jailbroken devices are not allowed when instantiating a new Judo session";

let JPErrorTitleKey = "JPErrorTitleKey"

let Error3DSRequest = "Error when routing to 3DS"
let ErrorUnderlyingError = "An error in the iOS system with an enclosed underlying error"
let ErrorTransactionDeclined = "A transaction that was sent to the backend returned declined"

class ErrorMessageContentsTests: JudoTestCase {
    
    /* Request Failed Error */
    func test_ErrorRequestFailed() {
        let error = NSError.judoRequestFailedError() as NSError
        assert(error, as: ErrorRequestFailed)
    }
    
    /* Missing Payment Method Error */
    func test_ErrorPaymentMethodMissing() {
        let error = NSError.judoPaymentMethodMissingError() as NSError
        assert(error, as: ErrorPaymentMethodMissing);
    }
    
    /* Missing Amount Error */
    func test_ErrorAmountMissing() {
        let error = NSError.judoAmountMissingError() as NSError
        assert(error, as: ErrorAmountMissing)
    }
    
    /* Missing Reference Error */
    func test_ErrorReferenceMissing() {
        let error = NSError.judoReferenceMissingError() as NSError
        assert(error, as: ErrorReferenceMissing)
    }
    
    /* Response Parse Error */
    func test_ErrorResponseParseError() {
        let error = NSError.judoResponseParseError() as NSError
        assert(error, as: ErrorResponseParseError)
    }
    
    /* User Did Cancel Error */
    func test_ErrorUserDidCancel() {
        let error = NSError.judoUserDidCancelError() as NSError
        let devDescription = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
        XCTAssertEqual(devDescription, ErrorUserDidCancel)
    }
    
    /* Parameter Error */
    func test_ErrorParameterError() {
        let error = NSError.judoParameterError() as NSError
        assert(error, as: ErrorParameterError)
    }
    
    /* Failed 3DS Request Error */
    func test_ErrorFailed3DSRequest() {
        let error = NSError.judo3DSRequestFailedError(withUnderlyingError: nil) as NSError
        assert(error, as: ErrorFailed3DSRequest)
    }
    
    /* Jailbroken Devices Not Allowed Error */
    func test_JailbrokenDeviceDisallowedError() {
        let error = NSError.judoJailbrokenDeviceDisallowedError() as NSError
        assert(error, as: ErrorJailbrokenDeviceDisallowed)
    }
    
    /* Helper assessment method */
    private func assert(_ error: NSError, as type: String) {
        let errorTitle = error.userInfo[JPErrorTitleKey] as? String
        let errorDescription = error.userInfo[NSLocalizedDescriptionKey] as? String
        let devDescription = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
        
        XCTAssertEqual(errorTitle, UnableToProcessRequestErrorTitle)
        XCTAssertEqual(errorDescription, UnableToProcessRequestErrorDesc)
        XCTAssertEqual(devDescription, type)
    }
}
