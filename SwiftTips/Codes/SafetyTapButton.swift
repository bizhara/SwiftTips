//
//  SafetyTapButton.swift
//  SwiftTips
//
//  Created by khara on 2016/10/19.
//  Copyright © 2016年 Kazuaki Hara. All rights reserved.
//

import UIKit

/// 連打防止
public protocol SafetyTapProtocol {
  var tappedClosure: (() -> Void)? { get set }

  func tappedAction(_ sender: UIControl)
  mutating func disableWhenTapped(completion completion_: @escaping () -> Void)
  mutating func enableForReuse()
}

extension SafetyTapProtocol where Self: UIControl {
  public func tappedAction(_ sender: UIControl) {
    self.isEnabled = false
    if let closure = self.tappedClosure {
      closure()
      // ここで呼び出し元に enableForReuse を呼び出してもらうべく closure として返すことも考えられるが、
      // 理解しづらいリスクの方が大きく感じ、呼び出し元の任意のタイミングで呼び出してもらう仕様とした
    } else {
      self.isEnabled = true
    }
  }

  public mutating func disableWhenTapped(completion completion_: @escaping () -> Void) {
    self.tappedClosure = completion_
  }

  public mutating func enableForReuse() {
    self.isEnabled = true
  }
}

/// Implemented SafetyTapProtocol Button (nib based)
open class SafetyTapButton: UIButton, SafetyTapProtocol {
  public var tappedClosure: (() -> Void)?

  override open func awakeFromNib() {
    super.awakeFromNib()

    self.addTarget(self, action: #selector(self.tapped(_:)), for: .touchUpInside)
  }

  @IBAction private func tapped(_ sender: UIButton) {
    self.tappedAction(sender)
  }
}
