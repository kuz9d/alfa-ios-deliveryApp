import UIKit

final class ProductDetailViewController: UIViewController {
    private let viewModel: ProductDetailViewModelProtocol

    private lazy var detailView = ProductDetailView()

    init(viewModel: ProductDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.titleLabel.configure(with: DSLabelViewModel(text: viewModel.title, style: .title2))
        detailView.descriptionLabel.configure(with: DSLabelViewModel(text: viewModel.description, style: .body))
        detailView.priceLabel.configure(with: DSLabelViewModel(text: viewModel.priceText, style: .caption))
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
