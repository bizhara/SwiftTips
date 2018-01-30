//
//  LinesTextView.swift
//
//  Created by hara on 2015/12/23.
//

import UIKit

/// 入力に応じて高さ調整する TextView
open class LinesTextView: PlaceholderTextView {
  override open func awakeFromNib() {
    super.awakeFromNib()

    NotificationCenter.default.addObserver(self, selector: #selector(self.adjustableTextViewTextDidChange(_:)), name: .UITextViewTextDidChange, object: nil)

    self.setup()
  }

  @objc func adjustableTextViewTextDidChange(_ notification: Notification) {
    if self.isFirstResponder {
      self.sizeToFit()
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  var didChangeHeight: ((LinesTextView, CGFloat) -> Void)?

  @IBInspectable var minLines: Int = 1
  @IBInspectable var maxLines: Int = 1

  private(set) var minHeight: CGFloat = 0
  private(set) var maxHeight: CGFloat = 0

  override open var frame: CGRect {
    didSet {
      if oldValue.size.height != self.frame.size.height {
        self.didChangeHeight?(self, self.frame.size.height)
      }
    }
  }

  override open func sizeThatFits(_ size: CGSize) -> CGSize {
    var newSize = super.sizeThatFits(size)

    if newSize.height < self.minHeight {
      newSize.height = self.minHeight;
      self.isScrollEnabled = false;
    } else {
      if newSize.height > self.maxHeight {
        newSize.height = self.maxHeight;
        self.isScrollEnabled = true;
      } else {
        self.isScrollEnabled = false;
      }
    }

    return newSize
  }
}

extension LinesTextView {
  private func setup() {
    self.minHeight = self.heightBy(lines: self.minLines)
    self.maxHeight = self.heightBy(lines: self.maxLines)

    if self.minHeight != self.frame.size.height {
      var frame = self.frame
      frame.size.height = self.minHeight
      self.frame = frame
    }
  }

  private func heightBy(lines: Int) -> CGFloat {
    guard let lineHeight = self.font?.lineHeight else {
      return 0
    }
    var height = lineHeight * CGFloat(lines)
    height += (self.textContainerInset.top + self.textContainerInset.bottom)
    return height
  }
}
