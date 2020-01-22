//
//  HeadNode.swift
//  Snake3D
//
//  Created by Nemo on 2020/1/22.
//  Copyright © 2020 Nemo. All rights reserved.
//

import UIKit
import SceneKit

class SegNode: SCNNode {
    init(position: SCNVector3, heading: Direction3D, color: UIColor) {
        super.init()
        
        var width = GameConfig.segXSize
        var height = GameConfig.segYSize
        var length = GameConfig.segZSize
        
        <#code#>
        
        let segmentBox = SCNBox(width: width, height: height, length: length, chamferRadius: 0)
        segmentBox.firstMaterial?.diffuse.contents = color
        
        self.geometry = segmentBox
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
