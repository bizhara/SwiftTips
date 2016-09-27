//
//  Array.extension.swift
//
//  Created by khara on 2016/09/27.
//

import Foundation

extension Array where Element: Equatable {
  mutating func removed(elements elements_: [Element]) {
    for element in elements_ {
      self.removed(element: element)
    }
  }

  mutating func removed(element element_: Element) {
    self = filter { $0 != element_ }
  }
}
