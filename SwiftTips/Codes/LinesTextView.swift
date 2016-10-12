//
//  LinesTextView.swift
//
//  Created by hara on 2015/12/23.
//

import UIKit

// 入力に応じて高さ調整する TextView
class LinesTextView: PlaceholderTextView {
  private(set) var minHeight: CGFloat = 0
  private(set) var maxHeight: CGFloat = 0
  
  override var frame: CGRect {
    didSet(oldFrame) {
      if (oldFrame.size.height != self.frame.size.height) {
        self.didChangeHeight?(sender: self, newHeight: self.frame.size.height)
      }
    }
  }
  
  func setupWith(minLines minLines_: Int, maxLines maxLines_: Int, didChangeHeight didChangeHeight_: ((sender: LinesTextView, newHeight: CGFloat) -> Void)?) {
    self.minLines = minLines_
    self.maxLines = maxLines_
    self.minHeight = self.heightBy(lines: self.minLines)
    self.maxHeight = self.heightBy(lines: self.maxLines)
    self.didChangeHeight = didChangeHeight_
    
    if (self.minHeight != self.frame.size.height) {
      var frame = self.frame
      frame.size.height = self.minHeight
      self.frame = frame
    }
  }
  
  private func heightBy(lines lines_: Int) -> CGFloat {
    let lineHeight = Int((self.font?.lineHeight)!) + 1 // 描画上整数値の方が崩れることがないので、一旦小数点以下を切り捨てて 1 切り上げる
    var height: CGFloat = CGFloat(lineHeight * lines_)
    height += (self.textContainerInset.top + self.textContainerInset.bottom)
    return height
  }
  
  override func sizeThatFits(size: CGSize) -> CGSize {
    var newSize = super.sizeThatFits(size)
    
    if (newSize.height < self.minHeight) {
      newSize.height = self.minHeight;
      self.scrollEnabled = false;
    } else {
      if (newSize.height > self.maxHeight) {
        newSize.height = self.maxHeight;
        self.scrollEnabled = true;
      } else {
        self.scrollEnabled = false;
      }
    }
    
    return newSize
  }
  
  // MARK: - Privates
  private var minLines: Int = 0
  private var maxLines: Int = 0
  private var didChangeHeight: ((sender: LinesTextView, newHeight: CGFloat) -> Void)?
}
