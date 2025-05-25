import UIKit

public struct DSStackViewViewModel {
    public let axis: NSLayoutConstraint.Axis
    public let spacing: CGFloat
    public let distribution: UIStackView.Distribution
    public let alignment: UIStackView.Alignment
}

public final class DSStackView: UIStackView {
    public func configure(with viewModel: DSStackViewViewModel) {
        axis = viewModel.axis
        spacing = viewModel.spacing
        distribution = viewModel.distribution
        alignment = viewModel.alignment
    }
}
