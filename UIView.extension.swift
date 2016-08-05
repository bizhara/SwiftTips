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

// UIView.layer を使っての表現（対象 View が constraint されていると機能しない場合があるので、レイアウトに注意が必要）
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

  // 通常は、self.layer.cornerRadius を viewDidLoad 時など初期化時に設定するが、AutoLayout の issue らしく Constraint 設定時には auto layout 後に無効になってしまう
  // 回避策としては、viewDidLayoutSubviews で layoutIfNeeded and circleShape してやると circleShape が有効になる
  func circleShape() {
    self.setCornerRadiusTo(cornerRadius: self.circleShapeRadius())
  }
  
  func circleShapeRadius() -> CGFloat {
    return self.frame.size.height / 2 // 縦横サイズが同じ前提
  }
  
  func setCornerRadiusTo(cornerRadius cornerRadius_: CGFloat) {
    self.layer.cornerRadius = cornerRadius_
  }

  func gradationLayerWith(startColor startColor_: UIColor, endColor endColor_: UIColor) -> CAGradientLayer {
    let gradationLayer = CAGradientLayer()
    gradationLayer.colors = [startColor_.cgColor, endColor_.cgColor]
    gradationLayer.frame = self.bounds
    return gradationLayer
  }

  /// ※ view.backgroundColor を設定していても、入力の gradationLayer に置き換わってしまうので注意
  func setGradationBackgroundWith(gradationLayer gradationLayer_: CAGradientLayer) {
    self.layer.insertSublayer(gradationLayer_, at: 0)
  }

  func setGradationBackgroundWith(startColor startColor_: UIColor, endColor endColor_: UIColor) {
    self.setGradationBackgroundWith(gradationLayer: self.gradationLayerWith(startColor: startColor_, endColor: endColor_))
  }
}
