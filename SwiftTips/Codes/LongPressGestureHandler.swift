//
//  LongPressGestureHandler.swift
//
//  Created by hara on 2016/01/15.
//

import UIKit

class LongPressGestureHandler: UILongPressGestureRecognizer, GestureHandlerProtocol {
  class func actionWith(owner owner_: UIView, completion completion_: ((_ sender: LongPressGestureHandler) -> Void)?) {
    let me = LongPressGestureHandler()
    me.addTarget(me, action: #selector(self.onRecognizedGesture(sender:)))
    me.completion = completion_
    owner_.addGestureRecognizer(me)
  }
  
  func onRecognizedGesture(sender sender_: LongPressGestureHandler) {
    if (sender_.state == .changed) {
      sender_.isEnabled = false
      self.completion?(sender_)
    } else if (sender_.state == .cancelled) {
      sender_.isEnabled = true
    }
  }
  
  private(set) var completion: ((_ sender: LongPressGestureHandler) -> Void)?
}
