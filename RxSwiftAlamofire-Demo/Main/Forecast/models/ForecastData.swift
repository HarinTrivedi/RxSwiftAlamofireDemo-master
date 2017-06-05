//
//  ForecastData.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 31/05/17.
//
//

import Foundation
import ObjectMapper

class ForecastData: Mappable {
    
    var cod: Int?
    var city: String?
    var list: [Forecast]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        cod    <- map["cod"]
        city   <- map["city"]
        list   <- map["list"]
    }
}
