import Foundation
import JudoKitObjC

extension NSError {

    var userDidCancelOperation: Bool {
        return domain == JudoErrorDomain && code == JudoError.errorUserDidCancel.rawValue
    }

    var judoMessage: String {
        let fallback = "Unknown error"
        let keys = userInfo.keys

        if keys.contains("message") {
            return userInfo["message"] as? String ?? fallback
        }

        if keys.contains(NSLocalizedDescriptionKey) {
            return userInfo[NSLocalizedDescriptionKey] as? String ?? fallback
        }

        return fallback
    }
}
