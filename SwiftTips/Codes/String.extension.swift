//
//  String.extension.swift
//
//  Created by hara on 2016/01/01.
//

import Foundation

extension String {
  /// 正しいメールアドレスか否かを判別する
  func isValidEmailAddress() -> Bool {
    // RFC に忠実に準拠しているとは言えないが、現実的なチェックとしては必要十分
    guard let _ = self.range(of: "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$", options: .regularExpression) else {
      return false
    }
    return true
  }

  /// checkCharacters で指定された文字以外の文字があるか否かを判定する
  func hasOtherCharacters(with checkCharacters_: [Character]) -> Bool {
    for character in self.characters {
      var matched = false
      for checkCharacter in checkCharacters_ {
        if checkCharacter == character {
          matched = true
          break
        }
      }
      if !matched {
        return true
      }
    }
    return false
  }
}

extension String {
  func localized(with tableName_: String? = nil) -> String {
    return NSLocalizedString(self, tableName: tableName_, comment: "")
  }
}
