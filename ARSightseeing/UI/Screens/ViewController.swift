//
//  ViewController.swift
//  ARSightseeing
//
//  Created by Dmytro Romaniuk on 7/3/18.
//  Copyright © 2018 rodmytro. All rights reserved.
//

import UIKit
import ARCL
import CoreLocation
import SceneKit
import MIBlurPopup

class ViewController: UIViewController {

    private var sceneLocationView = SceneLocationView()
    
    private var currentLocation: CLLocation? {
        return sceneLocationView.sceneLocationManager.currentLocation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneLocationView.run()
        
        view.addSubview(sceneLocationView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addAllPoints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }
    
    // MARK: DRAWING
    private func addAllPoints() {
        let objects = LocationFactory.build()
        for object in objects {
            addPoint(from: object)
        }
    }
    
    private func addPoint(from object: LocationObject) {
        let coordinates = CLLocationCoordinate2D(latitude: object.latitude, longitude: object.longitude)
        let location = CLLocation(coordinate: coordinates, altitude: object.altitude)
        
        var distanceText = ""
        if let currentLocation = currentLocation {
            let distance = location.distance(from: currentLocation)
            distanceText = "\(distance) m"
        }
        
        let landmarkNode = LandmarkNode(location: location, title: object.name, distance: distanceText, image: object.image)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: landmarkNode)
    }
    
    // TODO: add animation on click for example
    private func animatePoint(_ node: SCNNode) {
        let action = SCNAction.rotateBy(x: 0, y: 0, z: 10, duration: 1)
        node.runAction(action)
    }
    
    
    // MARK: LOCATION
    private func setupLocationListener() {
        sceneLocationView.locationViewDelegate = self
    }
    
    // MARK: TOUCHES
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first {
            if touch.view != nil {
                let sceneView = self.sceneLocationView
                let location = touch.location(in: sceneView)
                let hitTest = sceneView.hitTest(location)
                
                if (!hitTest.isEmpty) {
                    let results = hitTest.first!
                    let currentNode = results.node
                    if let locationNode = getLocationNode(node: currentNode) {
                        print("clicked on node \(locationNode.title)")
                        
                        if let currentLocation = currentLocation {
                            let distance = locationNode.location.distance(from: currentLocation)
                            print("distance: \(distance)")
                        }
                        
                        performSegue(withIdentifier: "showPopup", sender: self)
                    }
                }
            }
        }
    }
    
    func getLocationNode(node: SCNNode) -> LandmarkNode? {
        if node.isKind(of: LocationNode.self) {
            return node as? LandmarkNode
        } else if let parentNode = node.parent {
            return getLocationNode(node: parentNode)
        }
        return nil
    }
    
}
