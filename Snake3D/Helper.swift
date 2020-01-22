//
//  Helper.swift
//  Snake3D
//
//  Created by Nemo on 2020/1/22.
//  Copyright © 2020 Nemo. All rights reserved.
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


// MARK: - Float & CGFloat
func +(first: CGFloat, second: Float) -> Float {
    return Float(first) + second
}

func +(first: CGFloat, second: Float) -> CGFloat {
    return first + CGFloat(second)
}

func -(first: CGFloat, second: Float) -> Float {
    return Float(first) - second
}

func -(first: CGFloat, second: Float) -> CGFloat {
    return first - CGFloat(second)
}

func *(first: CGFloat, second: Float) -> Float {
    return Float(first) * second
}

func *(first: CGFloat, second: Float) -> CGFloat {
    return first * CGFloat(second)
}

func /(first: CGFloat, second: Float) -> Float {
    return Float(first) / second
}

func /(first: CGFloat, second: Float) -> CGFloat {
    return first / CGFloat(second)
}
