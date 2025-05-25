import UIKit

class AccountViewController: UIViewController {

    // передаётся из списка
    var accountId: Int64!

    // данные
    private var account: Account!
    private var ownerName: String!

    // контейнер-карточка
    private let cardView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "#C3DAC3").withAlphaComponent(0.3)
        v.layer.cornerRadius = 20
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    // заголовки
    private let ownerTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Owner"
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private let ownerValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let idTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Account ID"
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private let idValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let typeTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Account Type"
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private let typeValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let balanceTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Balance"
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private let balanceValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    // кнопка назад
    private let backButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Back", for: .normal)
        b.backgroundColor = UIColor(hex: "#C3DAC3")
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 20
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#D5ECD4")

        // загружаем данные
        guard let a = DatabaseManager.shared.getAccount(accountId) else { return }
        account = a
        ownerName = DatabaseManager.shared.getUsername(for: a.userId) ?? "—"

        // подписываем value-лейблы
        ownerValueLabel.text   = ownerName
        idValueLabel.text      = "\(a.id)"
        typeValueLabel.text    = a.type.capitalized
        balanceValueLabel.text = String(format: "%.2f$", a.balance)

        setupLayout()
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    }

    private func setupLayout() {
        // сначала карточка
        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            // высота карточки ≈ 50% от экрана
            cardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])

        // внутри карточки — стэк из 4 пар title+value
        let stack = UIStackView(arrangedSubviews: [
            ownerTitleLabel, ownerValueLabel,
            idTitleLabel,     idValueLabel,
            typeTitleLabel,   typeValueLabel,
            balanceTitleLabel,balanceValueLabel
        ])
        stack.axis = .vertical
        stack.spacing = 8
        stack.setCustomSpacing(16, after: ownerValueLabel)
        stack.setCustomSpacing(16, after: idValueLabel)
        stack.setCustomSpacing(16, after: typeValueLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false

        cardView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -20)
        ])

        // и кнопка «Back»
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }

    @objc private func didTapBack() {
        dismiss(animated: true, completion: nil)
    }
}
