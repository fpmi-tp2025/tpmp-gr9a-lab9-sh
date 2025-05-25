import UIKit

class ConverterViewController: UIViewController {
    private let sumField = UITextField()
    private let origSeg = UISegmentedControl(items:["BYN","USD","RUB","EUR"])
    private let targetSeg = UISegmentedControl(items:["BYN","USD","RUB","EUR"])
    private let resultField = UITextField()
    private let convertBtn = UIButton(type:.system)
    private let backBtn    = UIButton(type:.system)

    private let rates: [String:Double] = ["BYN":1, "USD":2.5, "RUB":0.03, "EUR":3.0]

    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor(hex: "#D5ECD4")

      [sumField, origSeg, targetSeg, resultField, convertBtn, backBtn].forEach {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
      }

      sumField.placeholder = "sum"
      sumField.backgroundColor = UIColor(hex: "#C3DAC3"); sumField.layer.cornerRadius = 12; sumField.setLeftPadding(12)
      resultField.placeholder = "result"; resultField.backgroundColor = UIColor(hex: "#C3DAC3"); resultField.layer.cornerRadius = 12; resultField.setLeftPadding(12); resultField.isEnabled=false

      [origSeg, targetSeg].forEach {
        $0.selectedSegmentIndex = 0
        $0.backgroundColor = UIColor(hex: "#C3DAC3")
        $0.layer.cornerRadius = 12
      }

      convertBtn.setTitle("Convert", for:.normal)
      convertBtn.backgroundColor = UIColor(hex: "#C3DAC3"); convertBtn.setTitleColor(.white, for:.normal); convertBtn.layer.cornerRadius = 12

      backBtn.setTitle("Back", for:.normal)
      backBtn.backgroundColor = UIColor(hex: "#C3DAC3"); backBtn.setTitleColor(.white, for:.normal); backBtn.layer.cornerRadius = 12

      convertBtn.addTarget(self, action: #selector(convert), for: .touchUpInside)
      backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)

      NSLayoutConstraint.activate([
        sumField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        sumField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        sumField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        sumField.heightAnchor.constraint(equalToConstant: 44),

        origSeg.topAnchor.constraint(equalTo: sumField.bottomAnchor, constant: 16),
        origSeg.leadingAnchor.constraint(equalTo: sumField.leadingAnchor),
        origSeg.trailingAnchor.constraint(equalTo: sumField.trailingAnchor),
        origSeg.heightAnchor.constraint(equalToConstant: 32),

        targetSeg.topAnchor.constraint(equalTo: origSeg.bottomAnchor, constant: 16),
        targetSeg.leadingAnchor.constraint(equalTo: sumField.leadingAnchor),
        targetSeg.trailingAnchor.constraint(equalTo: sumField.trailingAnchor),
        targetSeg.heightAnchor.constraint(equalToConstant: 32),

        resultField.topAnchor.constraint(equalTo: targetSeg.bottomAnchor, constant: 16),
        resultField.leadingAnchor.constraint(equalTo: sumField.leadingAnchor),
        resultField.trailingAnchor.constraint(equalTo: sumField.trailingAnchor),
        resultField.heightAnchor.constraint(equalToConstant: 44),

        convertBtn.topAnchor.constraint(equalTo: resultField.bottomAnchor, constant: 20),
        convertBtn.leadingAnchor.constraint(equalTo: sumField.leadingAnchor),
        convertBtn.trailingAnchor.constraint(equalTo: sumField.trailingAnchor),
        convertBtn.heightAnchor.constraint(equalToConstant: 50),

        backBtn.topAnchor.constraint(equalTo: convertBtn.bottomAnchor, constant: 16),
        backBtn.leadingAnchor.constraint(equalTo: sumField.leadingAnchor),
        backBtn.trailingAnchor.constraint(equalTo: sumField.trailingAnchor),
        backBtn.heightAnchor.constraint(equalToConstant: 50),
      ])
    }

    @objc private func convert() {
      guard let s = Double(sumField.text ?? ""),
            let r1 = rates[origSeg.titleForSegment(at: origSeg.selectedSegmentIndex)!],
            let r2 = rates[targetSeg.titleForSegment(at: targetSeg.selectedSegmentIndex)!]
      else { return }
      let byn = s * r1
      resultField.text = String(format: "%.2f", byn / r2)
    }

    @objc private func goBack() {
      dismiss(animated: true)
    }
}
