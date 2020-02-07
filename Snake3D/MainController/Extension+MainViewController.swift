//
//  MainViewControllerARSessionDelegate.swift
//  Snake3D
//
//  Created by Yi Cao on 2020/1/22.
//  Copyright © 2020 Yi Cao. All rights reserved.
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
    func visualizePlane(node: SCNNode, anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        plane.materials.first?.diffuse.contents = UIColor.yellow.withAlphaComponent(0.5)
        
        let planeNode = SCNNode(geometry: plane)
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        node.addChildNode(planeNode)
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        self.startBtnCanBeTouched = true
        DispatchQueue.main.async {
            self.startBtn.setTitle("Face 2 a plane & Tap to start!", for: .normal)
        }
        self.visualizePlane(node: node, anchor: anchor)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as?  ARPlaneAnchor, let planeNode = node.childNodes.first, let plane = planeNode.geometry as? SCNPlane else { return }

        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height

        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
}

// MARK: - Interactive

extension MainViewController {
    func setupInteractive() {
        let STEP: CGFloat = 100
        
        let btnUP = UIButton(frame: getFrame4ControlBtn2(STEP, STEP*3))
        btnUP.setTitle("UP", for: .normal)
        btnUP.addTarget(self, action: #selector(self.UP), for: .touchUpInside)
        btnUP.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(btnUP)
        
        let btnDOWN = UIButton(frame: getFrame4ControlBtn2(STEP, STEP*2))
        btnDOWN.setTitle("DOWN", for: .normal)
        btnDOWN.addTarget(self, action: #selector(self.DOWN), for: .touchUpInside)
        btnDOWN.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(btnDOWN)
        
        let btnLEFT = UIButton(frame: getFrame4ControlBtn1(STEP*3, STEP*2))
        btnLEFT.setTitle("LEFT", for: .normal)
        btnLEFT.addTarget(self, action: #selector(self.LEFT), for: .touchUpInside)
        btnLEFT.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(btnLEFT)
        
        let btnRIGHT = UIButton(frame: getFrame4ControlBtn1(STEP, STEP*2))
        btnRIGHT.setTitle("RIGHT", for: .normal)
        btnRIGHT.addTarget(self, action: #selector(self.RIGHT), for: .touchUpInside)
        btnRIGHT.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(btnRIGHT)
        
        let btnFRONT = UIButton(frame: getFrame4ControlBtn1(STEP*2, STEP*3))
        btnFRONT.setTitle("FORWARD", for: .normal)
        btnFRONT.addTarget(self, action: #selector(self.FORWARD), for: .touchUpInside)
        btnFRONT.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(btnFRONT)
        
        let btnBACK = UIButton(frame: getFrame4ControlBtn1(STEP*2, STEP))
        btnBACK.setTitle("BACKWARD", for: .normal)
        btnBACK.addTarget(self, action: #selector(self.BACKWARD), for: .touchUpInside)
        btnBACK.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(btnBACK)
    }
    
    func getFrame4ControlBtn1(_ negX: CGFloat, _ negY: CGFloat) -> CGRect {
        let superFrame = self.view.frame
        let result = CGRect(x: superFrame.maxX - negX, y: superFrame.maxY - negY, width: 100.0, height: 75.0)
        return result
    }
    
    func getFrame4ControlBtn2(_ x: CGFloat, _ negY: CGFloat) -> CGRect {
        let superFrame = self.view.frame
        let result = CGRect(x: x, y: superFrame.maxY - negY, width: 100.0, height: 75.0)
        return result
    }
    
    @objc func UP() {
        snake.setHeading(heading: .up)
    }
    
    @objc func DOWN() {
        snake.setHeading(heading: .down)
    }
    
    @objc func LEFT() {
        snake.setHeading(heading: .left)
    }
    
    @objc func RIGHT() {
        snake.setHeading(heading: .right)
    }
    
    @objc func FORWARD() {
        snake.setHeading(heading: .backward)
    }
    
    @objc func BACKWARD() {
        snake.setHeading(heading: .forward)
    }
}


// MARK: - Game main controller
extension MainViewController {
    func setupGame() {
        DispatchQueue.main.async {
            self.setupInteractive()
        }
        
        self.scoreLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        for x in 0..<self.stagex {
            for y in 0..<self.stagey {
                for z in 0..<self.stagez {
                    let gridNode = SegNode(position: Vector3DInt(x: x, y: y, z: z), heading: nil, color: UIColor.black, segName: "gridCube")
                    gridNode.geometry?.firstMaterial?.fillMode = .lines
                    gridNode.placeAt(width: self.aWidth, position: self.planePosition)
                    self.sceneView.scene.rootNode.addChildNode(gridNode)
                }
            }
        }
        self.setupTips()
        
        DispatchQueue.main.async {
            self.view.addSubview(self.scoreLabel)
            self.scoreLabel.textColor = UIColor.blue
            self.scoreLabel.text = "Scores: \(self.snake.getScore())"
            RunLoop.main.add(self.autoUpdate, forMode: RunLoop.Mode.common)
        }
        
        let segments = self.snake.getSnake()
        for seg in segments {
            let segNode = SegNode(position: seg.pos, heading: seg.dir, color: UIColor.yellow, segName: nil)
            segNode.placeAt(width: self.aWidth, position: self.planePosition)
            self.sceneView.scene.rootNode.addChildNode(segNode)
        }
        let apple = self.snake.getApple()
        let appleNode = SegNode(position: apple, heading: nil, color: UIColor.red, segName: "Apple")
        appleNode.placeAt(width: self.aWidth, position: self.planePosition)
        self.sceneView.scene.rootNode.addChildNode(appleNode)
    }
    
    func setupTips() {
        func setupText(at pos: SCNVector3, text: String, color: UIColor = UIColor.white, font: UIFont = UIFont.systemFont(ofSize: 1)) {
            let textObj = SCNText(string: text, extrusionDepth: 0.01)
            textObj.font = font
            textObj.materials.first?.diffuse.contents = color
            let textNode = SCNNode(geometry: textObj)
            textNode.position = pos
            textNode.name = text
            textNode.scale = SCNVector3(0.03, 0.03, 0.03)
            textNode.placeAt(width: aWidth, position: self.planePosition)
            self.sceneView.scene.rootNode.addChildNode(textNode)
        }
        setupText(at: SCNVector3(aXDiv2, -0.1, aZDiv2), text: "Down")
        setupText(at: SCNVector3(aXDiv2, aY, aZDiv2), text: "Up")
        setupText(at: SCNVector3(aXDiv2, aYDiv2,  -0.1), text: "Backward")
        setupText(at: SCNVector3(aXDiv2, aYDiv2, aZ), text: "Forward")
        setupText(at: SCNVector3(-0.1, aYDiv2, aZDiv2), text: "Left")
        setupText(at: SCNVector3(aX, aYDiv2, aZDiv2), text: "Right")
    }
    
    func updateSnake() {
        let updateInfo = self.snake.update()
        if let updated = updateInfo {
            let appended = updated.append
            let newSnakeNode = SegNode(position: appended.pos, heading: appended.dir, color: UIColor.yellow, segName: nil)
            newSnakeNode.placeAt(width: self.aWidth, position: self.planePosition)
            self.sceneView.scene.rootNode.addChildNode(newSnakeNode)
            if let deleted = updated.delete {
                self.sceneView.scene.rootNode.childNode(withName: "SnakeSeg" + deleted.pos.toString(), recursively: true)!.removeFromParentNode()
            } else {
                // Got one apple
                self.sceneView.scene.rootNode.childNode(withName: "Apple", recursively: true)!.removeFromParentNode()
                let apple = self.snake.getApple()
                let appleNode = SegNode(position: apple, heading: nil, color: UIColor.red, segName: "Apple")
                appleNode.placeAt(width: self.aWidth, position: self.planePosition)
                self.sceneView.scene.rootNode.addChildNode(appleNode)
                DispatchQueue.main.async {
                    self.scoreLabel.text = "Scores: \(self.snake.getScore())"
                }
                self.musicPlayer.playOneUp()
            }
        } else {
            self.gameOver()
        }
    }
    
    func gameOver() {
        self.autoUpdate.invalidate()
        self.scoreLabel.removeFromSuperview()
        self.gameOverLabel = UILabel(frame: self.view.frame)
        self.gameOverLabel.textAlignment = .center
        self.gameOverLabel.adjustsFontSizeToFitWidth = true
        
        self.gameOverLabel.text = "You failed! Your final score is \(self.snake.getScore())."
        self.gameOverLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.addSubview(self.gameOverLabel)
        
        self.musicPlayer.gameOver()
    }
}
