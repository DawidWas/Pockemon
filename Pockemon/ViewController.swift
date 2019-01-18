//
//  ViewController.swift
//  Pockemon
//
//  Created by Dawid Was on 18/01/2019.
//  Copyright © 2019 Dawid Was. All rights reserved.
//

import UIKit
import GoogleMaps
class ViewController: UIViewController, CLLocationManagerDelegate {

    var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 43, longitude: -77, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView

        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        }
        
        
    }
    var oldLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        oldLocation = manager.location!.coordinate
        
        let markerMe = GMSMarker()
        markerMe.position = CLLocationCoordinate2D(latitude: oldLocation.latitude, longitude: oldLocation.longitude )
        markerMe.title = "Me"
        markerMe.snippet = "Here is my location"
        markerMe.icon = UIImage(named:"mario")
        markerMe.map = self.mapView
        
        
    }

}

