//
//  UIImage.extension.swift
//
//  Created by khara on 2016/09/06.
//

import UIKit

extension UIImage {
  /// View をイメージに変換
  public class func image(fromView fromView_: UIView)-> UIImage? {
    return self.makeImage(with: fromView_.frame.size) { (_ imageContext: CGContext) in
      fromView_.layer.render(in: imageContext)
    }
  }

  /// 単色のイメージ作成
  public class func image(fromColor fromColor_: UIColor, bounds bounds_: CGRect)-> UIImage? {
    return self.makeImage(with: bounds_.size) { (_ imageContext: CGContext) in
      imageContext.setFillColor(fromColor_.cgColor)
      imageContext.fill(bounds_)
    }
  }

  /// imageRenderer を使ってイメージ作成
  public class func makeImage(with imageSize_: CGSize, imageRenderer imageRenderer_: ((_ imageContext: CGContext)-> Void))-> UIImage? {
    UIGraphicsBeginImageContext(imageSize_)

    guard let imageContext = UIGraphicsGetCurrentContext() else {
      UIGraphicsEndImageContext()
      return nil
    }

    imageRenderer_(imageContext)

    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
      UIGraphicsEndImageContext()
      return nil
    }

    UIGraphicsEndImageContext()
    
    return image
  }
}
