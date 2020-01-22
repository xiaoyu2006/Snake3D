//
//  Helper.swift
//  Snake3D
//
//  Created by Nemo on 2020/1/22.
//  Copyright © 2020 Nemo. All rights reserved.
//

import SceneKit

extension SCNVector3 {
    static func +(first: SCNVector3, second: SCNVector3) -> SCNVector3 {
        return SCNVector3(first.x + second.x, first.y + second.y, first.z + second.z)
    }
    
    static func -(first: SCNVector3, second: SCNVector3) -> SCNVector3 {
        return SCNVector3(first.x - second.x, first.y - second.y, first.z - second.z)
    }
    
    static func *(first: SCNVector3, second: SCNVector3) -> SCNVector3 {
        return SCNVector3(first.x * second.x, first.y * second.y, first.z * second.z)
    }
    
    static func /(first: SCNVector3, second: SCNVector3) -> SCNVector3 {
        return SCNVector3(first.x / second.x, first.y / second.y, first.z / second.z)
    }
}
