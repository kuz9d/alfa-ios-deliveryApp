import UIKit

class LoginView: UIView {

    let titleLabel = DSLabel()
    let usernameField = DSTextField()
    let passwordField = DSTextField()
    let loginButton = DSButton()
    private let errorLabel = DSLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = DSToken.Color.background
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        titleLabel.configure(with: DSLabelViewModel(text: "Welcome", style: .title1))
        titleLabel.textAlignment = .center
        usernameField.configure(with: DSTextFieldViewModel(placeholder: "Username", style: .filled, textDidChange: nil))
        passwordField.configure(with: DSTextFieldViewModel(placeholder: "Password", style: .filled, textDidChange: nil))
        loginButton.configure(with: DSButtonViewModel(title: "Login", style: .primary, action: nil))
        errorLabel.configure(with: DSLabelViewModel(text: "", style: .caption))
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true

        let stack = DSStackView()
        stack.configure(with: DSStackViewViewModel(
            axis: .vertical,
            spacing: DSToken.Spacing.medium,
            distribution: .fill,
            alignment: .fill
        ))

        [titleLabel, usernameField, passwordField, loginButton, errorLabel].forEach { stack.addArrangedSubview($0) }
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: DSToken.Spacing.large),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DSToken.Spacing.medium),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DSToken.Spacing.medium)
        ])
    }

    func showError(_ message: String) {
        errorLabel.configure(with: DSLabelViewModel(text: message, style: .caption))
        errorLabel.isHidden = false
    }

    func hideError() {
        errorLabel.isHidden = true
    }
}
