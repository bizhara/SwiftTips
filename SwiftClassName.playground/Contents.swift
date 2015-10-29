//: Playground - noun: a place where people can play

import UIKit

class SwiftClassName : NSObject {
    class func classNameForClassFunction() {
        let className = String(self)
        print(className)
    }
    
    func classNameForFunction() {
        let className = String(self.dynamicType)
        print(className)
    }
}

SwiftClassName.classNameForClassFunction()
SwiftClassName().classNameForFunction()
