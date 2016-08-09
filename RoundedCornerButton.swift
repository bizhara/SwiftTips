//
//  RoundedCornerButton.swift
//
//  Created by khara on 2016/08/09.
//

import UIKit

/// 長円形ボタン (xib based)
/// ※本来ならわざわざ定義することなく、UIViewController.viewDidLoad などで self.circleShape するだけでいいはずだが、
/// Auto Layout 下では UIView.layor を使った表現が無効になってしまうため、その補完を layoutSubviews で行なわせている
class RoundedCornerButton: UIButton {
  override func awakeFromNib() {
    super.awakeFromNib()
    self.circleShape()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.circleShape()
  }
}
