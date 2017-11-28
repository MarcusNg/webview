//
//  WebVC.swift
//  webview
//
//  Created by Marcus Ng on 11/27/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var urlTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.urlTF.delegate = self
        self.webView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Request URL
        let urlString: String = "https://www.google.com"
        requestURL(urlString: urlString)
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        if self.webView.canGoBack {
            self.webView.goBack()
        }
    }
    
    @IBAction func forwardBtnPressed(_ sender: Any) {
        if self.webView.canGoForward {
            self.webView.goForward()
        }
    }
    
    func requestURL(urlString: String) {
        let url: URL = URL(string: urlString)!
        let urlRequest: URLRequest = URLRequest(url: url)
        self.webView.load(urlRequest)
        
        self.urlTF.text = urlString
    }
    
}

extension WebVC: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.backBtn.isEnabled = webView.canGoBack
        self.forwardBtn.isEnabled = webView.canGoForward
        
        self.urlTF.text = webView.url?.absoluteString
    }
    
}

extension WebVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString: String = self.urlTF.text!
        requestURL(urlString: urlString)
        
        textField.resignFirstResponder()
        
        return true
    }
    
}
