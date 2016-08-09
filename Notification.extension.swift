//
//  Notification.extension.swift
//
//  Created by hara on 2016/08/10.
//

import UIKit
import Foundation

extension Notification {
  func keyboardHeight() -> CGFloat? {
    guard let userInfo = self.userInfo else {
      return 0
    }
    guard let keyboardInfo = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
      return 0
    }

    let keyboardRect = keyboardInfo.cgRectValue
    return keyboardRect.height
  }
}
