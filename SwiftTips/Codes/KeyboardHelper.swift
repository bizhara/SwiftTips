//
//  KeyboardHelper.swift
//
//  Created by hara on 2016/08/15.
//

import UIKit

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

extension UIView {
  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    print(">>> touchesBegan")
  }

  override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    print(">>> touchesMoved")
  }

  override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)

    print(">>> touchesEnded")
    self.hideKeyboardIfNeeded(with: touches, event: event)
  }

  override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)

    print(">>> touchesCancelled")
    self.hideKeyboardIfNeeded(with: touches, event: event)
  }

  open func hideKeyboardIfNeeded(with touches_: Set<UITouch>, event event_: UIEvent?) {
    guard let touchedView = self.findTouchedView(with: touches_, event: event_) else { return }
    print(">>> touchedView: \(String(describing: type(of: touchedView)))")
    print(">>> isFirstResponder: \(touchedView.isFirstResponder)")
    if !touchedView.isFirstResponder {
      self.hideKeyboard()
    }
  }
}

extension Notification {
  /// キーボードの高さを得る
  public func keyboardHeight() -> CGFloat {
    func extractKeyboardHeight(from keyboardInfo_: NSValue?) -> CGFloat {
      guard let keyboardInfo_ = keyboardInfo_ else { return 0 }
      let keyboardRect = keyboardInfo_.cgRectValue
      return keyboardRect.height
    }

    guard let userInfo = self.userInfo else { return 0 }

    let keyboardHeight1 = extractKeyboardHeight(from: userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)
    let keyboardHeight2 = extractKeyboardHeight(from: userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)
    return keyboardHeight1 > keyboardHeight2 ? keyboardHeight1 : keyboardHeight2
  }
}

/// キーボード操作のある UIViewController 派生との協業想定
public protocol InputAreaOwnerProtocol {
  var inputArea: CGRect { get }
  var lastY: CGFloat { get set }
}

/// キーボード操作のある UIViewController 派生との協業想定
public protocol InputAreaAdjusterProtocol {
  /// 入力エリアをキーボード外のエリアのセンターに位置づける
  /// （Respond to UIKeyboardWillShow or UIKeyboardDidShow）
  func centerInputArea(_ notification: Notification)

  /// 入力エリアを通常の位置に戻す
  /// （Respond to UIKeyboardWillHide or UIKeyboardDidHide）
  func repositionInputArea(_ notification: Notification)
}

extension UIViewController: InputAreaAdjusterProtocol {
  open func centerInputArea(_ notification: Notification) {
    guard var inputAreaOwner = self as? InputAreaOwnerProtocol else { return }

    let keyboardHeight = notification.keyboardHeight()
    guard keyboardHeight > 0 else { return }
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

  open func repositionInputArea(_ notification: Notification) {
    guard var inputAreaOwner = self as? InputAreaOwnerProtocol else { return }

    var frame = self.view.frame
    frame.origin.y = inputAreaOwner.lastY
    self.view.frame = frame
  }
}
