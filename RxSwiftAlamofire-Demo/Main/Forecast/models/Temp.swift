//
//  Temp.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 31/05/17.
//
//

import Foundation
import ObjectMapper

class Temp: Mappable {
    
    var day: Double?
    var night: Double?
    var min: Double?
    var max: Double?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        day     <- map["day"]
        night   <- map["night"]
        min     <- map["min"]
        max     <- map["max"]
    }
}
