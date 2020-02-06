//
//  Extension+SCNVector3.swift
//  Snake3D
//
//  Created by Yi Cao on 2020/1/22.
//  Copyright © 2020 Yi Cao. All rights reserved.
//

import SceneKit

// MARK: - SCNVector3
extension SCNVector3 {
    static func +(first: SCNVector3, second: SCNVector3) -> SCNVector3 {
        return SCNVector3(first.x + second.x, first.y + second.y, first.z + second.z)
    }
    
    static func +(first: SCNVector3, second: Float) -> SCNVector3 {
        return SCNVector3(first.x + second, first.y + second, first.z + second)
    }
    
    static func -(first: SCNVector3, second: SCNVector3) -> SCNVector3 {
        return SCNVector3(first.x - second.x, first.y - second.y, first.z - second.z)
    }
    
    static func -(first: SCNVector3, second: Float) -> SCNVector3 {
        return SCNVector3(first.x - second, first.y - second, first.z - second)
    }
    
    static func *(first: SCNVector3, second: SCNVector3) -> SCNVector3 {
        return SCNVector3(first.x * second.x, first.y * second.y, first.z * second.z)
    }
    
    static func *(first: SCNVector3, second: Float) -> SCNVector3 {
        return SCNVector3(first.x * second, first.y * second, first.z * second)
    }
    
    static func /(first: SCNVector3, second: SCNVector3) -> SCNVector3 {
        return SCNVector3(first.x / second.x, first.y / second.y, first.z / second.z)
    }
}
