//
//  GestureHandler.swift
//
//  Created by hara on 2016/01/15.
//

import UIKit

public protocol GestureHandlerProtocol: NSObjectProtocol {
  associatedtype GestureRecognizerT
  func onRecognizedGesture(sender sender_: GestureRecognizerT)
  var completion: ((_ sender_: GestureRecognizerT) -> Void)? { get }
}
