//
//  RecoverRoundCornerShapeItems.swift
//
//  Created by khara on 2016/08/05.
//

import UIKit

/// Constraint 設定した UIView.circleShape アイテムが非表示になってしまう不具合修正目的
protocol RecoverRoundCornerShapeItemsProtocol {
  // var recoverItems: [UIView] { get set } （下記 extension 参照）
  func recoverRoundCornerShapeItemsWith(items items_: [UIView])
}

/// Constraint 設定した UIView.circleShape アイテムが非表示になってしまう不具合修正共通実装
extension RecoverRoundCornerShapeItemsProtocol {
  // 本来ならここで var recoverItems: [UIView]! と書いて必要アイテムの保持もカバーしたいが、
  // extension では stored property が使えないので、これを取り込むクラス側で用意してもらい、引数としてもらうようにする
  /// override した viewDidLayoutSubviews の最後で呼ぶ
  func recoverRoundCornerShapeItemsWith(items items_: [UIView]) {
    for recoverItem in items_ {
      recoverItem.layoutIfNeeded()
      recoverItem.circleShape()
    }
  }
}
