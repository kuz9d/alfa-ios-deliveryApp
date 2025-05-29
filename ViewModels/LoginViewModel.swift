class LoginViewModel: LoginViewModelProtocol {
    func validate(username: String, password: String) -> String? {
        if username.isEmpty || password.isEmpty {
            return "Please enter both username and password."
        }
        return nil
    }

    func login(username: String, password: String) -> Bool {
        return username == "123" && password == "123"
    }
}
