//
//  Forecast.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 31/05/17.
//
//

import Foundation
import ObjectMapper

class Forecast: Mappable {
    
    var dt: Int?
    var temp: Temp?
    var pressure: String?
    var humidity: Int?
    var weather: [Weather]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        dt          <- map["dt"]
        temp        <- map["temp"]
        pressure    <- map["pressure"]
        humidity    <- map["humidity"]
        weather     <- map["weather"]
        
    }
}
