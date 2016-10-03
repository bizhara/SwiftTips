//
//  Array.extension.swift
//
//  Created by khara on 2016/09/27.
//

import Foundation

extension Array where Element: Equatable {
  mutating func remove(elements elements_: [Element]) {
    for element in elements_ {
      self.remove(element: element)
    }
  }

  mutating func remove(element element_: Element) {
    self = filter { $0 != element_ }
  }
}
