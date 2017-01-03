//
//  UIApplication.extension.swift
//
//  Created by hara on 2016/07/25.
//

import UIKit

extension UIApplication {
  public static var appName: String? { get { return Bundle.main.infoDictionary?["CFBundleName"] as? String } }
}
