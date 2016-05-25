//
//  UIView.extension.swift
//
//  Created by hara on 2015/12/03.
//

import UIKit

// UITableViewCell 対象
extension UIView {
  class func nibName() -> String {
    // クラス名と nib 名が同じ前提
    return String(self)
  }
  
  class func viewId() -> String {
    return String(self)
  }
  
  // 高さ固定用
  class func viewHeight() -> CGFloat {
    let nibName = self.nibName()
    var viewHeight = self.calculatedViewHeights[nibName]
    if (viewHeight > 0.0) {
      return viewHeight!
    }
    
    let nib = UINib(nibName: nibName, bundle: nil)
    let view = nib.instantiateWithOwner(nil, options: nil)[0]
    viewHeight = view.frame.size.height
    self.calculatedViewHeights[nibName] = viewHeight
    
    return viewHeight!
  }
  
  // MARK: - Privates
  
  private static var calculatedViewHeights: [String: CGFloat] = ["": 0.0]
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
    return self.frame.size.width / 2
  }
  
  func circleShape() {
    self.layer.cornerRadius = circleShapeRadius()
  }
}
