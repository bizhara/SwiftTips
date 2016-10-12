//
//  Result.swift
//
//  Created by khara on 2016/09/01.
//

import Foundation

public enum Result<DataTypeT, ErrorTypeT> {
  case ok(DataTypeT)
  case ng(ErrorTypeT)

  public var isOk: Bool {
    switch self {
      case .ok: return true
      case .ng: return false
    }
  }

  public var isNg: Bool {
    return !self.isOk
  }

  public var data: DataTypeT? {
    switch self {
      case .ok(let data): return data
      case .ng: return nil
    }
  }

  public var err: ErrorTypeT? {
    switch self {
      case .ok: return nil
      case .ng(let err): return err
    }
  }
}
