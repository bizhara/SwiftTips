//
//  Numbers.extension.swift
//  Dolphin-iOS
//
//  Created by khara on 2016/09/20.
//  Copyright © 2016年 Kazuaki Hara. All rights reserved.
//

import UIKit

public protocol ToCommaString {
  typealias NumberTypeT = Self
  func toCommaString() -> String
}

extension ToCommaString {
  public func toCommaString() -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = ","
    formatter.groupingSize = 3
    return formatter.string(for: self) ?? ""
  }
}

extension Int: ToCommaString {}
extension UInt: ToCommaString {}
extension Double: ToCommaString {}
extension Float: ToCommaString {}
extension CGFloat: ToCommaString {}
