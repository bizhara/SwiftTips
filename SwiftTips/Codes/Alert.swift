//
//  Alert.swift
//
//  Created by khara on 2016/07/29.
//

import UIKit

func alert(with title_: String, message message_: String,
           presentOn presentOn_: UIViewController,
           moreSetup moreSetup_: ((_ alert: UIAlertController) -> Void)? = nil,
           closed closed_: ((_ sender: UIAlertAction) -> Void)? = nil) {
  let alert = UIAlertController(title: title_, message: message_, preferredStyle: .alert)

  let okAction = UIAlertAction(title: "OK", style: .default, handler: closed_)
  alert.addAction(okAction)

  if let moreSetupTo = moreSetup_ {
    moreSetupTo(alert)
  }

  presentOn_.present(alert, animated: true, completion: nil)
}
