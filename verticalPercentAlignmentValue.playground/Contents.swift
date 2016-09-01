//: Playground - noun: a place where people can play

import UIKit

/// 画面サイズに合わせた相対位置を求める（center verticaly 指定でのパーセント値）
func verticalPercentAlignmentValue(with superViewFrame_: CGRect, targetViewFrame targetViewFrame_: CGRect) -> CGFloat {
  let baseHeight = superViewFrame_.size.height / 2
  let targetHeight = targetViewFrame_.size.height / 2
  let heightGap = baseHeight - targetHeight
  let yGap = heightGap - targetViewFrame_.origin.y
  let targetValue = baseHeight - yGap
  let percentValue = targetValue / baseHeight
  return percentValue
}

let superViewFrame = CGRect(x: 0, y: 0, width: 375, height: 667)
let targetViewFrame = CGRect(x: 25, y: 285, width: 325, height: 333)
let percentValue = verticalPercentAlignmentValue(with: superViewFrame, targetViewFrame: targetViewFrame)
