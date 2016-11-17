//
//  Array.extension.swift
//
//  Created by khara on 2016/09/27.
//

import Foundation

extension Array where Element: Equatable {
  public mutating func remove(elements elements_: [Element]) {
    for element in elements_ {
      self.remove(element: element)
    }
  }

  public mutating func remove(element element_: Element) {
    self = self.filter { $0 != element_ }
  }
}
