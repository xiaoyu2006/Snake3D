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
    static var gameY: Int = 5
    static var gameZ: Int = 8
    
    static var segXSize: Float = 0.05
    static var segYSize: Float = 0.05
    static var segZSize: Float = 0.05
    
    static var gapSize: Float = 0.01
    
    static var updateTime: Double = 0.5
}
