//
//  WebCollectionViewCell.swift
//  mockTabBrowser
//
//  Created by mzgk on 2016/11/18.
//  Copyright © 2016年 mzgk. All rights reserved.
//

import UIKit
import WebKit

class WebCollectionViewCell: UICollectionViewCell, WKUIDelegate {
    @IBOutlet weak var baseView: UIView!

    var wkWebView: WKWebView?

    func generateWKWebView(viewSize frame: CGRect) {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true

        wkWebView = WKWebView(frame: frame, configuration: webConfiguration)
        wkWebView?.uiDelegate = self
        wkWebView?.allowsBackForwardNavigationGestures = true
        wkWebView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        loadURL(urlString: "http://www.yahoo.co.jp/")
        baseView.addSubview(wkWebView!)
        print("WebView5 : \(wkWebView?.bounds)")
    }

    func loadURL(urlString: String) {
        DispatchQueue.global(qos: .default).async {
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            _ = self.wkWebView?.load(request)
        }
    }
}
