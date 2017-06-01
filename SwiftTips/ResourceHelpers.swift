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

/// UIView.layer の設定を IB から可能にする
@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            if let borderColor = self.layer.borderColor {
                return UIColor(cgColor: borderColor)
            } else {
                return nil
            }
        }
        set(newValue) {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set(newValue) {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var cornerRadius:CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set(newValue) {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = newValue > 0
        }
    }
}
