//
//  ResourceHelpers.swift
//
//  Created by khara on 2016/08/10.
//

import UIKit

/// Storyboard から InitialViewController 指定された ViewController の生成
/// （YourViewControllerT と Storyboard 名が同じと想定）
public struct ViewController<YourViewControllerT> {
  public static func fromStoryboard() -> YourViewControllerT? {
    let storyboard = UIStoryboard(name: "\(YourViewControllerT.self)", bundle: nil)
    let me = storyboard.instantiateInitialViewController() as? YourViewControllerT
    return me
  }
}

/// Storyboard から InitialViewController 指定された NavigationController の生成
/// （YourViewControllerT と Storyboard 名が同じと想定）
public struct NavigationController<YourViewControllerT, YourNovigationControllerT> {
  public static func fromStoryboard() -> YourNovigationControllerT? {
    let storyboard = UIStoryboard(name: "\(YourViewControllerT.self)", bundle: nil)
    let me = storyboard.instantiateInitialViewController() as? YourNovigationControllerT
    return me
  }
}

/// nib 属性の取得
public struct Nib<YourClassT> {
  public static func name() -> String {
    return "\(YourClassT.self)"
  }

  public static func id() -> String {
    return self.name()
  }

  public static func object() -> YourClassT? {
    let nib = UINib(nibName: self.name(), bundle: nil)
    let objects = nib.instantiate(withOwner: nil, options: nil)
    guard objects.count > 0 else { return nil }
    let me = objects[0] as? YourClassT
    return me
  }
}
