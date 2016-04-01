//
//  DebugHelper.swift
//
//  Created by hara on 2016/03/30.
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

#if DEBUG
  func dLog(log log_: AnyObject) {
    print("\(log_)")
  }
  
  func dLog(className className_: String, function function_: String = #function, line line_: Int = #line) {
    print(">> \(className_).\(function_):\(line_)")
  }
#else
  func dLog(log log_: AnyObject) {
  }
  func dLog(className className_: String, function function_: String = #function, line line_: Int = #line) {
  }
#endif
