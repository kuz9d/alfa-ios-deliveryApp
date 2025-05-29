import UIKit

final class ProductViewCell: UITableViewCell {
    static let reuseId = "ProductViewCell"
    
    private static let imageCache = NSCache<NSURL, UIImage>()

    private lazy var productImageView = UIImageView()
    private lazy var nameLabel = DSLabel()
    private lazy var priceLabel = DSLabel()
    private lazy var stack = DSStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        selectionStyle = .none

        productImageView.contentMode = .scaleAspectFit
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80)
        ])

        nameLabel.configure(with: DSLabelViewModel(text: "", style: .body))
        priceLabel.configure(with: DSLabelViewModel(text: "", style: .caption))

        stack.configure(with: DSStackViewViewModel(
            axis: .horizontal,
            spacing: DSToken.Spacing.small,
            distribution: .fill,
            alignment: .center
        ))
        stack.addArrangedSubview(productImageView)
        let textStack = DSStackView()
        textStack.configure(with: DSStackViewViewModel(
            axis: .vertical,
            spacing: DSToken.Spacing.xxSmall,
            distribution: .fill,
            alignment: .leading
        ))
        textStack.addArrangedSubview(nameLabel)
        textStack.addArrangedSubview(priceLabel)
        stack.addArrangedSubview(textStack)

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: DSToken.Spacing.small),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DSToken.Spacing.medium),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DSToken.Spacing.medium),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -DSToken.Spacing.small)
        ])
    }

    func configure(with item: ProductDisplayItem) {
        nameLabel.configure(with: DSLabelViewModel(text: item.name, style: .body))
        priceLabel.configure(with: DSLabelViewModel(text: item.priceText, style: .caption))
        productImageView.image = UIImage(systemName: "photo")
        if let url = item.imageURL {
            loadImage(from: url)
        }
    }

    private func loadImage(from url: URL) {
        if let cachedImage = ProductViewCell.imageCache.object(forKey: url as NSURL) {
            self.productImageView.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard
                let self = self,
                let data = data,
                let image = UIImage(data: data),
                error == nil
            else { return }

            ProductViewCell.imageCache.setObject(image, forKey: url as NSURL)

            DispatchQueue.main.async {
                self.productImageView.image = image
            }
        }.resume()
    }
}
