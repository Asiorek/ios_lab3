//
//  ViewController.swift
//  lab3
//
//  Created by Użytkownik Gość on 27.10.2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    @IBOutlet weak var buttonClear: UIButton!
    
    var myLocationManager: CLLocationManager!
    
    @IBAction func buttonStartClicked(sender: AnyObject) {
        buttonStart.enabled = false
        buttonStop.enabled = true
        myLocationManager.startUpdatingLocation()
        mapview.showsUserLocation = true
    }
    
    @IBAction func buttonStopClicked(sender: AnyObject) {
        buttonStop.enabled = false
        buttonStart.enabled = true
        myLocationManager.stopUpdatingLocation()
        mapview.showsUserLocation = false
    }
    
    @IBAction func buttonClearClicked(sender: AnyObject) {
        mapview.removeAnnotations(mapview.annotations)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            myLocationManager = CLLocationManager()
            myLocationManager.delegate = self
            myLocationManager.requestWhenInUseAuthorization()
        }
        
        buttonStop.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last?.coordinate
        
        print(currentLocation)
        
        var spanDelta = 0.0
        
        if let speed = locations.last?.speed where speed > 0 {
            spanDelta = speed / 5000
        }
        
        let locationArea = MKCoordinateRegion(center: currentLocation!, span: MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta))
        
        mapview.setRegion(locationArea, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = currentLocation!
        mapview.addAnnotation(pin)
        
    }
}

