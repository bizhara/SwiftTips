//
//  UIViewController.extension.swift
//
//  Created by hara on 2015/11/21.
//

import UIKit

extension UIViewController {
  /// タッチした場所の UIView を返す (may use with touchesEnded)
  open func findTouchedView(with touches_: Set<UITouch>, event event_: UIEvent?) -> UIView? {
    guard let touch = touches_.first else { return nil }
    let touchPoint = touch.location(in: self.view)
    let touchedView = self.view.hitTest(touchPoint, with: event_)
    return touchedView
  }
}
