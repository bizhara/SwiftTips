//
//  UISearchBar.extension.swift
//
//  Created by khara on 2016/09/06.
//

import UIKit

extension UISearchBar {
  private var textFieldKey: String { get { return "_searchField" } }
  private var cancelButtonKey: String { get { return "_cancelButtonText" } }

  /// UITextField の取得
  open var textField: UITextField? { get { return self.value(forKey: self.textFieldKey) as? UITextField } }

  /// キャンセルボタンの表示文字列設定
  open func setCancelButtonText(with buttonText: String) {
    self.setValue(buttonText, forKey: self.cancelButtonKey)
  }
}
