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
