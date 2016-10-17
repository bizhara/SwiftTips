//
//  ResourceHelpers.swift
//
//  Created by khara on 2016/08/10.
//

import UIKit

/// xib, storyboard の扱い
protocol NibProtocol {
  static var nibName: String { get }
  static var reuseID: String { get }
  static func fromNib() -> Self?
  static func fromStoryboard() -> Self?
}

extension NibProtocol {
  static var nibName: String {
    return String(describing: self)
  }

  static var reuseID: String {
    return self.nibName
  }

  static func fromNib() -> Self? {
    let nib = UINib(nibName: self.nibName, bundle: nil)
    let objects = nib.instantiate(withOwner: nil, options: nil)
    guard objects.count > 0 else { return nil }
    let me = objects[0] as? Self
    return me
  }

  static func fromStoryboard() -> Self? {
    let storyboard = UIStoryboard(name: self.nibName, bundle: nil)
    let me = storyboard.instantiateInitialViewController() as? Self
    return me
  }
}
