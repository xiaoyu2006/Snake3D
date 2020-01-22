//
//  Config.swift
//  Snake3D
//
//  Created by Nemo on 2020/1/22.
//  Copyright © 2020 Nemo. All rights reserved.
//

// Game configuration. Avoid "magic numbers"

import SceneKit

struct GameConfig {
    static var gameX: Int = 8
    static var gameY: Int = 5
    static var gameZ: Int = 8
    
    static var segXSize: CGFloat = 0.05
    static var segYSize: CGFloat = 0.05
    static var segZSize: CGFloat = 0.05
    
    static var gapSize: CGFloat = 0.01
}
