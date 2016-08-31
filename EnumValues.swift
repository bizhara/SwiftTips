//
//  EnumValues.swift
//
//  Created by khara on 2016/08/26.
//

import Foundation

/// enum 定義を各種の型に変換する
protocol EnumValues {
  typealias EnumTypeT = Self

  /// 全 case の配列（各 enum で実装必要）
  static var allValues: [EnumTypeT] { get }
  /// 各 case を文字列に変換する（各 enum で実装必要）
  var string: String { get }
  /// 各文字列を case に変換する
  static func enumValue(from string_: String?) -> EnumTypeT

  /// 全 case の文字列配列
  static func allStringValues() -> [String]
  /// 全 case を separator でつないだ文字列
  static func allValuesString() -> String
  /// allValuesString(:) 用 separator（必要に応じて各 enum で再定義）
  static var separator: String { get }
}

extension EnumValues {
  static func ==(left: EnumTypeT, right: EnumTypeT) -> Bool {
    return left.string == right.string
  }

  static func enumValue(from string_: String?) -> EnumTypeT {
    guard let fromStr = string_ else {
      return self.allValues[0]
    }

    var index = 0
    for enumStr in self.allStringValues() {
      if enumStr == fromStr {
        return self.allValues[index]
      }
      index += 1
    }
    return self.allValues[0]
  }

  static func allStringValues() -> [String] {
    var result: [String] = []
    for value in EnumTypeT.allValues {
      result.append(value.string)
    }
    return result
  }

  static func allValuesString() -> String {
    return EnumTypeT.allStringValues().joined(separator: self.separator)
  }

  static var separator: String {
    return ","
  }
}
