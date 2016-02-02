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
                print(self.todaysWeather.dynamicEndPoint)
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
        windLbl.text = "\(String(round(Float(todaysWeather.windSpeed!)!))) MPH"
        tempLbl.text = "\(String(round(Float(todaysWeather.temp!)!))) °F"
    }

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let lat = locValue.latitude
        let lon = locValue.longitude
        let url = "\(BASE_URL)lat=\(lat)&lon=\(lon)&units=imperial\(APPID)"
        holder = url
    }
}

