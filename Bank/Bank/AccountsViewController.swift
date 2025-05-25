//
//  AccountsViewController.swift.swift
//  Bank
//
//  Created by Victoria Ivanova on 25.05.25.
//

import UIKit

class AccountsViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)

    private let backButton: UIButton = {
        return AccountsViewController.makeButton(title: "Back")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#D5ECD4")
        setupTable()
        setupLayout()
    }

    private func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.backgroundColor = .clear
    }

    private func setupLayout() {
        [tableView, backButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            // таблица сверху до кнопки
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -16),

            // смещаем кнопку «Back» вверх ближе к центру
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
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

extension AccountsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: вернуть реальное число
        return 0
    }

    func tableView(_ tv: UITableView,
                   cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        return tv.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    }
}


//#if DEBUG
//import SwiftUI
//
//// Обёртка для показа UIViewController в SwiftUI
//struct UIViewControllerPreview<VC: UIViewController>: UIViewControllerRepresentable {
//    let makeVC: () -> VC
//    init(_ builder: @escaping () -> VC) {
//        self.makeVC = builder
//    }
//    func makeUIViewController(context: Context) -> VC { makeVC() }
//    func updateUIViewController(_ uiViewController: VC, context: Context) {}
//}
//
//// PreviewProvider для MenuViewController
//struct MenuViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        UIViewControllerPreview {
//            MenuViewController()
//        }
//        .previewDevice("iPhone 14 Pro")
//        .edgesIgnoringSafeArea(.all)
//    }
//}
//
//// Аналогично для AccountsViewController
//struct AccountsViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        UIViewControllerPreview {
//            AccountsViewController()
//        }
//        .previewDevice("iPhone 14 Pro")
//        .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct ConverterViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        UIViewControllerPreview {
//            ConverterViewController()
//        }
//        .previewDevice("iPhone 14 Pro")
//        .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct AccountViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        UIViewControllerPreview {
//            AccountViewController()
//        }
//        .previewDevice("iPhone 14 Pro")
//        .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct MapViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        UIViewControllerPreview {
//            MapViewController()
//        }
//        .previewDevice("iPhone 14 Pro")
//        .edgesIgnoringSafeArea(.all)
//    }
//}
//#endif
