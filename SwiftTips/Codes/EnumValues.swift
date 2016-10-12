//
//  EnumValues.swift
//
//  Created by khara on 2016/08/26.
//

import Foundation

/// enum 定義を各種の型に変換する
public protocol EnumValues {
  typealias EnumTypeT = Self

  /// 全 case の配列（各 enum で実装必須）
  static var enumValues: [EnumTypeT] { get }
  /// 各 case を文字列に変換する（各 enum で実装必須）
  var string: String { get }

  /// 全 case 数
  static var count: Int { get }
  /// 各 case の位置
  var index: Int { get }
  /// 各文字列を case に変換する
  static func enumValue(from string_: String?) -> EnumTypeT

  /// 全 case の文字列配列
  static func stringValues() -> [String]
  /// 全 case を separator でつないだ文字列
  static func valuesString() -> String
  /// valuesString(:) 用 separator（必要に応じて各 enum で再定義）
  static var separator: String { get }
}

extension EnumValues {
  public static func ==(left: EnumTypeT, right: EnumTypeT) -> Bool {
    return left.string == right.string
  }

  public static var count: Int {
    get {
      return self.enumValues.count
    }
  }

  public var index: Int {
    get {
      var enumIndex = 0
      for enumValue in type(of: self).enumValues {
        if enumValue == self {
          return enumIndex
        }
        enumIndex += 1
      }
      return 0
    }
  }

  public static func enumValue(from string_: String?) -> EnumTypeT {
    guard let fromStr = string_ else {
      return self.enumValues[0]
    }

    var index = 0
    for enumStr in self.stringValues() {
      if enumStr == fromStr {
        return self.enumValues[index]
      }
      index += 1
    }
    return self.enumValues[0]
  }
}

extension EnumValues {
  public static func stringValues() -> [String] {
    var result: [String] = []
    for value in EnumTypeT.enumValues {
      result.append(value.string)
    }
    return result
  }

  public static func valuesString() -> String {
    return EnumTypeT.stringValues().joined(separator: self.separator)
  }

  public static var separator: String {
    return ","
  }
}
