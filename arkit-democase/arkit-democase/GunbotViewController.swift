//
//  GunbotViewController.swift
//  arkit-democase
//
//  Created by Gehr Daniel, GHR-DEV-VOT-R2-CH2 on 15.08.17.
//  Copyright © 2017 Swisscom. All rights reserved.
//

import UIKit
import ARKit

class GunbotViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene(named: "art.scnassets/main.scn")!
        sceneView.scene = scene
        
        sceneView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
