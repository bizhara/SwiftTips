//
//  UIView+AutoLayout.swift
//  teacha
//
//  Created by khara on 1/26/18.
//  Copyright © 2018 souzoh. All rights reserved.
//

import UIKit

extension UIView {
    func setSimpleLayout(withInternalView: UIView, hMargin: CGFloat = 0.0, vMargin: CGFloat = 0.0) {
        withInternalView.translatesAutoresizingMaskIntoConstraints = false
        let views = ["internalView": withInternalView]

        self.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(hMargin)-[internalView]-\(hMargin)-|",
                options: .alignAllTop,
                metrics: nil,
                views: views))
        self.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(vMargin)-[internalView]-\(vMargin)-|",
                options: .alignAllTop,
                metrics: nil,
                views: views))
    }
}
