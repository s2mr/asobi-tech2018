import UIKit

class LicenseViewController: UIViewController {

    private let webView: UIWebView = {
        let v = UIWebView(frame: .zero)
        return v
    }()

    override func loadView() {
        super.loadView()
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "license", ofType: "html")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        webView.loadHTMLString(String.init(data: data, encoding: .utf8)!, baseURL: URL(fileURLWithPath: path))
    }
}
