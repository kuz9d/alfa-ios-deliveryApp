import UIKit

final class ProductDetailViewController: UIViewController {
    
    private let viewModel: ProductDetailViewModelProtocol

    private lazy var detailView = ProductDetailView()

    init(viewModel: ProductDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        detailView.titleLabel.text = viewModel.title
        detailView.descriptionLabel.text = viewModel.description
        detailView.priceLabel.text = viewModel.priceText

        if let url = viewModel.imageURL {
            loadImage(from: url)
        }
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self.detailView.imageView.image = image
            }
        }.resume()
    }
}
