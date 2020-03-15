import UIKit
import JudoKitObjC

class TransactionDetailsTableViewController: UITableViewController {
    
    private var data: [DetailsTableViewSection] = []
    private let response: JPResponse
    
    init(title: String, response: JPResponse) {
        self.response = response
        super.init(style: .grouped)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = buildDetailsTableData(from: response)
        
        if presentingViewController != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                target: self,
                                                                action: #selector(didTapDone))
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "reuseIdentifier"
        let row = data[indexPath.section].rows[indexPath.row]
        
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: identifier)
        let cell = reusableCell ?? UITableViewCell(style: .value1, reuseIdentifier: identifier)
        
        cell.selectionStyle = .none
        cell.textLabel?.text = row.title
        cell.detailTextLabel?.text = row.value
        cell.detailTextLabel?.numberOfLines = 0
        cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = row.title
        
        return cell
    }
    
    @objc func didTapDone() {
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
            return
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Helpers
    private func buildDetailsTableData(from response: JPResponse) -> [DetailsTableViewSection] {
        var data: [DetailsTableViewSection] = []
        
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZZZZZ"
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy-MM-dd, HH:mm"
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        
        if let transactionData = response.items?.first {
            var stampDate = ""
            if let createdAtDate = inputDateFormatter.date(from: transactionData.createdAt) {
                stampDate = outputDateFormatter.string(from: createdAtDate)
            }
            
            var formattedAmount = ""
            if let transactionAmount = transactionData.amount, let amount = Double(transactionAmount.amount) {
                currencyFormatter.currencyCode = transactionAmount.currency
                formattedAmount = currencyFormatter.string(from: NSNumber(value: amount)) ?? ""
            }
            
            // General
            let generalRows = [
                DetailsTableViewRow(title: "Date", value: stampDate),
                DetailsTableViewRow(title: "Amount", value: formattedAmount),
                DetailsTableViewRow(title: "Resolution", value: transactionData.message ?? "")
            ]
            data.append(DetailsTableViewSection(title: "General", rows: generalRows))
            
            // Card details
            if let cardDetails = transactionData.cardDetails {
                let cardDetailsRows = [
                    DetailsTableViewRow(title: "Card last 4 digits", value: cardDetails.cardLastFour ?? ""),
                    DetailsTableViewRow(title: "Expiry date", value:self.formatExpiryDate(date: cardDetails.endDate)),
                    DetailsTableViewRow(title: "Card token", value: cardDetails.cardToken ?? ""),
                    DetailsTableViewRow(title: "Card type", value: "\(cardDetails.cardNetwork.rawValue)"),
                    DetailsTableViewRow(title: "Bank", value: cardDetails.bank ?? ""),
                    DetailsTableViewRow(title: "Card category", value: cardDetails.cardCategory ?? ""),
                    DetailsTableViewRow(title: "Card country", value: cardDetails.cardCountry ?? ""),
                    DetailsTableViewRow(title: "Card funding", value: cardDetails.cardFunding ?? ""),
                    DetailsTableViewRow(title: "Card scheme", value: cardDetails.cardScheme ?? "")
                ]
                data.append(DetailsTableViewSection(title: "Card Details", rows: cardDetailsRows))
            }
        }
        
        if let billingInfo = response.billingInfo {
            data.append(DetailsTableViewSection(title: "Billing Details",
                                                rows: contactDetailsRows(from: billingInfo)))
        }
        
        if let shippingInfo = response.shippingInfo {
            data.append(DetailsTableViewSection(title: "Shipping Details",
                                                rows: contactDetailsRows(from: shippingInfo)))
        }
        
        return data
    }
    
    private func contactDetailsRows(from contact: JPContactInformation) -> [DetailsTableViewRow] {
        var nameComponents: [String] = []
        var addressComponents: [String] = []
        
        nameComponents.append(contact.name?.namePrefix ?? "")
        nameComponents.append(contact.name?.givenName ?? "")
        nameComponents.append(contact.name?.middleName ?? "")
        nameComponents.append(contact.name?.familyName ?? "")
        nameComponents.append(contact.name?.nameSuffix ?? "")
        
        addressComponents.append(contact.postalAddress?.street ?? "")
        addressComponents.append(contact.postalAddress?.city ?? "")
        addressComponents.append(contact.postalAddress?.country ?? "")
        addressComponents.append(contact.postalAddress?.state ?? "")
        addressComponents.append(contact.postalAddress?.postalCode ?? "")
        
        return [
            DetailsTableViewRow(title: "Email", value: contact.emailAddress ?? ""),
            DetailsTableViewRow(title: "Name", value: nameComponents.joined(separator: " ")),
            DetailsTableViewRow(title: "Phone", value: contact.phoneNumber ?? ""),
            DetailsTableViewRow(title: "Postal Address", value: addressComponents.joined(separator: " "))
        ]
    }
    
    func formatExpiryDate(date: String?) -> String {
        guard  let date = date else {
            return ""
        }
        
        if (date.count == 4) {
            let prefix = date.prefix(2)
            let suffix = date.suffix(2)
            return "\(prefix)/\(suffix)"
        }
        return date
    }
    
}
