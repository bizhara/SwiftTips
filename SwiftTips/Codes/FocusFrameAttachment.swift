//
//  FocusFrameAttachment.swift
//
//  Created by hara on 2016/01/08.
//

import UIKit

class FocusFrameAttachment {
  init(focusView focusView_: UIView, focusColor focusColor_: UIColor, focusFrameSize focusFrameSize_: CGFloat, focusCornerSize focusCornerSize_: CGFloat = 0) {
    self.focusView = focusView_
    self.focusColor = focusColor_
    self.focusFrameSize = focusFrameSize_
    self.focusCornerSize = focusCornerSize_
  }
  
  var focused: Bool = false {
    didSet(oldFocused) {
      if (oldFocused != self.focused) {
        self.focusView.layer.borderColor = (self.focused) ? self.focusColor.cgColor : nil
        self.focusView.layer.borderWidth = (self.focused) ? self.focusFrameSize : 0
        self.focusView.layer.cornerRadius = (self.focused) ? self.focusCornerSize : 0
      }
    }
  }
  
  private let focusView: UIView
  private let focusColor: UIColor
  private let focusFrameSize: CGFloat
  private let focusCornerSize: CGFloat
}

protocol FocusViewProtocol: NSObjectProtocol {
  var focusAttachment: FocusFrameAttachment! { get }
  func setFocus(focusMe focusMe_: Bool)
}
