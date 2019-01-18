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
    var listPockemon = [Pockemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadPockemons()
        
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
        self.mapView.clear()
        
        //mylocation
        let markerMe = GMSMarker()
        markerMe.position = CLLocationCoordinate2D(latitude: oldLocation.latitude, longitude: oldLocation.longitude )
        markerMe.title = "Me"
        markerMe.snippet = "Here is my location"
        markerMe.icon = UIImage(named:"mario")
        markerMe.map = self.mapView
        
        for pockemon in listPockemon{
            let markerPockemon = GMSMarker()
            markerPockemon.position = CLLocationCoordinate2D(latitude: pockemon.latitude!, longitude: pockemon.longitude! )
            markerPockemon.title = pockemon.name!
            markerPockemon.snippet = "\(pockemon.des!), power \(pockemon.power!)"
            markerPockemon.icon = UIImage(named:pockemon.image!)
            markerPockemon.map = self.mapView
        }
        
        
        let camera = GMSCameraPosition.camera(withLatitude: oldLocation.latitude, longitude: oldLocation.longitude, zoom: 15)
        self.mapView.camera = camera

        
    }
    
    func LoadPockemons(){
        self.listPockemon.append(Pockemon(latitude: 37.7789994893035, longitude: -122.401846647263, image: "charmander", name: "Charmander", des: "Fire pockemon", power: 55))
        self.listPockemon.append(Pockemon(latitude: 37.7949994893035, longitude: -122.410446647263, image: "bulbasaur", name: "Bulbasaur", des: "Nature pockemon", power: 90))
        self.listPockemon.append(Pockemon(latitude: 37.7816994893035, longitude: -122.412246647263, image: "squirtle", name: "Squirtle", des: "Water pockemon", power: 33))
    }

}

