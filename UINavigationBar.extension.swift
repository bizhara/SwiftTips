//
//  UINavigationBar.extension.swift
//
//  Created by hara on 2016/07/21.
//

import UIKit

extension UINavigationBar {
  /// 透過・透明なバー
  class func transparentBar() {
    self.translucentBarWith(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0))
  }
  
  /// 透過色のバー
  class func translucentBarWith(color color_: UIColor) {
    #if swift(>=3.0)
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    #else
    UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
    #endif
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().backgroundColor = color_
    #if swift(>=3.0)
    UINavigationBar.appearance().isTranslucent = true
    #else
    UINavigationBar.appearance().translucent = true
    #endif
  }
}
