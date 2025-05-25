//
//  AccountViewController.swift
//  Bank
//
//  Created by Victoria Ivanova on 25.05.25.
//

import UIKit

class AccountViewController: UIViewController {

    // MARK: – Внешние данные, заполняются перед показом
    var accountTitleText: String?
    var balanceValue: Double?
    var operations: [String] = []

    // MARK: – UI

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let balanceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "OpCell")
        tv.layer.cornerRadius = 12
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    private let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Back", for: .normal)
        btn.backgroundColor = UIColor(hex: "#C3DAC3")
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // MARK: – Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#D5ECD4")

        // заполняем лейблы тем, что передали извне
        titleLabel.text   = accountTitleText
        if let bal = balanceValue {
            balanceLabel.text = String(format: "Balance: %.2f", bal)
        }

        tableView.dataSource = self
        tableView.delegate   = self

        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)

        setupLayout()
    }

    // MARK: – Layout

    private func setupLayout() {
        [titleLabel, balanceLabel, tableView, backButton].forEach {
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            // Заголовок
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Баланс
            balanceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            balanceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            // Таблица операций
            tableView.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 20),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),

            // Кнопка Back
            backButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: – Actions

    @objc private func didTapBack() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: – UITableViewDataSource / Delegate

extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }

    func tableView(_ tv: UITableView,
                   cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tv.dequeueReusableCell(withIdentifier: "OpCell", for: indexPath)
        cell.textLabel?.text = operations[indexPath.row]
        return cell
    }
}
