//
//  ConverterViewController.swift
//  Bank
//
//  Created by Victoria Ivanova on 25.05.25.
//

import UIKit

class ConverterViewController: UIViewController {

    private let sumField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "sum"
        tf.backgroundColor = UIColor(hex: "#C3DAC3")
        tf.layer.cornerRadius = 12
        tf.setLeftPadding(12)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let originalSegment: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["BYN","USD","RUB","EUR"])
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = UIColor(hex: "#C3DAC3")
        sc.layer.cornerRadius = 12
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    private let targetSegment: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["BYN","USD","RUB","EUR"])
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = UIColor(hex: "#C3DAC3")
        sc.layer.cornerRadius = 12
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    private let resultField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "result"
        tf.backgroundColor = UIColor(hex: "#C3DAC3")
        tf.layer.cornerRadius = 12
        tf.setLeftPadding(12)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let convertButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Convert", for: .normal)
        b.backgroundColor = UIColor(hex: "#C3DAC3")
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 12
        b.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    private let backButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Back", for: .normal)
        b.backgroundColor = UIColor(hex: "#C3DAC3")
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 12
        b.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#D5ECD4")
        setupLayout()
    }

    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [
            sumField,
            originalSegment,
            targetSegment,
            resultField,
            convertButton
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            // стек по центру, ширина 80%
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

            // высоты
            sumField.heightAnchor.constraint(equalToConstant: 44),
            originalSegment.heightAnchor.constraint(equalToConstant: 32),
            targetSegment.heightAnchor.constraint(equalToConstant: 32),
            resultField.heightAnchor.constraint(equalToConstant: 44),
            convertButton.heightAnchor.constraint(equalToConstant: 50),

            // кнопка Back под стеком
            backButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalTo: stack.widthAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
