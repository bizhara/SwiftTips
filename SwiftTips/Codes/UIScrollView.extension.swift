//
//  UIScrollView.extension.swift
//
//  Created by hara on 2015/12/15.
//

import UIKit

extension UIScrollView {
  // iOS 9.2 以前で topLayoutGuide.length が反映されていないため表示位置がズレてしまう不具合を補う
  open func reflectTopLayoutGuide(topLayoutGuide topLayoutGuide_: UILayoutSupport) {
    if (self.contentInset.top == 0) {
      var insets = self.contentInset
      insets.top = topLayoutGuide_.length
      self.contentInset = insets
      self.scrollIndicatorInsets = insets
    }
  }
}
