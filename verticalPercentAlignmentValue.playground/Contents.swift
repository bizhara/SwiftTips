//: Playground - noun: a place where people can play

import UIKit

/// 画面サイズに合わせた相対位置を求める（center horizontaly 指定でのパーセント値）
func horizontalPercentAlignmentValue(withSuperViewFrame: CGRect, targetViewFrame: CGRect) -> CGFloat {
    let baseWidth = withSuperViewFrame.width / 2
    let targetHeight = targetViewFrame.width / 2
    let widthGap = baseWidth - targetHeight
    let xGap = widthGap - targetViewFrame.origin.x
    let targetValue = baseWidth - xGap
    let percentValue = targetValue / baseWidth
    return percentValue
}

/// 画面サイズに合わせた相対位置を求める（center verticaly 指定でのパーセント値）
func verticalPercentAlignmentValue(withSuperViewFrame: CGRect, targetViewFrame: CGRect) -> CGFloat {
    let baseHeight = withSuperViewFrame.size.height / 2
    let targetHeight = targetViewFrame.size.height / 2
    let heightGap = baseHeight - targetHeight
    let yGap = heightGap - targetViewFrame.origin.y
    let targetValue = baseHeight - yGap
    let percentValue = targetValue / baseHeight
    return percentValue
}

let superViewFrame = CGRect(x: 0, y: 0, width: 375, height: 109)
let targetViewFrame = CGRect(x: 340, y: 54, width: 19, height: 19)
let horizontalValue = horizontalPercentAlignmentValue(withSuperViewFrame: superViewFrame, targetViewFrame: targetViewFrame)
let verticalValue = verticalPercentAlignmentValue(withSuperViewFrame: superViewFrame, targetViewFrame: targetViewFrame)
