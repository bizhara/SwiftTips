//
//  Alert.swift
//
//  Created by khara on 2016/07/29.
//

import UIKit

public func alert(on viewController: UIViewController,
                  title title_: String?,
                  message message_: String?,
                  defaultButtonTitle defaultButtonTitle_: String?,
                  destructiveButtonTitle destructiveButtonTitle_: String? = nil,
                  moreSetup moreSetup_: ((_ alert: UIAlertController) -> Void)? = nil,
                  closed closed_: ((_ byDestructive: Bool) -> Void)? = nil) {
  let alert = UIAlertController(title: title_, message: message_, preferredStyle: .alert)

  let defaultAction = UIAlertAction(title: defaultButtonTitle_, style: .cancel) { (_ alertAction: UIAlertAction) in
    closed_?(false)
  }
  alert.addAction(defaultAction)

  if let destructiveButtonTitle = destructiveButtonTitle_ {
    let destructiveAction = UIAlertAction(title: destructiveButtonTitle, style: .destructive) { (_ alertAction: UIAlertAction) in
      closed_?(true)
    }
    alert.addAction(destructiveAction)
  }

  moreSetup_?(alert)
  viewController.present(alert, animated: true, completion: nil)
}
