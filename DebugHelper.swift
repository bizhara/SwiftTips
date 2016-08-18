//
//  DebugHelper.swift
//
//  Created by hara on 2016/03/30.
//

import Foundation

// "#if DEBUG" を有効にするには、Swift Compiler - Custom Flags 中の Other Swift Flags の Debug 欄に "-DDEBUG" を加える

@inline(__always) func dLogOnly(log log_: Any) {
#if DEBUG
  print(">> \(log_)")
#endif
}

@inline(__always) func dLog(filePath filePath_: String = #file, function function_: String = #function, line line_: Int = #line, log log_: Any?) {
#if DEBUG
  let paths = filePath_.components(separatedBy: "/")
  let fileName = paths[paths.count - 1]
  let className = fileName.components(separatedBy: ".")[0]
  print(">> \(className).\(function_):\(line_)")
  if let debugLog = log_ {
    dLogOnly(log: debugLog)
  }
#endif
}
