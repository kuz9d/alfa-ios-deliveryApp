import UIKit

class LoginView: UIView {

    let usernameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()

    let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        return button
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        [usernameField, passwordField, loginButton, errorLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            usernameField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            usernameField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),

            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }

    func hideError() {
        errorLabel.isHidden = true
    }
}
