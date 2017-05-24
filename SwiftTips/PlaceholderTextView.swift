//
//  PlaceholderTextView.swift
//
//  Created by hara on 2015/12/23.
//

import UIKit

// Placeholder 付き UITextView
open class PlaceholderTextView: UITextView {
  open var placeholder: String? {
    get {
      return self.placeholderLabel?.text
    }
    set(newPlaceholder) {
      self.placeholderLabel?.text = newPlaceholder
      self.sizePlaceholder()
      self.placeholderLabel?.isHidden = (self.text.characters.count > 0)
    }
  }

  open var placeholderTextColor: UIColor! {
    didSet {
      self.placeholderLabel?.textColor = self.placeholderTextColor
    }
  }

  override open var font: UIFont? {
    didSet {
      self.placeholderLabel?.font = self.font
    }
  }

  private func sizePlaceholder() {
    guard var size = self.placeholderLabel?.frame.size else { return }
    size.width = self.frame.size.width - ((self.textContainerInset.left + self.placeholderMarginX) + (self.textContainerInset.right + self.placeholderMarginX))
    size.height = 0
    self.placeholderLabel?.frame.size = size

    self.placeholderLabel?.sizeToFit()
  }

  private func positionPlaceholder() {
    guard var position = self.placeholderLabel?.frame.origin else { return }
    position.x = self.textContainerInset.left + self.placeholderMarginX
    position.y = self.textContainerInset.top
    self.placeholderLabel?.frame.origin = position
  }

  override open func layoutSubviews() {
    super.layoutSubviews()
    self.positionPlaceholder()
  }

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
    guard self.didSetup == false else { return }

    self.placeholderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    guard let placeholderLabel = self.placeholderLabel else { return }

    self.didSetup = true

    placeholderLabel.numberOfLines = 0
    placeholderLabel.font = self.font
    placeholderLabel.text = ""
    self.placeholderTextColor = UIColor.color(from: self.defaultPlaceholderTextColor)
    self.addSubview(placeholderLabel)

    NotificationCenter.default.addObserver(self, selector: #selector(self.textDidChange(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
  }

  override open func removeFromSuperview() {
    NotificationCenter.default.removeObserver(self)

    super.removeFromSuperview()
  }

  open func textDidChange(_ notification: NSNotification) {
    self.placeholderLabel?.isHidden = (self.text.characters.count > 0)
  }

  // MARK: - Privates

  private let placeholderMarginX: CGFloat = 4

  private var placeholderLabel: UILabel?

  private let defaultPlaceholderTextColor: UInt = 0xc7c7c7
  
  private var didSetup: Bool = false
}
