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
    @IBOutlet var sceneView: ARSCNView!
    
    var tipLabel: UIButton!
    
    var updateCount: Int = 0
    var tapEnabled: Bool = false
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
            let mainScn = SCNScene(named: "art.scnassets/main.scn")!
            self.sceneView.scene.rootNode.addChildNode(mainScn.rootNode)
            
            sceneView.debugOptions = []
        }
    }
    
}
