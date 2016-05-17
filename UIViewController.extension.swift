//
//  UIViewController.extension.swift
//
//  Created by hara on 2015/11/21.
//

import UIKit

extension UIViewController {
  // 遷移先の戻るボタンのタイトルを消すには、遷移元でこれを呼んでおく必要がある
  func eraseNextBackButtonTitle() {
    let backButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    self.navigationItem.backBarButtonItem = backButtonItem
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
