//
//  UISearchBar.extension.swift
//
//  Created by khara on 2016/09/06.
//

import UIKit

extension UISearchBar {
  /// UITextField の取得
  open var textField: UITextField? {
    get {
      return self.value(forKey: "_searchField") as? UITextField
    }
  }
}
