import UIKit
import PassKit
import JudoKitObjC

class StandaloneApplePayViewController: UIViewController {

    var currency: Currency = .GBP
    var judoKit: JudoKit?

    @IBOutlet weak var placeholderLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if PKPaymentAuthorizationViewController.canMakePayments() {
            self.placeholderLabel.isHidden = true

            let style: PKPaymentButtonStyle = self.traitCollection.userInterfaceStyle == .dark ? .white : .black
            let button = PKPaymentButton(paymentButtonType: .plain, paymentButtonStyle: style)
            button.addTarget(self, action: #selector(performApplePay), for: .touchUpInside)

            view.addSubview(button)

            button.translatesAutoresizingMaskIntoConstraints = false
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }

    @objc func performApplePay() {
        let items = [
            PaymentSummaryItem(label: "Item 1", amount: 0.01),
            PaymentSummaryItem(label: "Item 2", amount: 0.02),
            PaymentSummaryItem(label: "Item 3", amount: 0.03)
        ]

        let configuration = ApplePayConfiguration(judoId: judoId,
                                                  reference: "judopay-sample-app",
                                                  merchantId: merchantId,
                                                  currency: currency.rawValue,
                                                  countryCode: "GB",
                                                  paymentSummaryItems: items)

        configuration.transactionType = .payment
        configuration.requiredShippingContactFields = .all
        configuration.requiredBillingContactFields = .all
        configuration.returnedContactInfo = .all

        judoKit?.invokeApplePay(with: configuration, completion: { (response, error) in
            if let judoError = error as NSError? {
                self.handle(error: judoError)
                return
            }

            if let response = response, let items = response.items, items.count > 0 {
                let detailsViewController = TransactionDetailsTableViewController(title: "Transaction details",
                                                                                  response: response)
                self.navigationController?.pushViewController(detailsViewController, animated: true)
            }
        })
    }

    func handle(error: NSError) {
        if error.userDidCancelOperation {
            dismiss(animated: true, completion: nil)
            return
        }

        dismiss(animated: true) {
            self.presentAlert(with: "Error", message: error.judoMessage)
        }
    }

    func presentAlert(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    func handle(response: JPResponse) {
        let detailsViewController = TransactionDetailsTableViewController(title: "Payment receipt",
                                                                          response: response)
        dismiss(animated: true) {
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}
