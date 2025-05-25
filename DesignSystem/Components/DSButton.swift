import UIKit

public struct DSButtonViewModel {
    public let title: String
    public let style: DSButton.Style
    public let action: (() -> Void)?
}

public final class DSButton: UIButton {
    public enum Style { case primary, secondary, border }
    private var tapAction: (() -> Void)?

    public func configure(with viewModel: DSButtonViewModel) {
        setTitle(viewModel.title, for: .normal)
        tapAction = viewModel.action
        layer.cornerRadius = 8
        titleLabel?.font = DSToken.Typography.body
        switch viewModel.style {
        case .primary:
            backgroundColor = DSToken.Color.primary
            setTitleColor(.white, for: .normal)
        case .secondary:
            backgroundColor = DSToken.Color.secondary
            setTitleColor(.white, for: .normal)
        case .border:
            backgroundColor = .clear
            setTitleColor(DSToken.Color.primary, for: .normal)
            layer.borderWidth = 1
            layer.borderColor = DSToken.Color.primary.cgColor
        }
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    @objc private func didTap() {
        tapAction?()
    }
}
