import Foundation

extension ProcessInfo {
    var bduiLogin: String {
        return environment["BDUI_LOGIN"] ?? ""
    }
    var bduiPassword: String {
        return environment["BDUI_PASSWORD"] ?? ""
    }
}
