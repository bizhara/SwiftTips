//
//  UIButton.extension.swift
//
//  Created by khara on 2016/10/04.
//

import UIKit

extension UIButton {
  public enum ImageTextPositions {
    case imageTopTextBottom
    case imageBottomTextTop
    case imageLeftTextRight
    case imageRightTextLeft
  }

  open func positionImageAndText(with position: ImageTextPositions, space space_: CGFloat) {
    guard let imageView = self.imageView else { return }
    guard let titleView = self.titleLabel else { return }

    switch position {
      case .imageTopTextBottom:
        self.imageEdgeInsets = UIEdgeInsets(top: -titleView.frame.height,
                                            left: 0,
                                            bottom: 0,
                                            right: -titleView.frame.width)
        self.titleEdgeInsets = UIEdgeInsets(top: space_,
                                            left: -imageView.frame.width,
                                            bottom: -imageView.frame.height,
                                            right: 0)
      case .imageBottomTextTop:
        self.titleEdgeInsets = UIEdgeInsets(top: -imageView.frame.height,
                                            left: -imageView.frame.width,
                                            bottom: 0,
                                            right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: titleView.frame.height + space_,
                                            left: 0,
                                            bottom: 0,
                                            right: -titleView.frame.width)
      case .imageLeftTextRight:
        self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                            left: space_,
                                            bottom: 0,
                                            right: 0)
      case .imageRightTextLeft:
        self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                            left: -(titleView.frame.width + imageView.frame.width),
                                            bottom: 0,
                                            right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                            left: 0,
                                            bottom: 0,
                                            right: -(titleView.frame.width + imageView.frame.width + space_))
    }
  }
}
