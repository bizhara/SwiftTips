//: Playground - noun: a place where people can play

import UIKit

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
