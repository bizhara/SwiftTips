//
//  WebViewController.swift
//
//  Created by hara on 2016/01/13.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
  class func webViewWith(url url_: String, title title_: String) -> WebViewController {
    let storyboard = UIStoryboard(name: String(self), bundle: nil)
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
    
    let request = NSURLRequest(URL: NSURL(string: self.urlString)!)
    self.webView.loadRequest(request)
    
    self.indicator.hidden = false
    self.indicator.startAnimating()
    
    SwipeGestureHandler.actionWith(owner: self.view, directions: [.Left, .Right], completion: { (sender: SwipeGestureHandler) -> Void in
      if ((self.parentViewController as! CommentWebViewController).commentPanelKeeper.panelHidden) {
        if (sender.direction == .Left) {
          self.swipeLeft()
        } else if (sender.direction == .Right) {
          self.swipeRight()
        }
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
        attribute: .Top,
        relatedBy: .Equal,
        toItem: self.topLayoutGuide,
        attribute: .Top,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: self.webView,
        attribute: .Bottom,
        relatedBy: .Equal,
        toItem: self.bottomLayoutGuide,
        attribute: .Bottom,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: self.webView,
        attribute: .Left,
        relatedBy: .Equal,
        toItem: self.view,
        attribute: .Left,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: self.webView,
        attribute: .Right,
        relatedBy: .Equal,
        toItem: self.view,
        attribute: .Right,
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
      self.navigationController?.popViewControllerAnimated(true)
    }
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    self.webView.scrollView.reflectTopLayoutGuide(topLayoutGuide: self.topLayoutGuide)
  }
  
  // MARK: - WKNavigationDelegate
  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    self.indicator.stopAnimating()
    self.indicator.hidden = true
  }
  
  func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
    self.indicator.stopAnimating()
    self.indicator.hidden = true
  }
  
  // MARK: - Privates
  private weak var webView: WKWebView!
  @IBOutlet private weak var indicator: UIActivityIndicatorView!
  
  private var urlString: String!
}
