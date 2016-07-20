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

// UIView.layer を使っての表現
extension UIView {
  func addFrame(frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor) {
    self.addFrame(frameThickness: frameThickness_, frameColor: frameColor_, frameCorner: 0)
  }
  
  func addFrame(frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor, frameCorner frameCorner_: CGFloat) {
    self.layer.borderWidth = frameThickness_
    self.layer.borderColor = frameColor_.cgColor
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
  
  func circleShape() {
    self.setCornerRadiusTo(cornerRadius: self.circleShapeRadius())
  }
  
  func circleShapeRadius() -> CGFloat {
    return self.frame.size.height / 2 // 縦横サイズが同じ前提
  }
  
  func setCornerRadiusTo(cornerRadius cornerRadius_: CGFloat) {
    self.layer.cornerRadius = cornerRadius_
  }
}
