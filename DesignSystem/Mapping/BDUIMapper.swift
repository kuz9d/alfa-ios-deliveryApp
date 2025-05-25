import UIKit

public final class BDUIMapper: BDUIMapperProtocol {
    private var boundValues: [String: String] = [:]
    public typealias RootView = UIView
    public init() {}

    public func view(from component: BDUIComponent) -> UIView {
        let base: UIView
        switch component.content {
        case .contentView(let cfg):
            let sv = DSStackView()
            sv.configure(with: DSStackViewViewModel(
                axis: .vertical,
                spacing: DSToken.Spacing.medium,
                distribution: .fill,
                alignment: .fill
            ))
            if let bg = cfg.backgroundColor {
                sv.backgroundColor = UIColor(named: bg) ?? .white
            }
            base = sv

        case .stackView(let cfg):
            let sv = DSStackView()
            let axis: NSLayoutConstraint.Axis = (cfg.axis == "horizontal") ? .horizontal : .vertical
            let spacing = tokenSpacing(cfg.spacing) ?? DSToken.Spacing.medium
            sv.configure(with: DSStackViewViewModel(
                axis: axis,
                spacing: spacing,
                distribution: .fill,
                alignment: .fill
            ))
            base = sv

        case .label(let cfg):
            let style = DSLabel.Style(rawValue: cfg.style ?? "body") ?? .body
            let lbl = DSLabel()
            lbl.configure(with: DSLabelViewModel(text: cfg.text, style: style))
            base = lbl

        case .button(let cfg):
            let style = DSButton.Style(rawValue: cfg.style ?? "primary") ?? .primary
            let btn = DSButton()
            let action = cfg.action.flatMap(makeAction)
            btn.configure(with: DSButtonViewModel(title: cfg.text, style: style, action: action))
            base = btn
            
        case .textField(let cfg):
            let tf = DSTextField()
            tf.configure(with: DSTextFieldViewModel(
                text: nil,
                placeholder: cfg.placeholder,
                style: DSTextField.Style(rawValue: cfg.style ?? "filled")!,
                textDidChange: { text in
                    if let key = cfg.bind { self.boundValues[key] = text }
                }
            ))
            base = tf
        }

        component.subviews?.forEach {
            let child = view(from: $0)
            if let stack = base as? UIStackView {
                stack.addArrangedSubview(child)
            } else {
                base.addSubview(child)
            }
        }
        return base
    }

    private func tokenSpacing(_ token: String?) -> CGFloat? {
        guard let t = token else { return nil }
        switch t {
        case "xxSmall": return DSToken.Spacing.xxSmall
        case "xSmall":  return DSToken.Spacing.xSmall
        case "small":   return DSToken.Spacing.small
        case "medium":  return DSToken.Spacing.medium
        case "large":   return DSToken.Spacing.large
        case "xLarge":  return DSToken.Spacing.xLarge
        default:
            return CGFloat(Double(t) ?? 0)
        }
    }

    private func makeAction(_ action: BDUIAction) -> (() -> Void) {
        switch action.type {
        case "print": return { print(action.context ?? "") }
        default:       return {}
        }
    }
}
