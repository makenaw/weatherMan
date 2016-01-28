//
//  ViewController.swift
//  weatherMen
//
//  Created by makena  on 1/28/16.
//  Copyright © 2016 makena . All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {
    
//    1. get user location using CLLocationManager
//    2. use latitude and longitude to pull down data from weather api with alamofire
//    2a. refactor weather into a 'weather' class?
//    3. parse json
//    4. reflect weather in UI
    
    var lat: String!
    var lon: String!

    var _dynamicEndPoint = ""

    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
    
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let lat = locValue.latitude
        let lon = locValue.longitude
        let dynamic = "\(BASE_URL)lat=\(lat)&lon=\(lon)\(APPID)"
        _dynamicEndPoint = dynamic
    }
    
    override func viewWillAppear(animated: Bool) {
        print("\(_dynamicEndPoint)")
        downloadWeather()
    }
    
    func downloadWeather() {

        let url = NSURL(string: _dynamicEndPoint)
        Alamofire.request(.GET, url!).responseJSON { response in
           let result = response.result
            print(result.value.debugDescription)
       
            }
    }
}

