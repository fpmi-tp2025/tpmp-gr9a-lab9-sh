//
//  ViewControllerConverter.swift
//  BankApp
//
//  Created by Ivan Hontarau on 25.05.25.
//


import UIKit

class ViewControllerConverter: UIViewController {

    @IBOutlet weak var outputCurrency: UISegmentedControl!
    @IBOutlet weak var inputCurrency: UISegmentedControl!
    @IBOutlet weak var outputField: UITextField!
    @IBOutlet weak var inputField: UITextField!

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func convert(_ sender: Any) {
        Task {
            await performConversion()
        }
    }

    func performConversion() async {
        let inputCurrency = inputCurrency.titleForSegment(at: inputCurrency.selectedSegmentIndex)
        let outputCurrency = outputCurrency.titleForSegment(at: outputCurrency.selectedSegmentIndex)
        let inputAmount = Double(inputField.text!) ?? 0.0

        await fetchCurrencyConversion(source: inputCurrency!, target: outputCurrency!) { (currencyConversion) in
            if let currencyConversion = currencyConversion {
                print(inputAmount * currencyConversion)
                self.outputField.text = String(inputAmount * currencyConversion)
            }
        }
    }

    struct CurrencyConversion: Codable {
        let rates: [String: Double]
    }


    func fetchCurrencyConversion(source: String, target: String, completion: @escaping (Double?) -> Void) async {
        let url = URL(string: "https://openexchangerates.org/api/latest.json")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "app_id", value: "255d6ec470104b79ae6566c905944294"),
            URLQueryItem(name: "prettyprint", value: "false"),
            URLQueryItem(name: "show_alternative", value: "false"),
        ]
        components.queryItems = components.queryItems.map {
            $0 + queryItems
        } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["accept": "application/json"]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let conversion = try decoder.decode(CurrencyConversion.self, from: data)
            let rates = conversion.rates
            completion(rates[target]! / rates[source]!)
        } catch {
            print("error")
        }
    }


    // MARK: - Navigation


}
