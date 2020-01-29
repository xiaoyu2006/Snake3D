//
//  MainViewController.swift
//  Snake3D
//
//  Created by Nemo on 2020/1/20.
//  Copyright © 2020 Nemo. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class MainViewController: UIViewController {
    // MARK: - Properties
    var sceneView: ARSCNView!
    var plane: ARPlaneAnchor?
    
    var tipLabel: UIButton!
    var scoreLabel: UILabel!
    var gameOverLabel: UILabel!
    
    var updateCount: Int = 0
    var tapEnabled: Bool = false
    
    let stagex = GameConfig.gameX
    let stagey = GameConfig.gameY
    let stagez = GameConfig.gameZ
    
    let snake = Snake(stagex: GameConfig.gameX, stagey: GameConfig.gameY, stagez: GameConfig.gameZ)
    
    let musicPlayer = SoundPlayer()
    
    lazy var autoUpdate: Timer = {
        return Timer(timeInterval: GameConfig.updateTime, repeats: true) {_ in
            self.updateSnake()
        }
    }()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = ARSCNView(frame: self.view.frame)
        
        
        // Replace the default view
        self.view = sceneView
        
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Session delegate
        sceneView.session.delegate = self
        
        // Show a label
        self.tipLabel = UIButton(frame: self.view.frame)
        self.tipLabel.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.8)
        self.tipLabel.setTitle("Move your device around", for: .normal)
        self.tipLabel.tintColor = UIColor.yellow
        self.tipLabel.addTarget(self, action: #selector(self.tipLabelTouchUpInside), for: .touchUpInside)
        self.view.addSubview(self.tipLabel)
        
        self.tapEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Run the view's session
        self.resetTracking()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.isLightEstimationEnabled = true
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    @objc func tipLabelTouchUpInside() {
        if self.tapEnabled {
            self.tapEnabled = false
            self.tipLabel.removeFromSuperview()
            
            self.setupGame()
            
            sceneView.debugOptions = []
        }
    }
    
}
