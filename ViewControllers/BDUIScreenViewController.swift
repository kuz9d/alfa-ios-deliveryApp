import UIKit

public final class BDUIScreenViewController: UIViewController {
    private let endpoint: URL
    private let authLogin: String
    private let authPassword: String
    private let mapper = BDUIMapper()
    private var scroll: UIScrollView!
    private var contentView: UIView?

    public init(endpoint: URL, login: String, password: String) {
        self.endpoint = endpoint
        self.authLogin = login
        self.authPassword = password
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScroll()
        loadAndRender()
    }

    private func setupScroll() {
        scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll)
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadAndRender() {
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"

        let creds = "\(authLogin):\(authPassword)"
        if let data = creds.data(using: .utf8)?.base64EncodedString() {
            request.setValue("Basic \(data)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("BDUI: network error:", error)
                return
            }
            guard let http = response as? HTTPURLResponse else {
                print("BDUI: no HTTPURLResponse")
                return
            }
            guard (200..<300).contains(http.statusCode) else {
                print("BDUI: HTTP \(http.statusCode)")
                return
            }
            guard let data = data, !data.isEmpty else {
                print("BDUI: empty response from \(self.endpoint)")
                return
            }
            do {
                let root = try JSONDecoder().decode(BDUIComponent.self, from: data)
                DispatchQueue.main.async {
                    self.render(component: root)
                }
            } catch {
                print("BDUI: decode error:", error)
            }
        }.resume()
    }

    private func render(component: BDUIComponent) {
        contentView?.removeFromSuperview()
        let dyn = mapper.view(from: component)
        contentView = dyn

        scroll.addSubview(dyn)
        dyn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dyn.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            dyn.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            dyn.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            dyn.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            dyn.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor)
        ])
    }
}
