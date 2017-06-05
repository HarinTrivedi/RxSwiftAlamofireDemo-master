//
//  WeatherData.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 31/05/17.
//
//

import Foundation
import ObjectMapper

class WeatherData: Mappable {
    
    var cod: Int?
    var id: Int?
    var name: String?
    var main: Main?
    var weather: [Weather]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        cod         <- map["cod"]
        id          <- map["id"]
        name        <- map["name"]
        main        <- map["main"]
        weather     <- map["weather"]
    }
}
