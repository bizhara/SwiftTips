//: Playground - noun: a place where people can play

import UIKit

func verticalPercentAlignmentValueWith(superViewFrame superViewFrame_: CGRect, targetViewFrame targetViewFrame_: CGRect) -> CGFloat {
  let baseHeight = superViewFrame_.size.height / 2
  let targetHeight = targetViewFrame_.size.height / 2
  let heightGap = baseHeight - targetHeight
  let yGap = heightGap - targetViewFrame_.origin.y
  let targetValue = baseHeight - yGap
  let percentValue = targetValue / baseHeight
  return percentValue
}

let superViewFrame = CGRect(x: 0, y: 0, width: 375, height: 667)
let targetViewFrame = CGRect(x: 148, y: 561, width: 79, height: 46)
let percentValue = verticalPercentAlignmentValueWith(superViewFrame: superViewFrame, targetViewFrame: targetViewFrame)


class SwiftSingletonWithParameters: NSObject {
    private static let myInstance = SwiftSingletonWithParameters()
    
    private var name: String!
    private var city: String!
    
    private override init() {
        super.init()
    }
    
    class func sharedInstance(name name_: String, city city_: String) -> SwiftSingletonWithParameters {
        myInstance.name = name_
        myInstance.city = city_
        return myInstance
    }
    
    func printVars() {
        print("name: " + self.name + ", " + "city: " + self.city)
    }
}

SwiftSingletonWithParameters.sharedInstance(name: "ichiro", city: "roppongi").printVars()
