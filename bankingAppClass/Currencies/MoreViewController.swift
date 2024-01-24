//
//  MoreViewController.swift
//  bankingAppClass
//
//  Created by Cavidan Mustafayev on 29.01.24.
//

import UIKit
import SWXMLHash


struct Currency {
    var code: String
    var name: String
    var rate: Double
}


class MoreViewController: UIViewController, XMLParserDelegate {
    
    var currencies: [Currency] = []
    @IBOutlet weak var currencyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyTableView.dataSource = self
        currencyTableView.delegate = self
        fetchDataFromXML()
    }
    
    func fetchDataFromXML() {
        let urlString = "https://www.cbar.az/currencies/23.02.2024.xml"
        
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                do {
                    let xml = XMLHash.parse(data)
                    let valTypes = xml["ValCurs"]["ValType"].all
                    for valType in valTypes {
                        let valutes = valType["Valute"].all
                        for valute in valutes {
                            if let code = valute.element?.attribute(by: "Code")?.text,
                               let name = valute["Name"].element?.text,
                               let valueText = valute["Value"].element?.text,
                               let value = Double(valueText) {
                                if ["USD", "EUR", "GEL", "GBP", "CAD", "TRY", "UAH", "JPY"].contains(code) {
                                    let currency = Currency(code: code, name: name, rate: value)
                                    self.currencies.append(currency)
                                    print(currency)
                                }
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.currencyTableView.reloadData()
                    }
                } catch {
                    print("XML parsing error: \(error)")
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
        let currency = currencies[indexPath.row]
        cell.nameLabel.text = "\(currency.code)  \(currency.name)   \(currency.rate) AZN "
        return cell
    }
}
