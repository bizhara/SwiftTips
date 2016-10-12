//
//  StatusBarController.swift
//
//  Created by hara on 2016/05/24.
//

import UIKit

protocol StatusBarControllDestinationProtocol {
  var hideStatusBar: Bool { get set }
}

protocol StatusBarControllSourceProtocol {
  var controllerDestination: StatusBarControllDestinationProtocol! { get set }
  
  func hideStatusBar()
  func showStatusBar()
}

/* Examples.
class StatusBarControllDestination: UIViewController, StatusBarControllDestinationProtocol {
  var hideStatusBar: Bool = false {
    didSet(oldHideStatusBar) {
      if oldHideStatusBar != self.hideStatusBar {
        self.setNeedsStatusBarAppearanceUpdate()
      }
    }
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return self.hideStatusBar
  }
}

class StatusBarControllSource: UIViewController, StatusBarControllSourceProtocol {
  var controllerDestination: StatusBarControllDestinationProtocol! = nil
  
  func hideStatusBar() {
    self.controllerDestination.hideStatusBar = true
  }
  
  func showStatusBar() {
    self.controllerDestination.hideStatusBar = false
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    self.hideStatusBar()
  }
  
  override func viewWillDisappear(animated: Bool) {
    self.showStatusBar()
    
    super.viewWillDisappear(animated)
  }
}
*/
