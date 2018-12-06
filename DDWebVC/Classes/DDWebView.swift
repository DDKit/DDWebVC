//
//  DDWebView.swift
//  DDWebVC
//
//  Created by 风荷举 on 2018/12/6.
//

import UIKit

public class DDWebView: UIView {
    
    
}

/*
import UIKit
import WebKit
import SnapKit
import SVProgressHUD

public enum PlatformType: String {
    case defau = "0"
    case oldCP = "100"
    case newCP = "101"
    case sport = "200"
    case chess = "300"
}

public class DDWebView: UIView {
    
    private var url: String?
    
    private lazy var config: WKWebViewConfiguration = {
        let conf: WKWebViewConfiguration = WKWebViewConfiguration()
        conf.preferences = WKPreferences()
        conf.preferences.minimumFontSize = 10.0
        conf.preferences.javaScriptEnabled = true
        conf.preferences.javaScriptCanOpenWindowsAutomatically = false
        conf.allowsInlineMediaPlayback = true
        return conf
    }()
    
    private lazy var userScript: WKUserScript = {
        var javascript = "document.documentElement.style.webkitTouchCallout='none';"
        javascript += "document.documentElement.style.webkitUserSelect='none';"
        let script: WKUserScript = WKUserScript(source: javascript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        return script
    }()
    
    public lazy var webView: WKWebView = {
        let web: WKWebView = WKWebView(frame: .zero, configuration: config)
        web.configuration.userContentController.addUserScript(userScript)
        web.frame = .zero
        web.isMultipleTouchEnabled = true
        web.autoresizesSubviews = true
        web.scrollView.alwaysBounceVertical = true
        web.allowsBackForwardNavigationGestures = true
        web.sizeToFit()
        if #available(iOS 11.0, *) {
            web.scrollView.contentInsetAdjustmentBehavior = .never
        }
        addSubview(web)
        return web
    }()
    
}

extension DDWebView
{
    open func settingDelegate(_ vc: CIWebVC)
    {
        webView.uiDelegate = vc
        webView.navigationDelegate = vc
        webView.scrollView.delegate = vc
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        webView.snp.remakeConstraints {
            $0.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    // 加载
    open func loadUrl(_ url: String) {
        self.url = url
        let url: URL = URL(string: url)!
        let request: URLRequest = URLRequest(url: url)
        webView.load(request)
    }
    
    // 重新加载
    open func reload() {
        if url == nil { return }
        let myUrl: URL = URL(string: url!)!
        let request: URLRequest =
            URLRequest(url: myUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 8)
        webView.load(request)
    }
    
    // 刷新
    open func refresh() {
        webView.reloadFromOrigin()
    }
    
    // 前进
    open func forward() {
        if webView.canGoForward { webView.goForward() }
    }
    
    // 后退
    open func back() {
        if webView.canGoBack { webView.goBack()}
    }
    
}
*/
