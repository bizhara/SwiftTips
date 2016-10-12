//
//  NontitleBackButtonNavigationController.swift
//
//  Created by khara on 2016/08/23.
//

import UIKit

/// 戻る記号だけの戻るボタンを持つ UINavigationController
class NontitleBackButtonNavigationController: UINavigationController {
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    if self.topViewController?.navigationItem.backBarButtonItem == nil {
      let nontitleBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
      self.topViewController?.navigationItem.backBarButtonItem = nontitleBackButton
    }
  }
}
