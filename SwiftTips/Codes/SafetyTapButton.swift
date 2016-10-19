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
  var tappedClosure: ((_ enableForReuse: @escaping () -> Void) -> Void)? { get set }

  func tappedAction(_ sender: UIControl)
  mutating func tappedByUser(completion completion_: @escaping (_ enableForReuse: @escaping () -> Void) -> Void)
}

extension SafetyTapProtocol where Self: UIControl {
  public func tappedAction(_ sender: UIControl) {
    self.isEnabled = false
    if let closure = self.tappedClosure {
      closure() {
        self.isEnabled = true
      }
    } else {
      self.isEnabled = true
    }
  }

  public mutating func tappedByUser(completion completion_: @escaping (_ enableForReuse: @escaping () -> Void) -> Void) {
    self.tappedClosure = completion_
  }
}

/// Implemented SafetyTapProtocol Button (nib based)
open class SafetyTapButton: UIButton, SafetyTapProtocol {
  public var tappedClosure: ((_ enableForReuse: @escaping () -> Void) -> Void)?

  override open func awakeFromNib() {
    super.awakeFromNib()

    self.addTarget(self, action: #selector(self.tapped(_:)), for: .touchUpInside)
  }

  @IBAction private func tapped(_ sender: UIButton) {
    self.tappedAction(sender)
  }
}
