//
//  Main.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 31/05/17.
//
//

import Foundation
import ObjectMapper

class Main: Mappable {
    var temp: Double?
    var min: Double?
    var max: Double?
    var pressure: Int?
    var humidity: Int?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        temp        <- map["temp"]
        pressure    <- map["pressure"]
        humidity    <- map["humidity"]
        min         <- map["temp_min"]
        max         <- map["temp_max"]
    }
}
