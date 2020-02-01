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

// MARK: - Important part

extension MainViewController {
    func setupGame() {
        self.musicPlayer.playBGM()
        self.scoreLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 20))
        DispatchQueue.main.async {
            self.view.addSubview(self.scoreLabel)
            self.scoreLabel.textColor = UIColor.blue
            self.scoreLabel.text = "Scores: \(self.snake.getScore())"
            RunLoop.main.add(self.autoUpdate, forMode: RunLoop.Mode.common)
        }
        for x in 0..<self.stagex {
            for y in 0..<self.stagey {
                for z in 0..<self.stagez {
                    let newNode = SegNode(position: Vector3DInt(x: x, y: y, z: z), heading: nil, color: UIColor.green.withAlphaComponent(0.3), segName: "gridCube", shrink: CGFloat(GameConfig.segShrinkSize))
                    newNode.placeInFrontOfOrigin(aWidth: self.estAWidth)
                    self.sceneView.scene.rootNode.addChildNode(newNode)
                }
            }
        }
        let segments = self.snake.getSnake()
        for seg in segments {
            let segNode = SegNode(position: seg.pos, heading: seg.dir, color: UIColor.yellow, segName: nil)
            segNode.placeInFrontOfOrigin(aWidth: self.estAWidth)
            self.sceneView.scene.rootNode.addChildNode(segNode)
        }
        let apple = self.snake.getApple()
        let appleNode = SegNode(position: apple, heading: nil, color: UIColor.red, segName: "Apple", shrink: CGFloat(-GameConfig.segShrinkSize))
        appleNode.placeInFrontOfOrigin(aWidth: self.estAWidth)
        self.sceneView.scene.rootNode.addChildNode(appleNode)
    }
    
    func updateSnake() {
        let updateInfo = self.snake.update()
        if let updated = updateInfo {
            let appended = updated.append
            let newSnakeNode = SegNode(position: appended.pos, heading: appended.dir, color: UIColor.yellow, segName: nil)
            newSnakeNode.placeInFrontOfOrigin(aWidth: self.estAWidth)
            self.sceneView.scene.rootNode.addChildNode(newSnakeNode)
            if let deleted = updated.delete {
                self.sceneView.scene.rootNode.childNode(withName: "SnakeSeg" + deleted.pos.toString(), recursively: true)!.removeFromParentNode()
            } else {
                // Got one apple
                self.sceneView.scene.rootNode.childNode(withName: "Apple", recursively: true)!.removeFromParentNode()
                let apple = self.snake.getApple()
                let appleNode = SegNode(position: apple, heading: nil, color: UIColor.red, segName: "Apple", shrink: CGFloat(-GameConfig.segShrinkSize))
                appleNode.placeInFrontOfOrigin(aWidth: self.estAWidth)
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
        
        self.gameOverLabel.text = "You failed! Your final score is \(self.snake.getScore() - 1)"
        self.gameOverLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.addSubview(self.gameOverLabel)
        
        self.musicPlayer.gameOver()
    }
}
