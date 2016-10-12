//
//  SwipeGestureHandler.swift
//
//  Created by hara on 2016/01/15.
//

import UIKit

open class SwipeGestureHandler: UISwipeGestureRecognizer, GestureHandlerProtocol {
  public class func actionWith(owner owner_: UIView, directions directions_: [UISwipeGestureRecognizerDirection], completion completion_: ((_ sender: SwipeGestureHandler) -> Void)?) {
    for direction in directions_ {
      let me = SwipeGestureHandler()
      me.direction = direction
      me.addTarget(me, action: #selector(self.onRecognizedGesture(sender:)))
      me.completion = completion_
      owner_.addGestureRecognizer(me)
    }
  }
  
  public func onRecognizedGesture(sender sender_: SwipeGestureHandler) {
    if (sender_.state == .ended) {
      self.completion?(sender_)
    }
  }
  
  private(set) public var completion: ((_ sender_: SwipeGestureHandler) -> Void)?
}
