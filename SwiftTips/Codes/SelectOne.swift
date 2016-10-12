//
//  SelectOne.swift
//
//  Created by khara on 2016/10/03.
//

import UIKit

/// 択一 UI
public protocol SelectOneProtocol {
  associatedtype ControllerT

  var selectables: [ControllerT]! { get }

  func tappedSelectable(_ sender: ControllerT)
  func selectOne(_ sender: ControllerT)
}

extension SelectOneProtocol where ControllerT: UIControl {
  public func tappedSelectable(_ sender: ControllerT) {
    self.selectOne(sender)
  }

  public func selectOne(_ sender: ControllerT) {
    for selectable in self.selectables {
      if selectable != sender {
        selectable.isSelected = false
      }
    }
    sender.isSelected = true
  }
}
