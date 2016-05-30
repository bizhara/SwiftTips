//
//  NSObject.extension.swift
//  
//
//  Created by hara on 2016/05/31.
//
//

import Foundation

extension NSObject {
  class func className() -> String {
    return "\(self)"
  }
  
  func className() -> String {
    return "\(self.dynamicType)"
  }
}
