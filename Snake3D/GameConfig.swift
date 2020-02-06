//
//  GameConfig.swift
//  Snake3D
//
//  Created by Nemo on 2020/1/22.
//  Copyright © 2020 Nemo. All rights reserved.
//

// Game configuration. Avoid "magic numbers"

struct GameConfig {
    static var gameX: Int = 8
    static var gameY: Int = 3
    static var gameZ: Int = 4
    
    static var segXSize: Float = 0.03
    static var segYSize: Float = 0.03
    static var segZSize: Float = 0.03
    
    static var updateTime: Double = 0.8
}
