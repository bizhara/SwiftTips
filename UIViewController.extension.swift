//
//  UIViewController.extension.swift
//
//  Created by hara on 2015/11/21.
//

import UIKit

extension UIViewController {
  /// タッチした場所の UIView を返す (may use with touchesEnded)
  func findTouchedView(with touches_: Set<UITouch>, event event_: UIEvent?) -> UIView? {
    guard let touch = touches_.first else {
      return nil
    }
    let touchPoint = touch.location(in: self.view)
    let touchedView = self.view.hitTest(touchPoint, with: event_)
    return touchedView
  }
}

extension UIViewController {
  // Objective-C での dealloc である deinit が呼ばれないことが多いので代替手段として viewDidDisappear で使用する
  func willDeinit() -> Bool {
    let viewControllers = self.navigationController?.viewControllers
    return ((viewControllers == nil) || (!viewControllers!.contains(self)))
  }
}

protocol ChildViewControllerProtocol: NSObjectProtocol {
  // 新たに画面上に表示した時や位置・サイズの変更があった時などに呼び出されることを想定している
  func didLayoutChildViewController(childViewController childViewController_: UIViewController)
  
  // 使用が終わり画面上から消す時に呼ばれることを想定している
  func willHideChildViewController(childViewController childViewController_: UIViewController)
}
