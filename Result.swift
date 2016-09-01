//
//  Result.swift
//
//  Created by khara on 2016/09/01.
//

import Foundation

enum Result<DataTypeT, ErrorTypeT> {
  case ok(DataTypeT)
  case ng(ErrorTypeT)

  var isOk: Bool {
    switch self {
      case .ok: return true
      case .ng: return false
    }
  }

  var isNg: Bool {
    return !self.isOk
  }

  var data: DataTypeT? {
    switch self {
      case .ok(let data): return data
      case .ng: return nil
    }
  }

  var err: ErrorTypeT? {
    switch self {
      case .ok: return nil
      case .ng(let err): return err
    }
  }
}
