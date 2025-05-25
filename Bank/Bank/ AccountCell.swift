import UIKit

class AccountCell: UITableViewCell {
    static let identifier = "AccountCell"

    // MARK: UI
    private let cardView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "#C3DAC3").withAlphaComponent(0.3)
        v.layer.cornerRadius = 16
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let idLabel = UILabel()
    private let typeLabel = UILabel()
    private let balanceLabel = UILabel()

    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
        setupCard()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupCard() {
        [idLabel, typeLabel, balanceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 16)
        }
        idLabel.font = .systemFont(ofSize: 16, weight: .medium)
        typeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        balanceLabel.font = .systemFont(ofSize: 16, weight: .medium)

        contentView.addSubview(cardView)
        cardView.addSubview(idLabel)
        cardView.addSubview(typeLabel)
        cardView.addSubview(balanceLabel)

        NSLayoutConstraint.activate([
            // карточка отступ 16 по бокам и 8 сверху/снизу
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            // ID
            idLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            idLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            idLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),

            // Type
            typeLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 8),
            typeLabel.leadingAnchor.constraint(equalTo: idLabel.leadingAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: idLabel.trailingAnchor),

            // Balance
            balanceLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
            balanceLabel.leadingAnchor.constraint(equalTo: idLabel.leadingAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: idLabel.trailingAnchor),
            balanceLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12)
        ])
    }

    // MARK: configure
    func configure(with account: Account) {
        idLabel.text      = "ID: \(account.id)"
        typeLabel.text    = "Type: \(account.type.capitalized)"
        balanceLabel.text = String(format: "Balance: %.2f$", account.balance)
    }
}
