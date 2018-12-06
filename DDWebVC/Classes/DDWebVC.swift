//
//  CIWebVC.swift
//  CIWork
//
//  Created by 风荷举 on 2018/11/24.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

public class DDWebVC: UIViewController {
        
    public func loadSB() -> DDWebVC {
//        let sb: UIStoryboard = UIStoryboard(name: "\(type(of: self))", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "\(type(of: self))")
//        object_setClass(vc, type(of: self))
        return DDWebVC()
    }
}

/*
import UIKit
import QuartzCore
import WebKit
import SVProgressHUD
import Hue
import RxAtomic
import RxSwift
import RxCocoa
import SwiftyJSON

class DDWebVC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return  .lightContent }
    
    @IBOutlet weak var webBack: DDWebView!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var bottomOff: NSLayoutConstraint!
    
    @IBOutlet weak var homeBtn: CIFlashButton!
    
    @IBOutlet weak var backBtn: CIFlashButton!
    
    @IBOutlet weak var forwardBtn: CIFlashButton!
    
    @IBOutlet weak var refreshBtn: CIFlashButton!
    
    @IBOutlet weak var shareBtn: CIFlashButton!
    
    private var tmpUrl: String = ""
    
    private var offH: CGFloat = 0
    
    var dataStr: String = "" {
        didSet{
            let model = CIModel(object: cuted(decoded(dataStr)))
            view.backgroundColor = UIColor(hex: (model.statusHex ?? "dddddd"))
            progressView.progressTintColor = UIColor(hex: (model.progressHex ?? "dddddd"))
            progressView.trackTintColor = UIColor(hex: (model.trackHex ?? "dddddd"))
            bottomView.backgroundColor = UIColor(hex: (model.themeHex ?? "dddddd"))
            offH = CGFloat(Double(model.bottomOff ?? "0") ?? 0)
            homeBtn.backgroundColor = UIColor(hex: (model.themeHex ?? "dddddd"))
            homeBtn.flashBackgroundColor = UIColor(hex: (model.themeHex ?? "dddddd"))
            backBtn.backgroundColor = UIColor(hex: (model.themeHex ?? "dddddd"))
            backBtn.flashBackgroundColor = UIColor(hex: (model.themeHex ?? "dddddd"))
            forwardBtn.backgroundColor = UIColor(hex: (model.themeHex ?? "dddddd"))
            forwardBtn.flashBackgroundColor = UIColor(hex: (model.themeHex ?? "dddddd"))
            refreshBtn.backgroundColor = UIColor(hex: (model.themeHex ?? "dddddd"))
            refreshBtn.flashBackgroundColor = UIColor(hex: (model.themeHex ?? "dddddd"))
            shareBtn.backgroundColor = UIColor(hex: (model.themeHex ?? "dddddd"))
            shareBtn.flashBackgroundColor = UIColor(hex: (model.themeHex ?? "dddddd"))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        freshLayoutUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webBack.settingDelegate(self)
        webBack.loadUrl(CIModel(object: cuted(decoded(dataStr))).url ?? "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webBack.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webBack.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (object is WKWebView)&&(keyPath == "estimatedProgress") {
            progressView.alpha = 1.0
            let animated:Bool = (Float(webBack.webView.estimatedProgress) > progressView.progress)
            progressView.setProgress(Float(webBack.webView.estimatedProgress), animated: animated)
            if webBack.webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3,
                               delay: 0.3,
                               options: .curveEaseOut,
                               animations:
                    { [weak self] in
                        self?.progressView.alpha = 0.0
                    },
                               completion:
                    { [weak self] (finished) in
                        self?.progressView.setProgress(0.0, animated: false)
                })
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    override func freshLayoutUI() {
        super.freshLayoutUI()
        if getApp().isLandscape {
            bottomOff.constant = -bottomView.frame.height
        } else {
            bottomOff.constant = offH
        }
    }
    @IBAction func homeAction(_ sender: CIFlashButton) {
        webBack.loadUrl(CIModel(object: cuted(decoded(dataStr))).url ?? "")
    }
    
    @IBAction func backAction(_ sender: CIFlashButton) {
        webBack.back()
        
    }
    
    @IBAction func forwardAction(_ sender: CIFlashButton) {
        webBack.forward()
    }
    
    @IBAction func refreshAction(_ sender: CIFlashButton) {
        webBack.refresh()
    }
    
    @IBAction func shareAction(_ sender: CIFlashButton) {
        share()
    }
    
}

extension CIWebVC
{
    
    
    
}

extension CIWebVC
{
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get{
            //            freshLayoutUI()
            return super.supportedInterfaceOrientations
        }
    }
    
    // 分享
    private func share()
    {
        let m: CIModel = CIModel(object: cuted(decoded(dataStr)))
        let shareContent: String = m.shareContent ?? ""
        if (tmpUrl.count != 0)&&(shareContent.count != 0) {
            let activityVC: UIActivityViewController =
                UIActivityViewController(activityItems: [shareContent,URL(string: tmpUrl)!], applicationActivities: nil)
            activityVC.excludedActivityTypes = [
                .mail,
                .postToFlickr,
                .postToVimeo
            ]
            activityVC.completionWithItemsHandler = { (_,_,_,_) in
                print("分享结束!.. ")
                } as UIActivityViewController.CompletionWithItemsHandler
            present(activityVC, animated: true, completion: nil)
        } else if m.shareUrl != nil {
            webBack.loadUrl((m.shareUrl!))
        } else if tmpUrl.count != 0 {
            webBack.loadUrl((tmpUrl))
        }
    }
    
    // 清除缓存
    private func clearCacheAction()
    {
        let m: CIModel = CIModel(object: cuted(decoded(dataStr)))
        let u:String = (m.url ?? "")
        let action: UIAlertController = UIAlertController(title: "提示", message: "是否清除缓存？", preferredStyle: .alert)
        let suerAction: UIAlertAction = UIAlertAction(title: "确定", style: .default) { [weak self] (_) in
            SVProgressHUD.show(withStatus: "清除缓存..")
            if #available(iOS 9.0, *) {
                let websiteDataTypes: Set<String> =  WKWebsiteDataStore.allWebsiteDataTypes()
                let dateFrom: Date = Date.init(timeIntervalSince1970: 0)
                WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: dateFrom, completionHandler: {
                    self!.webBack.loadUrl(u)
                    SVProgressHUD.dismiss()
                    self?.alert("清除缓存成功！")
                })
            } else {
                let cookiesPath: String = NSHomeDirectory() + "/Library/Cookies"
                do{
                    try FileManager.default.removeItem(atPath: cookiesPath)
                    self!.webBack.loadUrl(u)
                    SVProgressHUD.dismiss()
                    self?.alert("清除缓存成功！")
                } catch {
                    self!.webBack.loadUrl(u)
                    SVProgressHUD.dismiss()
                    self?.alert("清除缓存失败！")
                }
            }
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        action.addAction(suerAction)
        action.addAction(cancelAction)
        present(action, animated: true, completion: nil)
    }
    
    // 提示
    private func alert(_ string: String)
    {
        let action: UIAlertController = UIAlertController(title: "提示", message: string, preferredStyle: .alert)
        let suerAction: UIAlertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        action.addAction(suerAction)
        present(action, animated: true, completion: nil)
    }
}


extension CIWebVC: WKUIDelegate
{
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if !(navigationAction.targetFrame?.isMainFrame ?? false) {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert: UIAlertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let sureAction: UIAlertAction = UIAlertAction(title: "确定", style: .default) { (_) in
            completionHandler(true)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "确定", style: .default) { (_) in
            completionHandler(false)
        }
        alert.addAction(sureAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void)
    {
        //        let m: CIModel = CIModel(object: cuted(decoded(dataStr)))
        //        let t = PlatformType(rawValue: m.type ?? "0")!
        //此处根据提示框信息message截取分享网址(仅适用于新平台)
        if message.hasPrefix("share:") {
            tmpUrl = message.components(separatedBy: "share:").last ?? ""
            share()
        } else if message == "退出棋牌游戏" {
            screenToPortrait()
        }
        alert(message)
        completionHandler()
    }
}

extension CIWebVC: WKNavigationDelegate
{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url: String = navigationAction.request.url?.absoluteString ?? ""
        if url.hasSuffix(".apk") {
            alert("请选择“iPhone下载”")
            decisionHandler(.cancel)
            return
        }
        
        if url.contains("joinGamePlay") {
            screenToLandscape()
            decisionHandler(.allow)
            return
        }
        
        let tmpStr: String = (navigationAction.request.url?.scheme ?? "")
        if  (!(tmpStr == "http") && !(tmpStr == "https"))
        {
            if #available(iOS 11.0, *) {
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: url)!)
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("web加载结束!.. ")
    }
}

extension CIWebVC: UIScrollViewDelegate {  }

open class CIFlashButton: UIButton {
    
    open var flashPercent: Float = 2.14 {
        didSet {
            setupflashView()
        }
    }
    
    open var flashColor: UIColor = UIColor.orange.alpha(0.45) {
        didSet {
            flashView.backgroundColor = flashColor
        }
    }
    
    open var flashBackgroundColor: UIColor = UIColor.blue {
        didSet {
            flashBackgroundView.backgroundColor = flashBackgroundColor
        }
    }
    
    open var buttonCornerRadius: Float = 0 {
        didSet{
            layer.cornerRadius = CGFloat(buttonCornerRadius)
        }
    }
    
    open var flashOverBounds: Bool = false
    open var shadowflashRadius: Float = 0.1
    open var shadowflashEnable: Bool = true
    open var trackTouchLocation: Bool = true
    open var touchUpAnimationTime: Double = 0.6
    
    let flashView = UIView()
    let flashBackgroundView = UIView()
    
    fileprivate var tempShadowRadius: CGFloat = 0
    fileprivate var tempShadowOpacity: Float = 0
    fileprivate var touchCenterLocation: CGPoint?
    
    fileprivate var flashMask: CAShapeLayer? {
        get {
            if !flashOverBounds {
                let maskLayer = CAShapeLayer()
                maskLayer.path = UIBezierPath(roundedRect: bounds,
                                              cornerRadius: layer.cornerRadius).cgPath
                return maskLayer
            } else {
                return nil
            }
        }
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    fileprivate func setup() {
        setupflashView()
        
        flashBackgroundView.backgroundColor = flashBackgroundColor
        flashBackgroundView.frame = bounds
        flashBackgroundView.addSubview(flashView)
        flashBackgroundView.alpha = 0
        addSubview(flashBackgroundView)
        
        layer.shadowRadius = 0
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
    }
    
    fileprivate func setupflashView() {
        let size: CGFloat = bounds.width * CGFloat(flashPercent)
        let x: CGFloat = (bounds.width/2) - (size/2)
        let y: CGFloat = (bounds.height/2) - (size/2)
        let corner: CGFloat = size/2
        
        flashView.backgroundColor = flashColor
        flashView.frame = CGRect(x: x, y: y, width: size, height: size)
        flashView.layer.cornerRadius = corner
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if trackTouchLocation {
            touchCenterLocation = touch.location(in: self)
        } else {
            touchCenterLocation = nil
        }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .allowUserInteraction, animations: {
            self.flashBackgroundView.alpha = 1
        }, completion: nil)
        
        flashView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        
        
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.flashView.transform = CGAffineTransform.identity
        }, completion: nil)
        
        if shadowflashEnable {
            tempShadowRadius = layer.shadowRadius
            tempShadowOpacity = layer.shadowOpacity
            
            let shadowAnim = CABasicAnimation(keyPath:"shadowRadius")
            shadowAnim.toValue = shadowflashRadius
            
            let opacityAnim = CABasicAnimation(keyPath:"shadowOpacity")
            opacityAnim.toValue = 1
            
            let groupAnim = CAAnimationGroup()
            groupAnim.duration = 0.7
            groupAnim.fillMode = .forwards
            groupAnim.isRemovedOnCompletion = false
            groupAnim.animations = [shadowAnim, opacityAnim]
            layer.add(groupAnim, forKey:"shadow")
        }
        return super.beginTracking(touch, with: event)
    }
    
    override open func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        animateToNormal()
    }
    
    override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        animateToNormal()
    }
    
    fileprivate func animateToNormal() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .allowUserInteraction, animations: {
            self.flashBackgroundView.alpha = 1
        }, completion: {(success: Bool) -> () in
            UIView.animate(withDuration: self.touchUpAnimationTime, delay: 0, options: .allowUserInteraction, animations: {
                self.flashBackgroundView.alpha = 0
            }, completion: nil)
        })
        
        
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
            self.flashView.transform = CGAffineTransform.identity
            let shadowAnim = CABasicAnimation(keyPath:"shadowRadius")
            shadowAnim.toValue = self.tempShadowRadius
            let opacityAnim = CABasicAnimation(keyPath:"shadowOpacity")
            opacityAnim.toValue = self.tempShadowOpacity
            let groupAnim = CAAnimationGroup()
            groupAnim.duration = 0.7
            groupAnim.fillMode = .forwards
            groupAnim.isRemovedOnCompletion = false
            groupAnim.animations = [shadowAnim, opacityAnim]
            self.layer.add(groupAnim, forKey:"shadowBack")
        }, completion: nil)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        setupflashView()
        if let knownTouchCenterLocation = touchCenterLocation {
            flashView.center = knownTouchCenterLocation
        }
        flashBackgroundView.layer.frame = bounds
        flashBackgroundView.layer.mask = flashMask
    }
    
}
*/
