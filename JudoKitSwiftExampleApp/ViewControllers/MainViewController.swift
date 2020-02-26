import UIKit
import JudoKitObjC

class MainViewController: UITableViewController {
    
    var settings: Settings = Settings(isAVSEnabled: false, currency: .GBP)
    var judoKit = JudoKit(token: token, secret: secret)
    var locationManager = CLLocationManager()
    var transactionData: JPTransactionData?
    let consumerReference = "judoPay-sample-app"
    let defaultFeatures = [
        DemoFeature(type: .payment,
                    title: "Pay with card",
                    details: "bby entering card details"),
        
        DemoFeature(type: .preAuth,
                    title: "PreAuth with card",
                    details: "by entering card details"),
        
        DemoFeature(type: .createCardToken,
                    title: "Register card",
                    details: "to be stored for future transactions"),
        
        DemoFeature(type: .checkCard,
                    title: "Check card",
                    details: "to validate a card"),
        
        DemoFeature(type: .saveCard,
                    title: "Save card",
                    details: "to be stored for future transactions"),
        DemoFeature(type: .applePayPayment,
                    title: "Apple Pay payment",
                    details: "with a wallet card"),
        
        DemoFeature(type: .applePayPreAuth,
                    title: "Apple Pay preAuth",
                    details: "with a wallet card"),
        
        DemoFeature(type: .paymentMethods,
                    title: "Payment Method",
                    details: "with default payment methods"),
        
        DemoFeature(type: .preAuthMethods,
                    title: "PreAuth Methods",
                    details: "with default preauth methods")
    ]
    
    var amount: JPAmount {
        return JPAmount("0.01", currency: settings.currency.rawValue)
    }
    
    var reference: JPReference {
        return JPReference(consumerReference: consumerReference)
    }
    
    var configuration: JPConfiguration {
        let configuration: JPConfiguration(judoID: judoId, amount: amount, reference: reference)
        configuration.supportedCardNetworks = CardNetworkVisa | CardNetworkMasterCard | CardNetworkAMEX;
    }
    
    var applePayConfigurations: JPApplePayConfiguration {
        let items = [JPPaymentSummaryItem(label: "item 1", amount: 0.01),
                     JPPaymentSummaryItem(label: "item 2", amount: 0.02),
                     JPPaymentSummaryItem(label: "item 3", amount: 0.03)]
        let configurations = JPApplePayConfiguration(merchantId: merchantId,
                                                     currency: self.settings.currency.rawValue,
                                                     countryCode: "GB",
                                                     paymentSummaryItems: items)
        return configurations
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = false
        judoKit?.isSandboxed = true
        locationManager.requestWhenInUseAuthorization()
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
            
        case .checkCard:
            checkCard()
            
        case .applePayPayment:
            applePayPayment()
            
        case .applePayPreAuth:
            applePayPreAuth()
            
        case .paymentMethods:
            navigateToPaymentMethods()
            
        case .preAuthMethods:
            navigateToPreAuthMethods()
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
        self.judoKit?.invokeTransaction(with: .payment,
                                        configuration: configuration, completion: { (response, error) in
                                            _  = self.handle(response, error: error)
        })
    }
    
    @objc func preAuth() {
        self.judoKit?.invokeTransaction(with: .preAuth,
                                        configuration: configuration, completion: { (response, error) in
                                            _  = self.handle(response, error: error)
        })
    }
    
    @objc func createCardToken() {
        self.judoKit?.invokeTransaction(with: .registerCard,
                                        configuration: configuration, completion: { (response, error) in
                                            _  = self.handle(response, error: error)
        })
    }
    
    @objc func saveCard() {
        self.judoKit?.invokeTransaction(with: .saveCard,
                                        configuration: configuration, completion: { (response, error) in
                                            _  = self.handle(response, error: error)
        })
    }
    
    @objc func checkCard() {
        self.judoKit?.invokeTransaction(with: .checkCard,
                                        configuration: configuration, completion: { (response, error) in
                                            _  = self.handle(response, error: error)
        })
    }
    
    
    @objc func applePayPayment() {
        self.judoKit?.invokeApplePay(with: .payment, configuration: applePayConfigurations, completion: { (response, error) in
            _  = self.handle(response, error: error)
        })
    }
    
    @objc func applePayPreAuth() {
        self.judoKit?.invokeApplePay(with: .preAuth, configuration: applePayConfigurations, completion: { (response, error) in
            _  = self.handle(response, error: error)
        })
    }
    
    @objc func navigateToPaymentMethods() {
        self.judoKit?.invokePaymentMethodScreen(with: .payment,
                                                configuration: configuration, completion: { (response, error) in
                                                    _  = self.handle(response, error: error)
        })
    }
    
    @objc func navigateToPreAuthMethods() {
        self.judoKit?.invokePaymentMethodScreen(with: .preAuth,
                                                configuration: configuration, completion: { (response, error) in
                                                    _  = self.handle(response, error: error)
        })
    }
    
    // MARK: - Helper methods
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
