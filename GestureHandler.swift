//
//  GestureHandler.swift
//
//  Created by hara on 2016/01/15.
//

import UIKit

protocol GestureHandlerProtocol: NSObjectProtocol {
  associatedtype GestureRecognizerT
  func onRecognizedGesture(sender: GestureRecognizerT)
  var completion: ((sender: GestureRecognizerT) -> Void)? { get }
}
