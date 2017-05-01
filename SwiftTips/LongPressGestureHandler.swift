//
//  LongPressGestureHandler.swift
//
//  Created by hara on 2016/01/15.
//

import UIKit

open class LongPressGestureHandler: UILongPressGestureRecognizer, GestureHandlerProtocol {
  public class func actionWith(owner owner_: UIView, completion completion_: ((_ sender: LongPressGestureHandler) -> Void)?) {
    let me = LongPressGestureHandler()
    me.addTarget(me, action: #selector(self.onRecognizedGesture(sender:)))
    me.completion = completion_
    owner_.addGestureRecognizer(me)
  }
  
  public func onRecognizedGesture(sender sender_: LongPressGestureHandler) {
    if (sender_.state == .changed) {
      sender_.isEnabled = false
      self.completion?(sender_)
    } else if (sender_.state == .cancelled) {
      sender_.isEnabled = true
    }
  }
  
  private(set) public var completion: ((_ sender: LongPressGestureHandler) -> Void)?
}
