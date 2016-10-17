//
//  NontitleBackButtonNavigationController.swift
//
//  Created by khara on 2016/08/23.
//

import UIKit

public protocol NontitleBackButtonNavigationControllerProtocol {
  func installNontitleBackButton(to navigationController_: UINavigationController)
}

extension NontitleBackButtonNavigationControllerProtocol {
  public func installNontitleBackButton(to navigationController_: UINavigationController) {
    guard let topViewController = navigationController_.topViewController else { return }
    if topViewController.navigationItem.backBarButtonItem == nil {
      let nontitleBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
      topViewController.navigationItem.backBarButtonItem = nontitleBackButton
    }
  }
}

/// 戻る記号だけの戻るボタンを持つ UINavigationController
open class NontitleBackButtonNavigationController: UINavigationController, NontitleBackButtonNavigationControllerProtocol {
  override open func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    self.installNontitleBackButton(to: self)
  }
}
