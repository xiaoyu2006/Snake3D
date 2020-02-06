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
    
    var startBtn: UIButton!
    var scoreLabel: UILabel!
    var gameOverLabel: UILabel!
    
    var startBtnCanBeTouched: Bool = false
    
    var planePosition: SCNVector3!
    
    let stagex = GameConfig.gameX
    let stagey = GameConfig.gameY
    let stagez = GameConfig.gameZ
    
    let estAWidth = Float(GameConfig.gameX) * GameConfig.segXSize
    
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
        
        self.startBtnCanBeTouched = false
        
        sceneView = ARSCNView(frame: self.view.frame)
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        // Replace the default view
        self.view = sceneView
        
        // View delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Session delegate
        sceneView.session.delegate = self
        
        // Show a button
        self.startBtn = UIButton(frame: self.view.frame)
        self.startBtn.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.startBtn.setTitle("Move your device around.", for: .normal)
        self.startBtn.tintColor = UIColor.yellow
        self.startBtn.addTarget(self, action: #selector(self.tipLabelTouchUpInside), for: .touchUpInside)
        self.view.addSubview(self.startBtn)
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
        configuration.planeDetection = .horizontal
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    @objc func tipLabelTouchUpInside() {
        if !self.startBtnCanBeTouched { return }
        
        let hitTestResults = sceneView.hitTest(CGPoint(x: self.view.frame.maxX / 2, y: self.view.frame.maxY / 2), types: .existingPlaneUsingExtent)
        guard let hitTestResult = hitTestResults.first else { return }
        let transform = hitTestResult.worldTransform.columns
        self.planePosition = SCNVector3(CGFloat(transform.3.x), CGFloat(transform.3.y), CGFloat(transform.3.z))
        
        self.startBtn.removeFromSuperview()
        
        self.setupGame()
        
        sceneView.debugOptions = []
    }
    
}
