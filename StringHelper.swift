//
//  StringHelper.swift
//
//  Created by hara on 2016/07/21.
//

import Foundation

struct Localizable<YourClassNameT> {
  static func stringWith(key key_: String) -> String {
    return NSLocalizedString(key_, tableName: "\(YourClassNameT.self)", comment: "")
  }
}
