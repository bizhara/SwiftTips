//
//  NSOperation.extension.swift
//
//  Created by hara on 2016/02/04.
//

import Foundation

extension NSOperation {
  // wantToExecute を画面更新系が終わった後に実行されるようにしたい
  // （画面更新系は優先度が高いようで、現状こちら側の優先度を調整しなくても所望の動作にはなっている）
  func executeAfterBusyTime(wantToExecute wantToExecute_: (() -> Void)) {
    func executeByMainQueue() {
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        wantToExecute_()
      })
    }
    
    self.completionBlock = executeByMainQueue
    NSOperationQueue.mainQueue().addOperation(self)
  }
}
