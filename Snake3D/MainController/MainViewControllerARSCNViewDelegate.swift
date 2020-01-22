//
//  MainViewControllerARSCNViewDelegate.swift
//  Snake3D
//
//  Created by Nemo on 2020/1/22.
//  Copyright © 2020 Nemo. All rights reserved.
//

import ARKit


// MARK: - ARSCNViewDelegate
extension MainViewController: ARSCNViewDelegate {
    func createPlaneNode(center: vector_float3, extent: vector_float3) -> SCNNode {
        let plane = SCNPlane(width: CGFloat(extent.x), height: CGFloat(extent.z))
        
        let planeMaterial = SCNMaterial()
        planeMaterial.diffuse.contents = UIColor.yellow.withAlphaComponent(0.4)
        plane.materials = [planeMaterial]
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3Make(center.x, 0, center.z)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        
        return planeNode
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if self.tapEnabled { return }

        if let planeAnchor = anchor as? ARPlaneAnchor, node.childNodes.count < 1, self.updateCount < 1 {
            // Show debug plane
            let debugPlaneNode = createPlaneNode(center: planeAnchor.center, extent: planeAnchor.extent)
            debugPlaneNode.name = "debugPlaneNode"
            
            node.addChildNode(debugPlaneNode)
            
            // Change the title
            DispatchQueue.main.async {
                self.tipLabel.setTitle("Tap to start", for: .normal)
            }
            
            self.tapEnabled = true
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, let planeNode = node.childNodes.first, let plane = planeNode.geometry as? SCNPlane else {
            return
        }
        
        updateCount += 1
        
        plane.width = CGFloat(planeAnchor.extent.x)
        plane.height = CGFloat(planeAnchor.extent.z)
    }
}
