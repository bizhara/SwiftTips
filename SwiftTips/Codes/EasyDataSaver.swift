//
//  EasyDataSaver.swift
//
//  Created by hara on 2016/07/19.
//

import Foundation

/// Archived save and restore data using UserDefaults.
class EasyDataSaver {
  private var data: Data?
  private let dataKey: String
  
  init(with dataKey_: String) {
    self.dataKey = dataKey_
  }
  
  /// Can not use EasyDataSaver()
  private init() {
    self.dataKey = ""
  }
  
  func update(with newDictionary_: [String: Any]) {
    let newData = NSKeyedArchiver.archivedData(withRootObject: newDictionary_)
    self.data = newData
  }
  
  func toDictionary() -> [String: Any]? {
    guard let _ = self.data else {
      return nil
    }
    
    let userInfoDictionary = NSKeyedUnarchiver.unarchiveObject(with: self.data!) as! [String: Any]
    return userInfoDictionary
  }
  
  func hasData() -> Bool {
    return self.data != nil
  }
  
  func save() {
    guard let _ = self.data else {
      return
    }
    
    UserDefaults.standard.set(self.data, forKey: self.dataKey)
  }
  
  func restore() {
    self.data = UserDefaults.standard.object(forKey: self.dataKey) as? Data
  }
  
  func clear() {
    self.data = nil
    UserDefaults.standard.removeObject(forKey: self.dataKey)
  }
}