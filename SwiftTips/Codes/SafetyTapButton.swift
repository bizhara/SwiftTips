//
//  SafetyTapButton.swift
//  SwiftTips
//
//  Created by khara on 2016/10/19.
//  Copyright © 2016年 Kazuaki Hara. All rights reserved.
//

import UIKit

public protocol HasEnabled {
  var isEnabled: Bool { get set }
}

extension UIControl: HasEnabled {}
extension UIBarItem: HasEnabled {}

/// 連打防止
public protocol SafetyTapProtocol {
  var tappedClosure: (() -> Void)? { get set }

  mutating func tappedAction(_ sender: HasEnabled)
  mutating func disableWhenTapped(completion completion_: @escaping () -> Void)
  mutating func enableForReuse()
}

extension SafetyTapProtocol where Self: HasEnabled {
  public mutating func tappedAction(_ sender: HasEnabled) {
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

/// Implemented SafetyTapProtocol Button
open class SafetyTapButton: UIButton, SafetyTapProtocol {
  public var tappedClosure: (() -> Void)?

  open func disableWhenTapped(completion completion_: @escaping () -> Void) {
    self.tappedClosure = completion_
    self.addTarget(self, action: Selector(("tappedAction:")), for: .touchUpInside)
  }
}

/// Implemented SafetyTapProtocol BarButton
open class SafetyTapBarButton: UIBarButtonItem, SafetyTapProtocol {
  public var tappedClosure: (() -> Void)?

  open func disableWhenTapped(completion completion_: @escaping () -> Void) {
    self.tappedClosure = completion_
    self.target = self
    self.action = Selector(("tappedAction:"))
  }
}
