//
//  UINavigationBar.extension.swift
//
//  Created by hara on 2016/07/21.
//

import UIKit

extension UINavigationBar {
  /// 透過・透明なバー
  open func transparentBar() {
    self.translucentBar(with: UIColor(red: 0, green: 0, blue: 0, alpha: 0))
  }
  
  /// 透過色のバー（アプリ全ての UINavigationBar に影響）
  public class func transparentBar() {
    self.translucentBar(with: UIColor(red: 0, green: 0, blue: 0, alpha: 0))
  }
  
  /// 透過色のバー
  open func translucentBar(with color_: UIColor) {
    self.setBackgroundImage(UIImage(), for: .default)
    self.shadowImage = UIImage()
    self.backgroundColor = color_
    self.isTranslucent = true
  }
  
  /// 透過色のバー（アプリ全ての UINavigationBar に影響）
  public class func translucentBar(with color_: UIColor) {
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().backgroundColor = color_
    UINavigationBar.appearance().isTranslucent = true
  }
}
