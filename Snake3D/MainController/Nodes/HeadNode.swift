//
//  HeadNode.swift
//  Snake3D
//
//  Created by Nemo on 2020/1/22.
//  Copyright © 2020 Nemo. All rights reserved.
//

/*
 SCNBox:
 width  - x - left    & right
 height - y - up      & down
 length - z - forward & backward
*/

import UIKit
import SceneKit

class SegNode: SCNNode {
    init(position: Vector3DInt, heading: Direction3D, color: UIColor) {
        super.init()
        
        var width = GameConfig.segXSize
        var height = GameConfig.segYSize
        var length = GameConfig.segZSize
        
        let gap = GameConfig.gapSize

        var pos = position.toSCNVector3() * SCNVector3(GameConfig.segXSize, GameConfig.segYSize, GameConfig.segZSize) + position.toSCNVector3() * Float(gap)

        switch heading {
        case .up:
            height += gap
            pos.y += gap/2
            break
        case .down:
            height += gap
            pos.y -= gap/2
            break
        case .left:
            width += gap
            pos.x += gap/2
            break
        case .right:
            width += gap
            pos.x -= gap/2
            break
        case .forward:
            length += gap
            pos.z += gap/2
            break
        case .backward:
            length += gap
            pos.z -= gap/2
            break
        }
        
        let segmentBox = SCNBox(width: width, height: height, length: length, chamferRadius: 0)
        segmentBox.firstMaterial?.diffuse.contents = color
        
        self.geometry = segmentBox
        self.position = pos
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
