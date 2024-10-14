//
//  ViewController.swift
//  VKTest
//
//  Created by Андрей Бабкин on 26.09.2024.
//

import UIKit
import SnapKit
import WebKit

class WelcomeAuthWebView: UIViewController, WKNavigationDelegate {
    
    var viewModel: NewsFeedViewModelProtocol
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadAuthWebView()
    }
    
    func loadAuthWebView() {
        guard let myURL = URL(string: "https://oauth.vk.com/authorize?client_id=51748266&redirect_uri=https://oauth.vk.com/blank.html&scope=8194&display=mobile&response_type=token") else {
            return
        }

        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
    
    private func setupUI() {
        view.addSubview(webView)

        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    init(viewModel: NewsFeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func goToNavController() {
        let newsFeedVC = UINavigationController(rootViewController: NewsFeedViewController(viewModel: viewModel))
        
        guard let scene = UIApplication.shared.connectedScenes.first as?
                UIWindowScene,
              let window = scene.windows.first else {
            return
        }
        window.rootViewController = newsFeedVC
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard let token = params["access_token"] else {
            return
        }
        NetworkService.token = token
//        print(token)
        decisionHandler(.cancel)
        goToNavController()
    }
}

