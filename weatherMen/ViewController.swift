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
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    
    var lat: String!
    var lon: String!
    var holder: String? {
        didSet {
            todaysWeather.dynamicEndPoint = holder!
            todaysWeather.downloadWeather { () -> () in
                self.updateUI()
            }
            
        }
    }
    
    var todaysWeather = Weather()
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
    
    func updateUI() {
        weatherLbl.text = todaysWeather.desc
        windLbl.text = todaysWeather.windSpeed
        tempLbl.text = todaysWeather.temp
    }

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let lat = locValue.latitude
        let lon = locValue.longitude
        let url = "\(BASE_URL)lat=\(lat)&lon=\(lon)\(APPID)"
        holder = url
    }
}

