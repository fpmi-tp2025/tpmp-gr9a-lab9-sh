//
//  MenuViewController.swift
//  Bank
//
//  Created by Victoria Ivanova on 25.05.25.
//

import UIKit

class MenuViewController: UIViewController {

    private let accountsButton: UIButton = {
        return MenuViewController.makeButton(title: "Accounts")
    }()
    private let currencyButton: UIButton = {
        return MenuViewController.makeButton(title: "Currency Converter")
    }()
    private let mapButton: UIButton = {
        return MenuViewController.makeButton(title: "Map")
    }()
    private let backButton: UIButton = {
        return MenuViewController.makeButton(title: "Back")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#D5ECD4")
        setupLayout()
    }

    private func setupLayout() {
        [accountsButton, currencyButton, mapButton, backButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            // смещаем три кнопки по вертикали вокруг центра:
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

            // «Back» остаётся внизу, но по центру:
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalTo: accountsButton.widthAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    private static func makeButton(title: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = UIColor(hex: "#C3DAC3")
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        btn.layer.cornerRadius = 12
        return btn
    }
}
