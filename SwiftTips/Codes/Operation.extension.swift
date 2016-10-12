//
//  Operation.extension.swift
//
//  Created by hara on 2016/02/04.
//

import Foundation

extension Operation {
  // wantToExecute を画面更新系が終わった後に実行されるようにしたい
  // （画面更新系は優先度が高いようで、現状こちら側の優先度を調整しなくても所望の動作にはなっている）
  open func executeAfterBusyTime(wantToExecute wantToExecute_: @escaping (() -> Void)) {
    func executeByMainQueue() {
      DispatchQueue.main.async() {
        wantToExecute_()
      }
    }
    
    self.completionBlock = executeByMainQueue
    OperationQueue.main.addOperation(self)
  }
}
