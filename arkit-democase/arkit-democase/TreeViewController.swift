//
//  ViewController.swift
//  arkit-democase
//
//  Created by Gehr Daniel, GHR-DEV-VOT-R2-CH2 on 14.08.17.
//  Copyright © 2017 Swisscom. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class TreeViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var treeNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/Lowpoly_tree_sample.dae")!
        treeNode = scene.rootNode.childNode(withName: "Tree_lp_11", recursively: true)
        treeNode?.position = SCNVector3Make(0, 0, -1)
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchLocation = touches.first?.location(in: sceneView) {
            // Perform hit-test against all objects in the scene
            if let hit = sceneView.hitTest(touchLocation, options: nil).first {
                
                // Remove the node
                hit.node.removeFromParentNode()
                return;
            }
        }
        
        guard let touch = touches.first else { return }
        let results = sceneView.hitTest(touch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitFeature = results.last else { return }
        let hitTransform = SCNMatrix4(hitFeature.worldTransform)
        let hitPosition = SCNVector3Make(hitTransform.m41,
                                         hitTransform.m42,
                                         hitTransform.m43)
        let treeClone = treeNode!.clone()
        treeClone.position = hitPosition
        
        /*
        // Create a LookAt constraint, point at the cameras POV
        let constraint = SCNLookAtConstraint(target: sceneView.pointOfView)
        
        // Keep the rotation on the horizon
        constraint.isGimbalLockEnabled = true
        
        // Slow the constraint down a bit
        constraint.influenceFactor = 0.01
        
        // Finally add the constraint to the node
        treeClone.constraints = [constraint] 
         */
 
        sceneView.scene.rootNode.addChildNode(treeClone)
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
