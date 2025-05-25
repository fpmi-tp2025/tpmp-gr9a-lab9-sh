import UIKit

class ViewController: UIViewController {
    private let usernameField: UITextField = {
      let tf = UITextField()
      tf.placeholder = "Username"
      tf.backgroundColor = UIColor(hex: "#C3DAC3")
      tf.layer.cornerRadius = 8
      tf.translatesAutoresizingMaskIntoConstraints = false
      tf.setLeftPadding(12)
      return tf
    }()

    private let passwordField: UITextField = {
      let tf = UITextField()
      tf.placeholder = "Password"
      tf.isSecureTextEntry = true
      tf.backgroundColor = UIColor(hex: "#C3DAC3")
      tf.layer.cornerRadius = 8
      tf.translatesAutoresizingMaskIntoConstraints = false
      tf.setLeftPadding(12)
      return tf
    }()

    private let loginButton: UIButton = {
      let btn = UIButton(type: .system)
      btn.setTitle("Login", for: .normal)
      btn.backgroundColor = UIColor(hex: "#C3DAC3")
      btn.setTitleColor(.white, for: .normal)
      btn.layer.cornerRadius = 8
      btn.translatesAutoresizingMaskIntoConstraints = false
      return btn
    }()

    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor(hex: "#D5ECD4")
      setupLayout()
      loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }

    private func setupLayout() {
      [usernameField, passwordField, loginButton].forEach(view.addSubview)
      NSLayoutConstraint.activate([
        usernameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
        usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        usernameField.heightAnchor.constraint(equalToConstant: 44),

        passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 16),
        passwordField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
        passwordField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
        passwordField.heightAnchor.constraint(equalTo: usernameField.heightAnchor),

        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 32),
        loginButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
        loginButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
        loginButton.heightAnchor.constraint(equalToConstant: 50),
      ])
    }

    @objc private func didTapLogin() {
      let u = usernameField.text ?? ""
      let p = passwordField.text ?? ""
      if let uid = DatabaseManager.shared.validateUser(username: u, password: p) {
        let menu = MenuViewController()
        menu.userId = uid
        present(menu, animated: true)
      } else {
        let alert = UIAlertController(title: "Error", message: "Invalid username or password", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
      }
    }
}
