//
//  PlaceholderTextView.swift
//
//  Created by hara on 2015/12/23.
//

import UIKit

// Placeholder 付き UITextView
open class PlaceholderTextView: UITextView {
  open var placeholder: String! {
    get {
      return self.placeholderLabel.text
    }
    set(newPlaceholder) {
      self.placeholderLabel.text = newPlaceholder
      
      self.placeholderLabel.sizeToFit()
      var frame = self.placeholderLabel.frame
      frame.origin.x += (self.textContainerInset.left + self.placeholderMarginX)
      frame.origin.y += self.textContainerInset.top
      self.placeholderLabel.frame = frame
      
      self.placeholderLabel.isHidden = (self.text.characters.count > 0)
    }
  }

  open var placeholderTextColor: UIColor!

  public override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    self.setupPlaceholder()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setupPlaceholder()
  }

  override open func awakeFromNib() {
    super.awakeFromNib()

    self.setupPlaceholder()
  }

  private func setupPlaceholder() {
    self.placeholderTextColor = UIColor.color(from: self.defaultPlaceholderTextColor)

    self.placeholderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    self.placeholderLabel.numberOfLines = 0
    self.placeholderLabel.font = self.font
    self.placeholderLabel.textColor = self.placeholderTextColor
    self.placeholderLabel.text = ""
    self.addSubview(self.placeholderLabel)

    NotificationCenter.default.addObserver(self, selector: #selector(self.textDidChange(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
  }

  override open func removeFromSuperview() {
    NotificationCenter.default.removeObserver(self)
    
    super.removeFromSuperview()
  }
  
  open func textDidChange(_ notification: NSNotification) {
    self.placeholderLabel.isHidden = (self.text.characters.count > 0)
  }
  
  // MARK: - Privates
  
  private let placeholderMarginX: CGFloat = 4
  
  private var placeholderLabel: UILabel!

  private let defaultPlaceholderTextColor: UInt = 0xc7c7c7
}
