//
//  ResourceHelpers.swift
//
//  Created by khara on 2016/08/10.
//

import UIKit

/// xib, storyboard の扱い
public protocol NibProtocol {
  associatedtype NibT

  static var nibName: String { get }
  static var reuseID: String { get }
  static func fromNib() -> NibT?
  static func fromStoryboard() -> NibT?
}

extension NibProtocol {
  public static var nibName: String {
    return String(describing: self)
  }

  public static var reuseID: String {
    return self.nibName
  }

  public static func fromNib() -> NibT? {
    let nib = UINib(nibName: self.nibName, bundle: nil)
    let objects = nib.instantiate(withOwner: nil, options: nil)
    guard objects.count > 0 else { return nil }
    let me = objects[0] as? NibT
    return me
  }

  public static func fromStoryboard() -> NibT? {
    let storyboard = UIStoryboard(name: self.nibName, bundle: nil)
    let me = storyboard.instantiateInitialViewController() as? NibT
    return me
  }
}
