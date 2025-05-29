import UIKit

final class ProductDetailView: UIView {
    let imageView = UIImageView()
    let titleLabel = DSLabel()
    let descriptionLabel = DSLabel()
    let priceLabel = DSLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = DSToken.Color.background
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        imageView.contentMode = .scaleAspectFit
        let stack = DSStackView()
        stack.configure(with: DSStackViewViewModel(
            axis: .vertical,
            spacing: DSToken.Spacing.medium,
            distribution: .fill,
            alignment: .center
        ))
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(priceLabel)
        stack.addArrangedSubview(descriptionLabel)

        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: DSToken.Spacing.large),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DSToken.Spacing.medium),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DSToken.Spacing.medium),
            imageView.widthAnchor.constraint(equalTo: stack.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
