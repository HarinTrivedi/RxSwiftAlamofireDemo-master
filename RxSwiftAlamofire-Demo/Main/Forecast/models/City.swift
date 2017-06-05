//
//  City.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 31/05/17.
//
//

import Foundation
import ObjectMapper

class City: Mappable {
    
    var geonameId: Int?
    var name: String?
    var country: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        geonameId   <- map["geoname_id"]
        name        <- map["name"]
        country     <- map["country"]
    }
}
