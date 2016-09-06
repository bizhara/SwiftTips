//
//  UIImage.extension.swift
//
//  Created by khara on 2016/09/06.
//

import UIKit

extension UIImage {
  /// 単色のイメージ作成
  class func image(with color_: UIColor, bounds bounds_: CGRect) -> UIImage? {
    UIGraphicsBeginImageContext(bounds_.size)

    guard let imageContext = UIGraphicsGetCurrentContext() else {
      UIGraphicsEndImageContext()
      return nil
    }
    imageContext.setFillColor(color_.cgColor)
    imageContext.fill(bounds_)
    guard let cgImage = imageContext.makeImage() else {
      UIGraphicsEndImageContext()
      return nil
    }
    let image = UIImage(cgImage: cgImage)

    UIGraphicsEndImageContext()
    return image
  }
}
