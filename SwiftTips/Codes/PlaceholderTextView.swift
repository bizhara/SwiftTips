//
//  PlaceholderTextView.swift
//
//  Created by hara on 2015/12/23.
//

import UIKit

// Placeholder 付き UITextView（nib ベース前提）
class PlaceholderTextView: UITextView {
  var placeholder: String! {
    get {
      return self.placeholderLabel.text
    }
    set(newPlaceholder) {
      self.placeholderLabel.text = newPlaceholder
      
      self.placeholderLabel.sizeToFit()
      var frame = self.placeholderLabel.frame
      frame.origin.x += (self.textContainerInset.left + PLACEHOLDER_X_ADJUSTER)
      frame.origin.y += self.textContainerInset.top
      self.placeholderLabel.frame = frame
      
      self.placeholderLabel.hidden = (self.text.characters.count > 0)
    }}
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.placeholderLabel = UILabel(frame: CGRectZero)
    self.placeholderLabel.font = self.font
    self.placeholderLabel.textColor = UIColor.colorFrom(hexColorValue: PLACEHOLDER_TEXT_COLOR)
    self.placeholderLabel.text = ""
    self.addSubview(self.placeholderLabel)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.textDidChange(_:)), name: UITextViewTextDidChangeNotification, object: nil)
  }
  
  override func removeFromSuperview() {
    NSNotificationCenter.defaultCenter().removeObserver(self)
    
    super.removeFromSuperview()
  }
  
  func textDidChange(notification: NSNotification) {
    self.placeholderLabel.hidden = (self.text.characters.count > 0)
  }
  
  // MARK: - Privates
  
  private let PLACEHOLDER_TEXT_COLOR: UInt = 0xc7c7c7
  private let PLACEHOLDER_X_ADJUSTER: CGFloat = 4
  
  private var placeholderLabel: UILabel!
}
