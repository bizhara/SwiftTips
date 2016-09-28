//
//  UIView.extension.swift
//
//  Created by hara on 2015/12/03.
//

import UIKit

protocol RecoverShapeProtocol {
  var savedCornerRadius: CGFloat { get set }

  func setup(with superView_: UIView?)
  func recover(to superView_: UIView?)
}

/// AutoLayout 時でも Rounded Corner Rectangle がきちんと描かれるよう監視＆補完する
/// ※ 対象 UIView に addSubview しての使用を前提としている（extension UIView と協調）
private class LayoutSupervisorView: UIView, RecoverShapeProtocol {
  internal var savedCornerRadius: CGFloat = 0

  internal func setup(with superView_: UIView?) {
    guard let superView = superView_ else { return }
    self.savedCornerRadius = superView.layer.cornerRadius

    // なんらかの大きさがないと、後に layoutSubviews が呼ばれないが、画面に出てほしくもないので、明示的にそのような値に
    self.frame = CGRect(x: -100, y: -100, width: 10, height: 10)
  }

  internal func recover(to superView_: UIView?) {
    guard let superView = superView_ else { return }
    guard self.savedCornerRadius != 0 else { return }

    // 両端が半円の設定をしたい時、setup 時には適切な大きさになっていないことが多いので、再計算の必用があることを認識させるためマイナス値になっている
    // see extension UIView
    if self.savedCornerRadius < 0 {
      self.savedCornerRadius = superView.circleShapeRadius()
    }
    superView.layer.cornerRadius = self.savedCornerRadius
  }
}

extension LayoutSupervisorView {
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    self.setup(with: self.superview)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.recover(to: self.superview)
  }
}

/// UIView.layer を使っての表現（対象 View が constraint されていると機能しない場合があるので、レイアウトに注意が必要）
extension UIView {
  /// 枠線追加
  func addFrame(frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor) {
    self.addFrame(frameThickness: frameThickness_, frameColor: frameColor_, frameCorner: 0)
  }
  
  /// 枠線追加
  func addFrame(frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor, frameCorner frameCorner_: CGFloat) {
    self.layer.borderWidth = frameThickness_
    self.layer.borderColor = frameColor_.cgColor
    self.setCornerRadius(with: frameCorner_)
  }
  
  /// 枠線追加
  class func addFrame(toViews toViews_: [UIView], frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor) {
    self.addFrame(toViews: toViews_, frameThickness: frameThickness_, frameColor: frameColor_, frameCorner: 0)
  }

  /// 枠線追加
  class func addFrame(toViews toViews_: [UIView], frameThickness frameThickness_: CGFloat, frameColor frameColor_: UIColor, frameCorner frameCorner_: CGFloat) {
    for view in toViews_ {
      view.addFrame(frameThickness: frameThickness_, frameColor: frameColor_, frameCorner: frameCorner_)
    }
  }

  /// 両端が半円の cornerRadius 値を設定する（角丸四角は addFrame で）
  /// ※ 現状の AutoLayout の特性上、UIViewController.viewDidLoad 時はまだ適切な大きさになっていないことが多いので
  /// setCornerRadius と合わせて UIView.layoutSubviews 時に適切な設定になるようにと考えている
  /// 故に再計算が必要なことを認識させるため、ここではマイナス値を送っている
  func circleShape() {
    self.setCornerRadius(with: -1)
  }

  /// 両端が半円になるような cornerRadius 値を返す
  func circleShapeRadius() -> CGFloat {
    return self.frame.size.height / 2
  }
  
  private func setCornerRadius(with cornerRadius_: CGFloat) {
    self.layer.cornerRadius = cornerRadius_

    // 通常は、self.layer.cornerRadius を UIViewController.viewDidLoad 時など初期化時に設定するが、
    // AutoLayout の issue らしく Constraint 設定時には AutoLayout 後に無効になってしまう
    // 回避策としては、UIView.layoutSubviews で self.layer.cornerRadius を再設定してやると有効になる
    // see. http://stackoverflow.com/questions/18946621/how-to-combine-auto-layout-constraints-with-contentmode-property-of-uiview ,
    // http://stackoverflow.com/questions/27509021/issues-with-uiimageview-layer-cornerradius-to-create-rounded-images-on-different
    // そのための監視 view を設けて汎用的に対処できるようにと考えた
    if cornerRadius_ != 0 {
      let supervisorView = LayoutSupervisorView()
      self.addSubview(supervisorView)
    }
  }
}

extension UIView {
  /// startColor 〜 endColor のグラデーションを表現する layer を作成
  func gradationLayer(startColor startColor_: UIColor, endColor endColor_: UIColor) -> CAGradientLayer {
    let gradationLayer = CAGradientLayer()
    gradationLayer.colors = [startColor_.cgColor, endColor_.cgColor]
    gradationLayer.frame = self.bounds
    return gradationLayer
  }

  /// gradationLayer で作られたグラデーション背景を設定する
  /// ※ view.backgroundColor を設定していても、入力の gradationLayer に置き換わってしまうので注意
  func setGradationBackgroundWith(gradationLayer gradationLayer_: CAGradientLayer) {
    self.layer.insertSublayer(gradationLayer_, at: 0)
  }

  /// startColor 〜 endColor のグラデーション背景を設定する
  func setGradationBackgroundWith(startColor startColor_: UIColor, endColor endColor_: UIColor) {
    self.setGradationBackgroundWith(gradationLayer: self.gradationLayer(startColor: startColor_, endColor: endColor_))
  }
}
