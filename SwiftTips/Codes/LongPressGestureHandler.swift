//
//  LongPressGestureHandler.swift
//
//  Created by hara on 2016/01/15.
//

import UIKit

class LongPressGestureHandler: UILongPressGestureRecognizer, GestureHandlerProtocol {
  typealias GestureRecognizerT = LongPressGestureHandler
  
  class func actionWith(owner owner_: UIView, completion completion_: ((sender: GestureRecognizerT) -> Void)?) {
    let me = LongPressGestureHandler()
    me.addTarget(me, action: #selector(self.onRecognizedGesture(_:)))
    me.completion = completion_
    owner_.addGestureRecognizer(me)
  }
  
  func onRecognizedGesture(sender: GestureRecognizerT) {
    if (sender.state == .Changed) {
      sender.enabled = false
      self.completion?(sender: sender)
    } else if (sender.state == .Cancelled) {
      sender.enabled = true
    }
  }
  
  private(set) var completion: ((sender: GestureRecognizerT) -> Void)?
}
