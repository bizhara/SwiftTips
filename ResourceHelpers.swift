//
//  ResourceHelpers.swift
//
//  Created by khara on 2016/08/10.
//

import UIKit

/// Storyboard から InitialViewController 指定された ViewController の生成
/// （YourViewControllerT と Storyboard 名が同じと想定）
struct ViewController<YourViewControllerT> {
  static func fromStoryboard() -> YourViewControllerT? {
    let storyboard = UIStoryboard(name: "\(YourViewControllerT.self)", bundle: nil)
    let me = storyboard.instantiateInitialViewController() as? YourViewControllerT
    return me
  }
}

/// Storyboard から InitialViewController 指定された NavigationController の生成
/// （YourViewControllerT と Storyboard 名が同じと想定）
struct NavigationController<YourViewControllerT, YourNovigationControllerT> {
  static func fromStoryboard() -> YourNovigationControllerT? {
    let storyboard = UIStoryboard(name: "\(YourViewControllerT.self)", bundle: nil)
    let me = storyboard.instantiateInitialViewController() as? YourNovigationControllerT
    return me
  }
}

/// nib からオブジェクトを取得する
struct object<YourClassT> {
  static func fromNib() -> YourClassT? {
    let nib = UINib(nibName: "\(YourClassT.self)", bundle: nil)
    let objects = nib.instantiate(withOwner: nil, options: nil)
    guard objects.count > 0 else {
      return nil
    }
    let me = objects[0] as? YourClassT
    return me
  }
}

/// nib 属性の取得
struct nib<YourClassT> {
  static func name() -> String {
    return "\(YourClassT.self)"
  }

  static func id() -> String {
    return self.name()
  }
}
