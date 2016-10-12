//
//  UIApplication.extension.swift
//
//  Created by hara on 2016/07/25.
//

import UIKit

extension UIApplication {
  public class func appName() -> String? {
    return Bundle.main.infoDictionary?["CFBundleName"] as? String
  }
}
