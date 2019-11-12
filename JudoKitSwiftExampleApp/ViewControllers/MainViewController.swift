import UIKit
import JudoKitObjC

class MainViewController: UITableViewController {

    var settings: Settings = Settings(isAVSEnabled: false, currency: .GBP)
    var judoKit = JudoKit(token: token, secret: secret)
    var transactionData: JPTransactionData?
    let consumerReference = "judoPay-sample-app"
    let defaultFeatures = [
        DemoFeature(type: .payment,
                    title: "Payment",
                    details: "with default settings"),

        DemoFeature(type: .preAuth,
                    title: "PreAuth",
                    details: "to reserve funds on a card"),

        DemoFeature(type: .createCardToken,
                    title: "Register card",
                    details: "to be stored for future transactions"),

        DemoFeature(type: .saveCard,
                    title: "Save card",
                    details: "to be stored for future transactions"),

        DemoFeature(type: .repeatPayment,
                    title: "Token payment",
                    details: "with a stored card token"),

        DemoFeature(type: .tokenPreAuth,
                    title: "Token preAuth",
                    details: "with a stored card token"),

        DemoFeature(type: .applePayPayment,
                    title: "Apple Pay payment",
                    details: "with a wallet card"),

        DemoFeature(type: .applePayPreAuth,
                    title: "Apple Pay preAuth",
                    details: "with a wallet card"),

        DemoFeature(type: .paymentMethods,
                    title: "Payment Method",
                    details: "with default payment methods"),

        DemoFeature(type: .standaloneApplePayButton,
                    title: "Apple Pay Button",
                    details: "standalone ApplePay Button")
    ]

    var testAmount: JPAmount {
        return JPAmount("0.01", currency: settings.currency.rawValue)
    }

    var testPaymentApplePayConfiguration: ApplePayConfiguration {
        return applePayConfiguration(with: .payment, currency: settings.currency.rawValue)
    }

    var testPreAuthApplePayConfiguration: ApplePayConfiguration {
        return applePayConfiguration(with: .preAuth, currency: settings.currency.rawValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = false

        judoKit.apiSession.sandboxed = true
        judoKit.theme.showSecurityMessage = true
    }

    // MARK: Table view datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultFeatures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let feature = defaultFeatures[indexPath.row]

        cell.textLabel?.text = feature.title
        cell.detailTextLabel?.text = feature.details

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let feature = defaultFeatures[indexPath.row]

        switch feature.type {
        case .payment:
            pay()

        case .preAuth:
            preAuth()

        case .createCardToken:
            createCardToken()

        case .saveCard:
            saveCard()

        case .repeatPayment:
            repeatPayment()

        case .tokenPreAuth:
            tokenPreAuth()

        case .applePayPayment:
            applePayPayment()

        case .applePayPreAuth:
            applePayPreAuth()

        case .paymentMethods:
            navigateToPaymentMethods()

        case .standaloneApplePayButton:
            navigateToStandaloneApplePayButton()
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigation = segue.destination as? UINavigationController,
            let controller = navigation.viewControllers.first as? SettingsTableViewController {
            controller.settings = self.settings
            controller.delegate = self
        } else if let applePayViewController = segue.destination as? StandaloneApplePayViewController {
            applePayViewController.judoKit = judoKit
            applePayViewController.currency = settings.currency
        }
    }

    // MARK: Actions
    @objc func pay() {
        judoKit.invokePayment(judoId,
                              amount: testAmount,
                              consumerReference: self.consumerReference,
                              cardDetails: nil) { [weak self] response, error in
                                self?.transactionData = self?.handle(response, error: error)
        }
    }

    @objc func preAuth() {
        judoKit.invokePreAuth(judoId,
                              amount: testAmount,
                              consumerReference: self.consumerReference,
                              cardDetails: nil) { [weak self] response, error in
                                self?.transactionData = self?.handle(response, error: error)
        }
    }

    @objc func createCardToken() {
        judoKit.invokeRegisterCard(judoId,
                                   consumerReference: self.consumerReference,
                                   cardDetails: nil) { [weak self] response, error in
                                    self?.transactionData = self?.handle(response, error: error)
        }
    }

    @objc func saveCard() {
        judoKit.invokeSaveCard(judoId,
                               consumerReference: self.consumerReference,
                               cardDetails: nil) { [weak self] response, error in
                                self?.transactionData = self?.handle(response, error: error)
        }
    }

    @objc func repeatPayment() {
        guard let cardDetails = transactionData?.cardDetails, let paymentToken = transactionData?.paymentToken else {
            presentAlert(with: "Error",
                         message: "Before you can make a pre-auth request, you need to register or save a card")
            return
        }

        judoKit.invokeTokenPayment(judoId,
                                   amount: testAmount,
                                   consumerReference: self.consumerReference,
                                   cardDetails: cardDetails,
                                   paymentToken: paymentToken) { [weak self] response, error in
                                    self?.transactionData = self?.handle(response, error: error)
        }
    }

    @objc func tokenPreAuth() {
        guard let cardDetails = transactionData?.cardDetails, let paymentToken = transactionData?.paymentToken else {
            presentAlert(with: "Error",
                         message: "Before you can make a pre-auth request, you need to register or save a card")
            return
        }

        judoKit.invokeTokenPreAuth(judoId,
                                   amount: testAmount,
                                   consumerReference: self.consumerReference,
                                   cardDetails: cardDetails,
                                   paymentToken: paymentToken) { [weak self] response, error in
                                    self?.transactionData = self?.handle(response, error: error)
        }
    }

    @objc func applePayPayment() {
        judoKit.invokeApplePay(with: testPaymentApplePayConfiguration) { [weak self] response, error in
            self?.transactionData = self?.handle(response, error: error)
        }
    }

    @objc func applePayPreAuth() {
        judoKit.invokeApplePay(with: testPreAuthApplePayConfiguration) { [weak self] response, error in
            self?.transactionData = self?.handle(response, error: error)
        }
    }

    @objc func navigateToPaymentMethods() {
        judoKit.invokePayment(judoId,
                              amount: testAmount,
                              consumerReference: self.consumerReference,
                              paymentMethods: .methodsAll,
                              applePayConfiguratation: testPaymentApplePayConfiguration,
                              cardDetails: nil) { [weak self] response, error in
                                self?.transactionData = self?.handle(response, error: error)
        }
    }

    @objc func navigateToStandaloneApplePayButton() {
        performSegue(withIdentifier: "toStandaloneApplePay", sender: self)
    }

    // MARK: Helpers
    func applePayConfiguration(with transactionType: TransactionType, currency: String) -> ApplePayConfiguration {
        let items = [
            PaymentSummaryItem(label: "Item 1", amount: 0.01),
            PaymentSummaryItem(label: "Item 2", amount: 0.02),
            PaymentSummaryItem(label: "Item 3", amount: 0.03)
        ]

        let configuration = ApplePayConfiguration(judoId: judoId,
                                                  reference: "judopay-sample-app",
                                                  merchantId: merchantId,
                                                  currency: currency,
                                                  countryCode: "GB",
                                                  paymentSummaryItems: items)
        configuration.transactionType = transactionType
        configuration.requiredShippingContactFields = .all
        configuration.requiredBillingContactFields = .all
        configuration.returnedContactInfo = .all

        return configuration
    }

    func handle(_ response: JPResponse?, error: Error?) -> JPTransactionData? {
        if let judoError = error as NSError? {
            self.handle(error: judoError)
        }

        if let response = response, let items = response.items, items.count > 0 {
            self.handle(response: response)
            return response.items?.first
        }

        return nil
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

    func handle(response: JPResponse) {
        let detailsViewController = TransactionDetailsTableViewController(title: "Payment receipt",
                                                                          response: response)
        dismiss(animated: true) {
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }

    func presentAlert(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension MainViewController: SettingsTableViewControllerDelegate {
    func settingsTable(viewController: SettingsTableViewController, didUpdate settings: Settings) {
        self.settings = settings
    }
}
