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
import ARKit

class SegNode: SCNNode {
    init(position: Vector3DInt, heading: Direction3D?, color: UIColor, segName: String?, shrink: CGFloat = 0.0) {
        super.init()
        
        var width = GameConfig.segXSize
        var height = GameConfig.segYSize
        var length = GameConfig.segZSize
        
        let gap = GameConfig.gapSize

        var pos = position.toSCNVector3() * SCNVector3(GameConfig.segXSize, GameConfig.segYSize, GameConfig.segZSize) + position.toSCNVector3() * gap

        switch heading {
        case .up:
            height += gap
            pos.y -= gap / 2
        case .down:
            height += gap
            pos.y += gap / 2
        case .left:
            width += gap
            pos.x -= gap / 2
        case .right:
            width += gap
            pos.x += gap / 2
        case .forward:
            length += gap
            pos.z -= gap / 2
        case .backward:
            length += gap
            pos.z += gap / 2
        case .none:
            break
        }
        
        let segmentBox = SCNBox(width: CGFloat(width) - shrink, height: CGFloat(height) - shrink, length: CGFloat(length) - shrink, chamferRadius: 0.0)
        segmentBox.firstMaterial?.diffuse.contents = color
        
        self.geometry = segmentBox
        self.position = pos
        
        self.name = (segName ?? "SnakeSeg" + position.toString())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func placeAtPlane(plane: ARPlaneAnchor) -> Void {
        let center = plane.center
        let size = plane.extent
        self.position = self.position + SCNVector3(center.x - size.x / 2, center.y, center.z - size.z / 2)
    }
}
