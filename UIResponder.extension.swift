//
//  UIResponder.extension.swift
//
//  Created by hara on 2016/01/03.
//

import UIKit

extension UIResponder {
  func hideKeyboard() {
    // "If target is nil, the app sends the message to the first responder" という API 仕様を利用して、
    // first responder に resignFirstResponder を送る
    UIApplication.sharedApplication().sendAction(#selector(self.resignFirstResponder), to: nil, from: nil, forEvent: nil)
  }
  
  class func hideKeyboard() {
    UIApplication.sharedApplication().hideKeyboard()
  }
}
