//
//  KeyboardHelper.swift
//
//  Created by hara on 2016/08/15.
//

import UIKit

/// キーボード操作のある Base ViewController
open class ViewControllerWithKeyboard: UIViewController {
  /// 入力エリア以外をタッチしたらキーボードを消す
  override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)

    self.hideKeyboard(with: touches, event: event)
  }

  open func hideKeyboard(with touches_: Set<UITouch>, event event_: UIEvent?) {
    guard let toucedView = self.findTouchedView(with: touches_, event: event_) else {
      return
    }
    if toucedView != self.inputView {
      self.hideKeyboard()
    }
  }
}

extension UIResponder {
  open func hideKeyboard() {
    // "If target is nil, the app sends the message to the first responder" という API 仕様を利用して、
    // first responder に resignFirstResponder を送る
    UIApplication.shared.sendAction(#selector(self.resignFirstResponder), to: nil, from: nil, for: nil)
  }

  public class func hideKeyboard() {
    UIApplication.shared.hideKeyboard()
  }
}

public protocol InputAreaOwnerProtocol {
  var inputArea: CGRect { get }
  var lastY: CGFloat { get set }
}

public protocol InputAreaAdjusterProtocol {
  func centerInputAreaWith(_ notification: Notification)
  func repositionInputArea(_ notification: Notification)
}

extension ViewControllerWithKeyboard: InputAreaAdjusterProtocol {
  /// 入力エリアをキーボード外のエリアのセンターに位置づける
  /// （Respond to UIKeyboardWillShow or UIKeyboardDidShow）
  open func centerInputAreaWith(_ notification: Notification) {
    guard var inputAreaOwner = self as? InputAreaOwnerProtocol else {
      return
    }
    guard let keyboardHeight = notification.keyboardHeight() else {
      return
    }

    let navigationBarHeight = (self.navigationController?.navigationBar.frame.maxY)!
    let baseRect = CGRect(x: 0, y: navigationBarHeight,
                          width: self.view.frame.width,
                          height: self.view.frame.height - keyboardHeight - navigationBarHeight)
    let offset = baseRect.midY - inputAreaOwner.inputArea.midY

    var frame = self.view.frame
    inputAreaOwner.lastY = frame.origin.y
    frame.origin.y = offset
    self.view.frame = frame
  }

  /// 入力エリアを通常の位置に戻す
  /// （Respond to UIKeyboardWillHide or UIKeyboardDidHide）
  open func repositionInputArea(_ notification: Notification) {
    guard var inputAreaOwner = self as? InputAreaOwnerProtocol else {
      return
    }

    var frame = self.view.frame
    frame.origin.y = inputAreaOwner.lastY
    self.view.frame = frame
  }
}

extension Notification {
  /// キーボードの高さを得る
  public func keyboardHeight() -> CGFloat? {
    guard let userInfo = self.userInfo else {
      return 0
    }

    func keyboardHeightFrom(keyboardInfo keyboardInfo_: NSValue?) -> CGFloat {
      guard let keyboardInfo_ = keyboardInfo_ else {
        return 0
      }
      let keyboardRect = keyboardInfo_.cgRectValue
      return keyboardRect.height
    }

    let keyboardHeight1 = keyboardHeightFrom(keyboardInfo: userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)
    let keyboardHeight2 = keyboardHeightFrom(keyboardInfo: userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)
    return keyboardHeight1 > keyboardHeight2 ? keyboardHeight1 : keyboardHeight2
  }
}
