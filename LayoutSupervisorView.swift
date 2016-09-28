//
//  LayoutSupervisorView.swift
//
//  Created by khara on 2016/09/28.
//

import UIKit

protocol RecoverShapeProtocol {
  var savedCornerRadius: CGFloat { get set }

  func setup(with superView_: UIView?)
  func recover(to superView_: UIView?)
}

/// AutoLayout 時でも Rounded Corner Rectangle がきちんと描かれるよう監視＆補完する
/// ※ 対象 UIView に addSubview しての使用を前提としている（UIView.extension.swift と協調）
class LayoutSupervisorView: UIView, RecoverShapeProtocol {
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
    // see UIView.extension.swift
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
