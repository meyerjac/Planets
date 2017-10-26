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
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let earthMoon = SCNNode(geometry: SCNSphere(radius: 0.05))
        
        earthMoon.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "moons")
        earthMoon.position = SCNVector3(0,0,-0.4)
        
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "sunDiffuse")
        sun.position = SCNVector3(0,0,-1)
        
        //create erth parents and place them where the sun is so as to set the child componetns poperly
        earthParent.position = SCNVector3(0, 0, -1)
        venusParent.position = SCNVector3(0, 0, -1)
        
        
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        let earthParentAction = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 14)
        let venusParentAction = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 10)
        
        let forever = SCNAction.repeatForever(action)
        let ForeverEarth = SCNAction.repeatForever(earthParentAction)
        let ForeverVenus = SCNAction.repeatForever(venusParentAction)
        
        sun.runAction(forever)
        earthParent.runAction(ForeverEarth)
        venusParent.runAction(ForeverVenus)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "earthDay"), specular: #imageLiteral(resourceName: "earthSpecular"), emission: #imageLiteral(resourceName: "earthEmission"), normal: #imageLiteral(resourceName: "earthNormal"), position: SCNVector3(1.2 ,0 , 0))
        
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "venusSurface"), specular: nil, emission: #imageLiteral(resourceName: "venusEmission"), normal: nil, position: SCNVector3(0.7, 0, 0))

        venus.runAction(ForeverVenus)
        earth.runAction(ForeverEarth)
        
        earthParent.addChildNode(earth)
        venusParent.addChildNode(venus)
        earth.addChildNode(earthMoon)
       
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

