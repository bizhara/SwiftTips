//
//  String.extension.swift
//
//  Created by hara on 2016/01/01.
//

import Foundation

extension String {
  // checkCharacters で指定された文字以外の文字があるか否かを判定する
  func hasOtherCharacters(checkCharacters checkCharacters_: [Character]) -> Bool {
    for character in self.characters {
      var matched = false
      for checkCharacter in checkCharacters_ {
        if (checkCharacter == character) {
          matched = true
          break
        }
      }
      if (!matched) {
        return true
      }
    }
    return false
  }
}
