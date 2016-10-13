//
//  String.extension.swift
//
//  Created by hara on 2016/01/01.
//

import Foundation

extension String {
  /// 正しいメールアドレスか否かを判別する
  public func isValidEmailAddress() -> Bool {
    // RFC に忠実に準拠しているとは言えないが、現実的なチェックとしては必要十分 (see: http://emailregex.com/)
    guard let _ = self.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .regularExpression) else {
      return false
    }
    return true
  }

  /// checkCharacters で指定された文字以外の文字があるか否かを判定する
  public func hasOtherCharacters(with checkCharacters_: [Character]) -> Bool {
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
  public func localized(with tableName_: String? = nil) -> String {
    return NSLocalizedString(self, tableName: tableName_, comment: "")
  }
}
