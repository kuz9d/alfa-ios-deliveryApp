class LoginViewModel: LoginViewModelProtocol {
    func login(username: String, password: String) -> Bool {
        return username == "user" && password == "password"
    }
}
