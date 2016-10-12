//
//  PlaceholderTextView.swift
//
//  Created by hara on 2015/12/23.
//

import UIKit

// Placeholder 付き UITextView（nib ベース前提）
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
  
  override open func awakeFromNib() {
    super.awakeFromNib()
    
    self.placeholderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    self.placeholderLabel.font = self.font
    self.placeholderLabel.textColor = UIColor.color(from: self.placeholderTextColor)
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
  
  private let placeholderTextColor: UInt = 0xc7c7c7
  private let placeholderMarginX: CGFloat = 4
  
  private var placeholderLabel: UILabel!
}
