//
//  Weather.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 31/05/17.
//
//

import Foundation
import ObjectMapper

class Weather: Mappable {
    var id: Int?
    var main: String?
    var description: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id             <- map["id"]
        main           <- map["main"]
        description    <- map["description"]
        
    }
}
