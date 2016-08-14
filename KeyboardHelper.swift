//
//  KeyboardHelper.swift
//  Dolphin-iOS
//
//  Created by hara on 2016/08/15.
//  Copyright © 2016年 Kazuaki Hara. All rights reserved.
//

import UIKit

/// キーボード操作のある Base ViewController
class ViewControllerWithKeyboard: UIViewController {
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)

    self.hideKeyboardWith(touches: touches, event: event)
  }
}

extension UIResponder {
  func hideKeyboard() {
    // "If target is nil, the app sends the message to the first responder" という API 仕様を利用して、
    // first responder に resignFirstResponder を送る
    UIApplication.shared.sendAction(#selector(self.resignFirstResponder), to: nil, from: nil, for: nil)
  }

  class func hideKeyboard() {
    UIApplication.shared.hideKeyboard()
  }
}

extension UIViewController {
  /// 入力エリア以外をタッチしたらキーボードを消す (may use with touchesEnded)
  func hideKeyboardWith(touches touches_: Set<UITouch>, event event_: UIEvent?) {
    guard let toucedView = self.findTouchedViewWith(touches: touches_, event: event_) else {
      return
    }
    if toucedView != self.inputView {
      self.hideKeyboard()
    }
  }
}

protocol HasInputAreaProtocol {
  var inputArea: CGRect { get }
  var lastY: CGFloat { get set }
}

extension UIViewController {
  /// 入力エリアをキーボード外のエリアのセンターに位置づける
  /// （Respond to UIKeyboardWillShow or UIKeyboardDidShow）
  func centerInputAreaWith(_ notification: Notification) {
    guard var viewControllerHasInputArea = self as? HasInputAreaProtocol else {
      return
    }
    guard let keyboardHeight = notification.keyboardHeight() else {
      return
    }

    let baseRect = CGRect(x: 0, y: 0,
                          width: self.view.frame.width,
                          height: self.view.frame.height - keyboardHeight)
    let offset = baseRect.midY - viewControllerHasInputArea.inputArea.midY

    var frame = self.view.frame
    viewControllerHasInputArea.lastY = frame.origin.y
    frame.origin.y = offset
    self.view.frame = frame
  }

  /// 入力エリアを通常の位置に戻す
  /// （Respond to UIKeyboardWillHide or UIKeyboardDidHide）
  func repositionInputArea(_ notification: Notification) {
    guard var viewControllerHasInputArea = self as? HasInputAreaProtocol else {
      return
    }

    var frame = self.view.frame
    frame.origin.y = viewControllerHasInputArea.lastY
    self.view.frame = frame
  }
}

extension Notification {
  /// キーボードの高さを得る
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
