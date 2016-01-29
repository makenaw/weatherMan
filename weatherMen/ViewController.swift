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

    var dynamicEndPoint: String!
    
    var temp: String!
    var windSpeed: String!
    var desc: String!

    
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
        dynamicEndPoint = "\(BASE_URL)lat=\(lat)&lon=\(lon)\(APPID)"
        if dynamicEndPoint != nil {
            downloadWeather()
        }
    }
    
    
    func downloadWeather() {

        let url = NSURL(string: dynamicEndPoint)
        Alamofire.request(.GET, url!).responseJSON { response in
           let result = response.result
//            print(result.value.debugDescription)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] where weather.count > 0 {
                    if let weatherdesc = weather[0]["description"] {
                        self.desc = String(weatherdesc)
                        print(self.desc)
                    }
                    
                }
                if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                    if let speed = wind["speed"] {
                        self.windSpeed = String(speed)
                        print(self.windSpeed)
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let tmp = main["temp"] {
                        self.temp = String(tmp)
                        print(self.temp)
                    }
                }
            }
       
            }
    }
}

