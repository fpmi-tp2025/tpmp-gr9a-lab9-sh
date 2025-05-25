import UIKit

class MenuViewController: UIViewController {
    var userId: Int64!

    private let accountsButton = MenuViewController.makeButton(title: "Accounts")
    private let currencyButton = MenuViewController.makeButton(title: "Currency Converter")
    private let mapButton      = MenuViewController.makeButton(title: "Map")
    private let backButton     = MenuViewController.makeButton(title: "Back")

    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor(hex: "#D5ECD4")
      [accountsButton, currencyButton, mapButton, backButton].forEach {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
      }
      setupLayout()
      accountsButton.addTarget(self, action: #selector(openAccounts), for: .touchUpInside)
      currencyButton.addTarget(self, action: #selector(openConverter), for: .touchUpInside)
      mapButton.addTarget(self, action: #selector(openMap), for: .touchUpInside)
      backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }

    private func setupLayout() {
      NSLayoutConstraint.activate([
        accountsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        accountsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
        accountsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        accountsButton.heightAnchor.constraint(equalToConstant: 50),

        currencyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        currencyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        currencyButton.widthAnchor.constraint(equalTo: accountsButton.widthAnchor),
        currencyButton.heightAnchor.constraint(equalTo: accountsButton.heightAnchor),

        mapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        mapButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
        mapButton.widthAnchor.constraint(equalTo: accountsButton.widthAnchor),
        mapButton.heightAnchor.constraint(equalTo: accountsButton.heightAnchor),

        backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        backButton.widthAnchor.constraint(equalTo: accountsButton.widthAnchor),
        backButton.heightAnchor.constraint(equalToConstant: 50),
      ])
    }

    private static func makeButton(title: String) -> UIButton {
      let b = UIButton(type: .system)
      b.setTitle(title, for: .normal)
      b.backgroundColor = UIColor(hex: "#C3DAC3")
      b.setTitleColor(.white, for: .normal)
      b.layer.cornerRadius = 12
      return b
    }

    @objc private func openAccounts() {
      let vc = AccountsViewController()
      vc.userId = userId
      present(vc, animated: true)
    }
    @objc private func openConverter() {
      present(ConverterViewController(), animated: true)
    }
    @objc private func openMap() {
      present(MapViewController(), animated: true)
    }
    @objc private func goBack() {
      dismiss(animated: true)
    }
}
