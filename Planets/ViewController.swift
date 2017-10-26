//
//  ViewController.swift
//  Planets
//
//  Created by jackson Meyer on 10/25/17.
//  Copyright © 2017 jackson Meyer. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        
        self.sceneView.session.run(configuration)
        self.sceneView.automaticallyUpdatesLighting = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: 0.05)
        earth.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "earthDay")
        earth.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "earthSpecular")
        earth.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "earthEmission")
        earth.position = SCNVector3(0,0,-1.0)
        self.sceneView.scene.rootNode.addChildNode(earth)
        
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        let forever = SCNAction.repeatForever(action)
        earth.runAction(forever)
     
    }

}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

