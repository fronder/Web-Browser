//
//  FeedViewController.swift
//  TestWebView
//
//  Created by Hasan on 15/05/23.
//

import UIKit
import WebKit

protocol FeedViewControllerDelegate {
    func didRequestFeed(with url: URL)
}

public class FeedViewController: UIViewController, UITextFieldDelegate, FeedView, FeedFailureView, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var delegate: FeedViewControllerDelegate?
    var cellSelectionDelegate: HistoryCellSelectionDelegate?
    var feedStore: FeedStore
    
    init?(coder: NSCoder, delegate: FeedViewControllerDelegate, feedStore: FeedStore) {
        self.delegate = delegate
        self.feedStore = feedStore
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = "https://google.com"
        
        webView.navigationDelegate = self
    }
    
    func display(_ url: URL) {
        self.webView.load(URLRequest(url: url))
    }
    
    func display(_ failureViewModel: FeedFailureViewModel) {
        // Failure case
    }

    @IBAction func buttonDidClick(_ sender: Any) {
        navigationController?.present(HistoryUIComposer
            .composedWith(
                feedLoader: LocalFeedLoader(store: HistoryStore()),
                cellSelectionDelegate: cellSelectionDelegate), animated: true)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url, let _ = url.host else {
            return decisionHandler(.cancel)
        }
        
        feedStore.insert(url.absoluteString, completion: {_ in })
        decisionHandler(.allow)
    }
    
    @IBAction func didEndEditing(_ sender: Any) {
        guard let text = textField.text else { return }
        guard let url = URL(string: text) else { return }
        
        delegate?.didRequestFeed(with: url)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
