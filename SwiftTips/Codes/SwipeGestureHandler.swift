//
//  SwipeGestureHandler.swift
//
//  Created by hara on 2016/01/15.
//

import UIKit

class SwipeGestureHandler: UISwipeGestureRecognizer, GestureHandlerProtocol {
  typealias GestureRecognizerT = SwipeGestureHandler
  
  class func actionWith(owner owner_: UIView, directions directions_: [UISwipeGestureRecognizerDirection], completion completion_: ((sender: GestureRecognizerT) -> Void)?) {
    for direction in directions_ {
      let me = SwipeGestureHandler()
      me.direction = direction
      me.addTarget(me, action: #selector(self.onRecognizedGesture(_:)))
      me.completion = completion_
      owner_.addGestureRecognizer(me)
    }
  }
  
  func onRecognizedGesture(sender: GestureRecognizerT) {
    if (sender.state == .Ended) {
      self.completion?(sender: sender)
    }
  }
  
  private(set) var completion: ((sender: GestureRecognizerT) -> Void)?
}
