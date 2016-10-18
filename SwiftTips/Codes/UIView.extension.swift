//
//  UIView.extension.swift
//
//  Created by hara on 2015/12/03.
//

import UIKit

/// UIView.layer を使っての表現
extension UIView {
  /// 枠線追加
  open func addFrame(frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor) {
    self.addFrame(frameThickness: frameThickness_, frameColor: frameColor_, frameCorner: 0)
  }
  
  /// 枠線追加
  open func addFrame(frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor, frameCorner frameCorner_: CGFloat) {
    self.layer.borderWidth = frameThickness_
    self.layer.borderColor = frameColor_.cgColor
    self.layer.cornerRadius = frameCorner_
  }
  
  /// 枠線追加
  public class func addFrame(toViews toViews_: [UIView], frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor) {
    self.addFrame(toViews: toViews_, frameThickness: frameThickness_, frameColor: frameColor_, frameCorner: 0)
  }

  /// 枠線追加
  public class func addFrame(toViews toViews_: [UIView], frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor, frameCorner frameCorner_: CGFloat) {
    for view in toViews_ {
      view.addFrame(frameThickness: frameThickness_, frameColor: frameColor_, frameCorner: frameCorner_)
    }
  }
}

extension UIView {
  /// 両端が半円の cornerRadius 値を設定する（角丸四角は addFrame で）
  /// ※ 現状の AutoLayout の特性上、UIViewController.viewDidLoad 時はまだ適切な大きさになっていないので
  /// UIView.layoutSubviews 時に適切な設定にすべく、監視用 View を仕込んで対応する
  open func circleShape() {
    self.layer.cornerRadius = self.circleShapeRadius
    self.add(layoutComplement: CircleShapeComplement())
  }

  /// 両端が半円になるような cornerRadius 値を返す
  fileprivate var circleShapeRadius: CGFloat {
    return self.frame.size.height / 2
  }
}

/// layoutSubviews 後に CircleShape として適切な cornerRadius 値を設定する
public struct CircleShapeComplement: LayoutComplementProtocol {
  public func didLayoutSubviews(with targetView_: UIView) {
    targetView_.layer.cornerRadius = targetView_.circleShapeRadius
  }
}

// MARK: - Layout capture

/// LayoutCaptureView に登録して layoutSubviews 後に再レイアウトを行なう
public protocol LayoutComplementProtocol {
  func didLayoutSubviews(with targetView_: UIView)
}

/// UIView に登録して layoutSubviews 呼び出しと連動させる
private class LayoutCaptureView: UIView {
  var targetView: UIView!
  var layoutComplements: [LayoutComplementProtocol] = []

  override func layoutSubviews() {
    super.layoutSubviews()

    for layoutComplement in self.layoutComplements {
      layoutComplement.didLayoutSubviews(with: self.targetView)
    }
  }
}

extension UIView {
  open func add(layoutComplement layoutComplement_: LayoutComplementProtocol) {
    func findLayoutCapture() -> LayoutCaptureView? {
      for subView in self.subviews {
        if subView is LayoutCaptureView {
          return subView as? LayoutCaptureView
        }
      }
      // なんらかの大きさがないと、後に layoutSubviews が呼ばれないが、画面に出てほしくもないので、明示的にそのような値に
      let layoutCapture = LayoutCaptureView(frame: CGRect(x: -100, y: -100, width: 10, height: 10))
      layoutCapture.targetView = self
      self.addSubview(layoutCapture)
      return layoutCapture
    }

    guard let layoutCapture = findLayoutCapture() else { return }
    layoutCapture.layoutComplements.append(layoutComplement_)
  }
}

// MARK: - Gradation layer

extension UIView {
  /// startColor 〜 endColor のグラデーションを表現する layer を作成
  open func gradationLayer(startColor startColor_: UIColor, endColor endColor_: UIColor) -> CAGradientLayer {
    let gradationLayer = CAGradientLayer()
    gradationLayer.colors = [startColor_.cgColor, endColor_.cgColor]
    gradationLayer.frame = self.bounds
    return gradationLayer
  }

  /// gradationLayer で作られたグラデーション背景を設定する
  /// ※ view.backgroundColor を設定していても、入力の gradationLayer に置き換わってしまうので注意
  open func setGradationBackgroundWith(gradationLayer gradationLayer_: CAGradientLayer) {
    self.layer.insertSublayer(gradationLayer_, at: 0)
  }

  /// startColor 〜 endColor のグラデーション背景を設定する
  open func setGradationBackgroundWith(startColor startColor_: UIColor, endColor endColor_: UIColor) {
    self.setGradationBackgroundWith(gradationLayer: self.gradationLayer(startColor: startColor_, endColor: endColor_))
  }
}
