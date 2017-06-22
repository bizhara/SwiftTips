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
      return self.placeholderView?.text
    }
    set(newPlaceholder) {
      self.placeholderView?.text = newPlaceholder
      self.sizePlaceholder()
      self.placeholderView?.isHidden = (self.text.characters.count > 0)
    }
  }

  open var placeholderTextColor: UIColor! {
    didSet {
      self.placeholderView?.textColor = self.placeholderTextColor
    }
  }

  override open var frame: CGRect {
    didSet {
      var frame = self.frame
      frame.origin = CGPoint.zero
      self.placeholderView?.frame = frame
    }
  }

  override open var bounds: CGRect {
    didSet {
      var bounds = self.bounds
      bounds.origin = CGPoint.zero
      self.placeholderView?.bounds = bounds
    }
  }

  override open var font: UIFont? {
    didSet {
      self.placeholderView?.font = self.font
    }
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

    var placeholderFrame = self.frame
    placeholderFrame.origin = CGPoint.zero
    self.placeholderView = UITextView(frame: placeholderFrame)
    guard let placeholderView = self.placeholderView else { return }

    placeholderView.isUserInteractionEnabled = false
    placeholderView.backgroundColor = UIColor.clear
    placeholderView.font = self.font
    placeholderView.text = ""
    placeholderView.textColor = UIColor.color(from: self.defaultPlaceholderTextColor)
    self.addSubview(placeholderView)

    NotificationCenter.default.addObserver(self, selector: #selector(self.textDidChange(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)

    self.didSetup = true
  }

  override open func removeFromSuperview() {
    NotificationCenter.default.removeObserver(self)

    super.removeFromSuperview()
  }

  open func textDidChange(_ notification: NSNotification) {
    self.placeholderView?.isHidden = (self.text.characters.count > 0)
  }

  private func sizePlaceholder() {
    var size = self.bounds.size
    size.height = 0
    self.placeholderView?.frame.size = size
    self.placeholderView?.sizeToFit()
  }

  private func positionPlaceholder() {
    self.placeholderView?.frame.origin = CGPoint.zero
  }

  override open func layoutSubviews() {
    super.layoutSubviews()
    self.positionPlaceholder()
  }

  // MARK: - Privates

  private var placeholderView: UITextView?

  private let defaultPlaceholderTextColor: UInt = 0xc7c7c7
  
  private var didSetup: Bool = false
}
