//
//  UIView.extension.swift
//
//  Created by hara on 2015/12/03.
//

import UIKit

// 主に UITableViewCell 対象
extension UIView {
  class func nibName() -> String {
    return "\(self)" // クラス名と nib 名が同じ前提
  }
  
  class func viewId() -> String {
    return self.nibName()
  }
}

extension UIView {
  func addFrame(frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor) {
    self.addFrame(frameThickness: frameThickness_, frameColor: frameColor_, frameCorner: 0)
  }
  
  func addFrame(frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor, frameCorner frameCorner_: CGFloat) {
    self.layer.borderWidth = frameThickness_
    self.layer.borderColor = frameColor_.CGColor
    self.layer.cornerRadius = frameCorner_
  }
  
  class func addFrame(toViews toViews_: [UIView], frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor) {
    self.addFrame(toViews: toViews_, frameThickness: frameThickness_, frameColor: frameColor_, frameCorner: 0)
  }
  
  class func addFrame(toViews toViews_: [UIView], frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor, frameCorner frameCorner_: CGFloat) {
    for view in toViews_ {
      view.addFrame(frameThickness: frameThickness_, frameColor: frameColor_, frameCorner: frameCorner_)
    }
  }
  
  func circleShapeRadius() -> CGFloat {
    return self.frame.size.width / 2 // 縦横サイズが同じ前提
  }
  
  func circleShape() {
    self.layer.cornerRadius = circleShapeRadius()
  }
}
