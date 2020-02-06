//
//  HeadNode.swift
//  Snake3D
//
//  Created by Yi Cao on 2020/1/22.
//  Copyright © 2020 Yi Cao. All rights reserved.
//

/*
 SCNBox:
 width  - x - left    & right
 height - y - up      & down
 length - z - forward & backward
*/

import UIKit
import SceneKit
import ARKit


class SegNode: SCNNode {
    init(position: Vector3DInt, heading: Direction3D?, color: UIColor, segName: String?) {
        super.init()
        
        let width = GameConfig.segXSize
        let height = GameConfig.segYSize
        let length = GameConfig.segZSize
        
        let segmentBox = SCNBox(width: CGFloat(width), height: CGFloat(height), length: CGFloat(length), chamferRadius: 0.0)
        segmentBox.firstMaterial?.diffuse.contents = color
        
        self.geometry = segmentBox
        self.position = position.toSCNVector3() * SCNVector3(GameConfig.segXSize, GameConfig.segYSize, GameConfig.segZSize)
        
        self.name = (segName ?? "SnakeSeg" + position.toString())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func placeAt(width aWidth: Float, position: SCNVector3) {
        // Fine tune
        self.position.x -= aWidth / 2
        self.position.y += 0.02
        self.position.z = -self.position.z
        
        // Place @ plane
        self.position = self.position+position
    }
}
