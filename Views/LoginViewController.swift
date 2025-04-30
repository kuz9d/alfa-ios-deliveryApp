import UIKit

class LoginViewController: UIViewController {

    private let viewModel: LoginViewModelProtocol

    private lazy var loginView = LoginView()

    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }

    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }

    @objc private func loginTapped() {
        let username = loginView.usernameField.text ?? ""
        let password = loginView.passwordField.text ?? ""

        if let validationError = viewModel.validate(username: username, password: password) {
            loginView.showError(validationError)
            return
        }

        if viewModel.login(username: username, password: password) {
            loginView.hideError()
            print("Logged in successfully!")
        } else {
            loginView.showError("Invalid credentials. Try again.")
        }
    }
}
