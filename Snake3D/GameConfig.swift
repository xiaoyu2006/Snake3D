//
//  GameConfig.swift
//  Snake3D
//
//  Created by Yi Cao on 2020/1/22.
//  Copyright © 2020 Yi Cao. All rights reserved.
//

// Game configuration. Avoid "magic numbers"

struct GameConfig {
    static var gameX: Int = 8
    static var gameY: Int = 4
    static var gameZ: Int = 6
    
    static var segXSize: Float = 0.05
    static var segYSize: Float = 0.05
    static var segZSize: Float = 0.05
    
    static var updateTime: Double = 0.8
}
