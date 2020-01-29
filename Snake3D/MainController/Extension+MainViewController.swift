//
//  MainViewControllerARSessionDelegate.swift
//  Snake3D
//
//  Created by Nemo on 2020/1/22.
//  Copyright © 2020 Nemo. All rights reserved.
//

import ARKit

// MARK: - ARSessionDelegate
extension MainViewController: ARSessionDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Exit", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        fatalError(error.localizedDescription)
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        self.sceneView.session.pause()
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        self.resetTracking()
    }
}

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
            // Record it
            self.plane = planeAnchor
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

extension MainViewController {
    func setupGame() {
        DispatchQueue.main.async {
            RunLoop.main.add(self.autoUpdate, forMode: RunLoop.Mode.common)
        }
        for x in 0..<self.stagex {
            for y in 0..<self.stagey {
                for z in 0..<self.stagez {
                    let newNode = SegNode(position: Vector3DInt(x: x, y: y, z: z), heading: nil, color: UIColor.yellow.withAlphaComponent(0.5), segName: "gridCube", shrink: CGFloat(GameConfig.segShrinkSize))
                    newNode.placeAtPlane(plane: self.plane!)
                    self.sceneView.scene.rootNode.addChildNode(newNode)
                }
            }
        }
        let segments = self.snake.getSnake()
        for seg in segments {
            let segNode = SegNode(position: seg.pos, heading: seg.dir, color: UIColor.yellow, segName: nil)
            segNode.placeAtPlane(plane: self.plane!)
            self.sceneView.scene.rootNode.addChildNode(segNode)
        }
        let apple = self.snake.getApple()
        let appleNode = SegNode(position: apple, heading: nil, color: UIColor.red, segName: "Apple", shrink: CGFloat(-GameConfig.segShrinkSize))
        appleNode.placeAtPlane(plane: self.plane!)
        self.sceneView.scene.rootNode.addChildNode(appleNode)
    }
    
    func updateSnake() {
        let updateInfo = self.snake.update()
        if let updated = updateInfo {
            let appended = updated.append
            let newSnakeNode = SegNode(position: appended.pos, heading: appended.dir, color: UIColor.yellow, segName: nil)
            newSnakeNode.placeAtPlane(plane: self.plane!)
            self.sceneView.scene.rootNode.addChildNode(newSnakeNode)
            if let deleted = updated.delete {
                self.sceneView.scene.rootNode.childNode(withName: "SnakeSeg" + deleted.pos.toString(), recursively: true)!.removeFromParentNode()
            } else {
                self.sceneView.scene.rootNode.childNode(withName: "Apple", recursively: true)!.removeFromParentNode()
                let apple = self.snake.getApple()
                let appleNode = SegNode(position: apple, heading: nil, color: UIColor.red, segName: "Apple", shrink: CGFloat(-GameConfig.segShrinkSize))
                appleNode.placeAtPlane(plane: self.plane!)
                self.sceneView.scene.rootNode.addChildNode(appleNode)
            }
        } else {
            self.gameOver()
        }
    }
    
    func gameOver() {
        self.autoUpdate.invalidate()
        fatalError("GAMEOVER")
    }
    
    // TODO: INTERACTIVE
}
