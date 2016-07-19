//
//  EasyDataSaver.swift
//
//  Created by hara on 2016/07/19.
//

import Foundation

/// Archived save and restore data using UserDefaults.
class EasyDataSaver {
  #if swift(>=3.0)
  private var data: Data? = nil
  #else
  private var data: NSData? = nil
  #endif
  private let dataKey: String
  
  init(dataKey dataKey_: String) {
    self.dataKey = dataKey_
    self.restore()
  }
  
  /// Can not use EasyDataSaver()
  private init() {
    self.dataKey = ""
  }
  
  func replaceWith(newDictionary newDictionary_: [String: AnyObject]) {
    #if swift(>=3.0)
    let newData = NSKeyedArchiver.archivedData(withRootObject: newDictionary_)
    #else
    let newData = NSKeyedArchiver.archivedDataWithRootObject(newDictionary_)
    #endif
    self.data = newData
  }
  
  func toDictionary() -> [String: String]? {
    guard let userInfoData = self.data else {
      return nil
    }
    
    #if swift(>=3.0)
    let userInfoDictionary = NSKeyedUnarchiver.unarchiveObject(with: userInfoData) as! [String: String]
    #else
    let userInfoDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(userInfoData) as! [String: String]
    #endif
    return userInfoDictionary
  }
  
  func hasData() -> Bool {
    return self.data != nil
  }
  
  func save() {
    guard let _ = self.data else {
      return
    }
    
    #if swift(>=3.0)
    UserDefaults.standard.set(self.data, forKey: self.dataKey)
    #else
    NSUserDefaults.standardUserDefaults().setObject(self.data, forKey: self.dataKey)
    #endif
  }
  
  func restore() {
    #if swift(>=3.0)
    self.data = UserDefaults.standard.object(forKey: self.dataKey) as? Data
    #else
    self.data = NSUserDefaults.standardUserDefaults().objectForKey(self.dataKey) as? NSData
    #endif
  }
  
  func clear() {
    self.data = nil
    #if swift(>=3.0)
    UserDefaults.standard.removeObject(forKey: self.dataKey)
    #else
    NSUserDefaults.standardUserDefaults().removeObjectForKey(self.dataKey)
    #endif
  }
}
