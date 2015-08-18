//
//  ViewController.swift
//  CoreLocationDemo
//
//  Created by John Pitchko on 2015-Feb-04.
//  Copyright (c) 2015 Pitchko Technology. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
  
  @IBOutlet weak var speedLabel: UILabel!
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var longitudeLabel: UILabel!
  @IBOutlet weak var latitudeLabel: UILabel!
  
  var locationManager = CLLocationManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    longitudeLabel.text = "N/A"
    latitudeLabel.text = "N/A"
    speedLabel.text = "0.0000"
    locationManager.delegate = self
  }

  
  
  @IBAction func start(sender: AnyObject) {
    locationManager.requestWhenInUseAuthorization()
    
    NSLog("Starting location manager...")
    startButton.hidden = true
    stopButton.hidden = false
    
    //    Always receive new location data; do not wait to travel a set distance
    locationManager.distanceFilter = kCLDistanceFilterNone
    
    //    Request the best accuracy
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    
    locationManager.startUpdatingLocation()
    
//    NSLog("Location manager started? %@", locationManager.locationServicesEnabled() ? "YES" : "NO")
  }
  
  
  
  @IBAction func stop(sender: AnyObject) {
    NSLog("Stopping location manager...")
    startButton.hidden = false
    stopButton.hidden = true
    
    locationManager.stopUpdatingLocation()
  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension ViewController:CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    NSLog("Location update received!")
    let location = locations.last as CLLocation
    
    let longitude = location.coordinate.longitude as Double
    let latitude = location.coordinate.latitude
    let speed: Double = location.speed as Double
    
    longitudeLabel.text = String(format: "%f", longitude)
    latitudeLabel.text = String(format: "%f", latitude)
    speedLabel.text = String(format: "%f", speed)
    
    NSLog("Longitude: %f\tLatitude: %f\tSpeed: %f", longitude, latitude, speed)
  }
  
}