//
//  Weather.swift
//  weatherMen
//
//  Created by makena  on 1/30/16.
//  Copyright © 2016 makena . All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    
    init() {
        
    }
    
    var desc = "empty string"
    var temp = "empty string"
    var windSpeed = "empty string"
    var dynamicEndPoint = "empty string" {
        didSet {
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
                    }
                    
                }
                if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                    if let speed = wind["speed"] {
                        self.windSpeed = String(speed)
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let tmp = main["temp"] {
                        self.temp = String(tmp)
                    }
                }
            }
            
        }
    }
}