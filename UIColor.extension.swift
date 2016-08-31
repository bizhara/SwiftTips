//
//  UIColor.extension.swift
//
//  Created by hara on 2015/12/02.
//

import UIKit

extension UIColor {
  /// Convert Hex color value to UIColor.
  class func color(from hexColorValue_: UInt) -> UIColor {
    return self.color(from: hexColorValue_, alpha: 1.0)
  }
  
  /// Convert Hex color value to UIColor.
  class func color(from hexColorValue_: UInt, alpha alpha_: CGFloat) -> UIColor {
    let r = (hexColorValue_ >> 16) & 0xFF
    let g = (hexColorValue_ >> 8) & 0xFF
    let b = hexColorValue_ & 0xFF
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha_)
  }
}
