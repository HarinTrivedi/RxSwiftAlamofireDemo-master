//
//  WeatherControllerImpl.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 02/06/17.
//
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

// Controller
protocol WeatherController {
    func getWeather(city:String, onSuccess:@escaping (_ data:WeatherData) -> Void, onError:@escaping () -> Void)
}

// Controller Implementation
class WeatherControllerImpl:WeatherController{

    set api key in Localizable.strings
    
    let sourceStringURL = "http://api.openweathermap.org/data/2.5/weather"
    let disposeBag = DisposeBag()

    
    /// Call get weather api
    ///
    /// - Parameters:
    ///   - city: name
    ///   - onSuccess: onSuccess callback
    ///   - onError: onError callback
    func getWeather(city: String, onSuccess: @escaping (WeatherData) -> Void, onError: @escaping () -> Void) {
        
        let params = ["appid":NSLocalizedString("api_key", comment: ""),"q":city,"units":NSLocalizedString("val_unit", comment: "")]
        
        RxAlamofire.requestString(.get, sourceStringURL, parameters: params)
            .debug()
            .subscribe(
                onNext: { (r, json) in
                    
                    if json as String? != nil {
                        let data:WeatherData = WeatherData(JSONString: json)!
                        if(Util.checkForSuccess(cod: data.cod!)){
                            onSuccess(data)
                        }else{
                            onError()
                        }
                    }else{
                        onError()
                    }
            }, onError: { (error) in
                onError()
            })
            .addDisposableTo(disposeBag)

    }
    
}
