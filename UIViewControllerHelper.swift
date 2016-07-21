//
//  UIViewControllerHelper.swift
//
//  Created by hara on 2016/07/21.
//

import UIKit

/// Storyboard から InitialViewController 指定された ViewController の生成
/// （YourViewControllerT と Storyboard 名が同じと想定）
class ViewControllerFromStoryboard<YourViewControllerT> {
  class func new() -> YourViewControllerT? {
    let storyboard = UIStoryboard(name: "\(YourViewControllerT.self)", bundle: nil)
    let me = storyboard.instantiateInitialViewController() as? YourViewControllerT
    return me
  }
}
