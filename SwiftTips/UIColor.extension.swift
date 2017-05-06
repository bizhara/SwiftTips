//
//  UIColor.extension.swift
//
//  Created by hara on 2015/12/02.
//

import UIKit

extension UIColor {
  /// Convert Hex color value to UIColor.
  public class func color(from hexColorValue_: UInt) -> UIColor {
    return self.color(from: hexColorValue_, alpha: 1.0)
  }
  
  /// Convert Hex color value to UIColor.
  public class func color(from hexColorValue_: UInt, alpha alpha_: CGFloat) -> UIColor {
    let rgb = self.rgb(from: hexColorValue_)
    return UIColor(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: alpha_)
  }

  /// Convert Hex color value to RGB.
  public class func rgb(from hexColorValue: UInt)-> (r: CGFloat, g: CGFloat, b: CGFloat) {
    let r = (hexColorValue >> 16) & 0xFF
    let g = (hexColorValue >> 8) & 0xFF
    let b = hexColorValue & 0xFF
    return (CGFloat(r)/255, CGFloat(g)/255, CGFloat(b)/255)
  }
}
