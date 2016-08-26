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

  /// 全 case の文字列配列
  static func allStringValues() -> [String]
  /// 全 case を separator でつないだ文字列
  static func allValuesString() -> String
  /// allValuesString(:) 用 separator
  static func separator() -> String

  /// 各 case の index 数値文字列
  func intString() -> String
  /// 各 index 数値文字列から enum 値
  static func from(intString intString_: String) -> EnumTypeT
  /// intString, from 用 index 開始値
  static func baseIndex() -> Int
}

extension EnumValues {
  static func ==(left: EnumTypeT, right: EnumTypeT) -> Bool {
    return left.string == right.string
  }

  static func allStringValues() -> [String] {
    var result: [String] = []
    for value in EnumTypeT.allValues {
      result.append(value.string)
    }
    return result
  }

  static func allValuesString() -> String {
    return EnumTypeT.allStringValues().joined(separator: self.separator())
  }

  static func separator() -> String {
    return ","
  }

  func intString() -> String {
    var index = EnumTypeT.baseIndex()
    for value in EnumTypeT.allValues {
      if value == self {
        return String(index)
      }
      index += 1
    }
    return String(EnumTypeT.baseIndex())
  }

  static func from(intString intString_: String) -> EnumTypeT {
    guard let index = Int(intString_) else {
      return EnumTypeT.allValues[0]
    }
    guard index >= EnumTypeT.baseIndex() else {
      return EnumTypeT.allValues[0]
    }
    guard index < EnumTypeT.allValues.count else {
      return EnumTypeT.allValues[0]
    }
    return EnumTypeT.allValues[index - EnumTypeT.baseIndex()]
  }

  static func baseIndex() -> Int {
    return 0
  }
}
