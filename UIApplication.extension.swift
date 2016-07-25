//
//  UIApplication.extension.swift
//  Dolphin-iOS
//
//  Created by hara on 2016/07/25.
//  Copyright © 2016年 Kazuaki Hara. All rights reserved.
//

import Foundation

extension UIApplication {
  class func appName() -> String? {
    return Bundle.main.infoDictionary?["CFBundleName"] as? String
  }
}
