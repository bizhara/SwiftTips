//
//  PlaceholderTextView.swift
//
//  Created by hara on 2015/12/23.
//

import UIKit

// Placeholder 付き UITextView
open class PlaceholderTextView: UITextView {
  override open func awakeFromNib() {
    super.awakeFromNib()

    NotificationCenter.default.addObserver(self, selector: #selector(self.textViewWithPlaceholderTextDidChange(_:)), name: .UITextViewTextDidChange, object: nil)

    self.setup()
  }

  @objc func textViewWithPlaceholderTextDidChange(_ notification: Notification) {
    if self.isFirstResponder {
      self.placeholderView?.isHidden = (self.text.count > 0)
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  @IBInspectable var placeholder: String? {
    get {
      return self.placeholderView?.text
    }
    set {
      self.placeholderView?.text = newValue
      self.placeholderView?.isHidden = (self.text.count > 0)
    }
  }

  @IBInspectable var placeholderTextColor: UIColor? {
    didSet {
      self.placeholderView?.textColor = self.placeholderTextColor
    }
  }

  override open var font: UIFont? {
    didSet {
      self.placeholderView?.font = self.font
    }
  }

  override open var textContainerInset: UIEdgeInsets {
    didSet {
      self.placeholderView?.textContainerInset = self.textContainerInset
    }
  }

  override open var isScrollEnabled: Bool {
    didSet {
      self.placeholderView?.isScrollEnabled = self.isScrollEnabled
    }
  }

  override open func layoutSubviews() {
    super.layoutSubviews()

    // AutoLayout の設定が良くないのか placeholderView.frame.size がゼロになってしまうのを補う
    if let placeholderView = self.placeholderView,
      placeholderView.isHidden == false {
      placeholderView.frame.size = self.frame.size
      placeholderView.sizeToFit()
      var viewSize = placeholderView.frame.size
      viewSize.width = self.frame.width
      self.frame.size = viewSize
      placeholderView.frame.size = viewSize
    }
  }

  private var placeholderView: UITextView?
}

extension PlaceholderTextView {
  private func setup() {
    let placeholderFrame = self.bounds
    self.placeholderView = UITextView(frame: placeholderFrame)
    guard let placeholderView = self.placeholderView else { return }

    placeholderView.isUserInteractionEnabled = false
    placeholderView.backgroundColor = UIColor.clear
    placeholderView.font = self.font
    placeholderView.textColor = self.placeholderTextColor ?? UIColor.lightGray
    placeholderView.textContainerInset = self.textContainerInset
    placeholderView.clipsToBounds = true
    placeholderView.isScrollEnabled = self.isScrollEnabled
    self.addSubview(placeholderView)
    self.setSimpleLayout(withInternalView: placeholderView)

    placeholderView.text = self.placeholder ?? ""
    placeholderView.isHidden = (self.text.count > 0)
  }
}
