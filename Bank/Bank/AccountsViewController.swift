import UIKit

class AccountsViewController: UIViewController {
    var userId: Int64!

    private let tableView = UITableView()
    private let backButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Back", for: .normal)
        b.backgroundColor = UIColor(hex: "#C3DAC3")
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 12
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    private var data: [Account] = []

    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor(hex: "#D5ECD4")

      // tableView
      tableView.register(AccountCell.self,
                         forCellReuseIdentifier: AccountCell.identifier)
      tableView.dataSource = self
      tableView.delegate   = self
      tableView.backgroundColor = .clear
      tableView.separatorStyle = .none
      tableView.translatesAutoresizingMaskIntoConstraints = false

      view.addSubview(tableView)
      view.addSubview(backButton)

      NSLayoutConstraint.activate([
        // таблица сверху и по бокам
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        // до кнопки
        tableView.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -16),

        // кнопка «Back» внизу
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        backButton.heightAnchor.constraint(equalToConstant: 50)
      ])

      backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)

      // загрузим аккаунты
      data = DatabaseManager.shared.getAccounts(for: userId)
    }

    @objc private func goBack() {
      dismiss(animated: true)
    }
}

extension AccountsViewController: UITableViewDataSource {
    func tableView(_ tv: UITableView, numberOfRowsInSection s: Int) -> Int {
        data.count
    }
    func tableView(_ tv: UITableView,
                   cellForRowAt idx: IndexPath) -> UITableViewCell {
      let cell = tv.dequeueReusableCell(
         withIdentifier: AccountCell.identifier,
         for: idx
      ) as! AccountCell
      cell.configure(with: data[idx.row])
      return cell
    }
}

extension AccountsViewController: UITableViewDelegate {
    func tableView(_ tv: UITableView, didSelectRowAt idx: IndexPath) {
      let a = data[idx.row]
      let vc = AccountViewController()
      vc.accountId = a.id
      present(vc, animated: true)
    }
}
