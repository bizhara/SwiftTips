//
//  Dictionary.extension.swift
//
//  Created by khara on 2016/08/19.
//

import Foundation

extension Dictionary {
  mutating func merged(with dictionary_: Dictionary) {
    for (key, value) in dictionary_ {
      self[key] = value
    }
  }

  func mergedCopy(with dictionary_: Dictionary) -> Dictionary {
    var mergedCopy = self
    for (key, value) in dictionary_ {
      mergedCopy[key] = value
    }
    return mergedCopy
  }
}
