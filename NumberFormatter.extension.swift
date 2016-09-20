//
//  NumberFormatter.extension.swift
//  Dolphin-iOS
//
//  Created by khara on 2016/09/20.
//  Copyright © 2016年 Kazuaki Hara. All rights reserved.
//

import Foundation

extension NumberFormatter {
  static func toCommaString<NumberT>(from number: NumberT) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = ","
    formatter.groupingSize = 3
    return formatter.string(for: number) ?? ""
  }
}
