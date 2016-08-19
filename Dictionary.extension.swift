//
//  Dictionary.extension.swift
//
//  Created by khara on 2016/08/19.
//

import Foundation

extension Dictionary {
  mutating func merged(withDictionary withDictionary_: Dictionary) {
    for (key, value) in withDictionary_ {
      self[key] = value
    }
  }

  func mergedCopy(withDictionary withDictionary_: Dictionary) -> Dictionary {
    var mergedCopy = self
    for (key, value) in withDictionary_ {
      mergedCopy[key] = value
    }
    return mergedCopy
  }
}
