//
//  TextFieldWithMargin.swift
//
//  Created by khara on 2016/08/04.
//

import UIKit

/// マージン調整可能 TextField
class TextFieldWithMargin: UITextField {
  var leftMargin: CGFloat = 0
  var topMargin: CGFloat = 0
  var rightMargin: CGFloat = 0
  var bottomMargin: CGFloat = 0

  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return self.rectWithMargins(rect: bounds)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return self.rectWithMargins(rect: bounds)
  }

  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return self.rectWithMargins(rect: bounds)
  }

  override func borderRect(forBounds bounds: CGRect) -> CGRect {
    return self.rectWithMargins(rect: bounds)
  }

  private func rectWithMargins(rect rect_: CGRect) -> CGRect {
    return CGRect(x: rect_.origin.x + self.leftMargin,
                  y: rect_.origin.y + self.topMargin,
                  width: rect_.size.width - self.leftMargin - self.rightMargin,
                  height: rect_.size.height - self.topMargin - self.bottomMargin)
  }
}
