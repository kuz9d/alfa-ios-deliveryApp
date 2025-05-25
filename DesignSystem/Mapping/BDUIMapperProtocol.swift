import UIKit

public protocol BDUIMapperProtocol {
    associatedtype RootView: UIView
    func view(from component: BDUIComponent) -> RootView
}
