protocol LoginViewModelProtocol {
    func validate(username: String, password: String) -> String?
    func login(username: String, password: String) -> Bool
}
