//
//  WebViewController.swift
//
//  Created by hara on 2016/01/13.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
  class func webViewWith(url url_: String, title title_: String) -> WebViewController {
    let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
    let me = storyboard.instantiateInitialViewController() as! WebViewController
    me.urlString = url_
    me.title = title_
    return me
  }
  
  deinit {
    self.webView.removeFromSuperview()
    self.webView = nil
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.makeWebView()
    
    let request = URLRequest(url: URL(string: self.urlString)!)
    self.webView.load(request)
    
    self.indicator.isHidden = false
    self.indicator.startAnimating()
    
    SwipeGestureHandler.actionWith(owner: self.view, directions: [.left, .right], completion: { (sender: SwipeGestureHandler) -> Void in
      if (sender.direction == .left) {
        self.swipeLeft()
      } else if (sender.direction == .right) {
        self.swipeRight()
      }
    })
  }
  
  private func makeWebView() {
    // InterfaceBuilder が未対応なためコードで生成〜追加しないとならない
    let webView = WKWebView(frame: self.view.frame)
    webView.navigationDelegate = self
    self.view.insertSubview(webView, belowSubview: self.indicator)
    self.webView = webView
    
    self.view.addConstraints([
      NSLayoutConstraint(
        item: self.webView,
        attribute: .top,
        relatedBy: .equal,
        toItem: self.topLayoutGuide,
        attribute: .top,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: self.webView,
        attribute: .bottom,
        relatedBy: .equal,
        toItem: self.bottomLayoutGuide,
        attribute: .bottom,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: self.webView,
        attribute: .left,
        relatedBy: .equal,
        toItem: self.view,
        attribute: .left,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: self.webView,
        attribute: .right,
        relatedBy: .equal,
        toItem: self.view,
        attribute: .right,
        multiplier: 1,
        constant: 0)
      ])
  }
  
  private func swipeLeft() {
    if (self.webView.canGoForward) {
      self.webView.goForward()
    }
  }
  
  private func swipeRight() {
    if (self.webView.canGoBack) {
      self.webView.goBack()
    } else {
      _ = self.navigationController?.popViewController(animated: true)
    }
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    self.webView.scrollView.reflectTopLayoutGuide(topLayoutGuide: self.topLayoutGuide)
  }
  
  // MARK: - WKNavigationDelegate
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    self.indicator.stopAnimating()
    self.indicator.isHidden = true
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    self.indicator.stopAnimating()
    self.indicator.isHidden = true
  }
  
  // MARK: - Privates
  private weak var webView: WKWebView!
  @IBOutlet private weak var indicator: UIActivityIndicatorView!
  
  private var urlString: String!
}
