import UIKit

public struct DSTextFieldViewModel {
    public let placeholder: String
    public let text: String?
    public let style: DSTextField.Style
    public let textDidChange: ((String) -> Void)?
    
    public init(
            text: String? = nil,
            placeholder: String,
            style: DSTextField.Style,
            textDidChange: ((String) -> Void)? = nil
        ) {
            self.text = text
            self.placeholder = placeholder
            self.style = style
            self.textDidChange = textDidChange
        }
}

public final class DSTextField: UIView, UITextFieldDelegate {
    public enum Style: String { case filled, underlined, border }
    private let textField = UITextField()
    public var text: String? {
            get { textField.text }
            set { textField.text = newValue }
        }
    private var changeHandler: ((String) -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) { super.init(coder: coder); setup() }

    private func setup() {
        addSubview(textField)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    public func configure(with viewModel: DSTextFieldViewModel) {
        textField.text = viewModel.text
        textField.placeholder = viewModel.placeholder
        changeHandler = viewModel.textDidChange
        switch viewModel.style {
        case .filled:
            backgroundColor = DSToken.Color.background
            layer.cornerRadius = 6
            layer.borderWidth = 0
        case .underlined:
            backgroundColor = .clear
            layer.borderWidth = 0
            let border = CALayer()
            border.backgroundColor = DSToken.Color.border.cgColor
            border.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
            layer.addSublayer(border)
        case .border:
            backgroundColor = .clear
            layer.borderColor = DSToken.Color.border.cgColor
            layer.borderWidth = 1
            layer.cornerRadius = 6
        }
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let current = textField.text ?? ""
        guard let r = Range(range, in: current) else { return true }
        let updated = current.replacingCharacters(in: r, with: string)
        changeHandler?(updated)
        return true
    }
}
