import UIKit

public struct DSLabelViewModel {
    public let text: String
    public let style: DSLabel.Style
}

public final class DSLabel: UILabel {
    public enum Style: String, Codable {
        case title1, title2, body, caption
    }

    public func configure(with viewModel: DSLabelViewModel) {
        text = viewModel.text
        textColor = DSToken.Color.textPrimary
        numberOfLines = 0
        switch viewModel.style {
        case .title1:
            font = DSToken.Typography.title1
        case .title2:
            font = DSToken.Typography.title2
        case .body:
            font = DSToken.Typography.body
        case .caption:
            font = DSToken.Typography.caption
            textColor = DSToken.Color.textSecondary
        }
    }
}
