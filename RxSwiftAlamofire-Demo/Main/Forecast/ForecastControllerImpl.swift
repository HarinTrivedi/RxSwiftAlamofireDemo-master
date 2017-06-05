//
//  ForecastControllerImpl.swift
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
protocol ForecastController {
    func getForecast(id:String, onSuccess: @escaping(_ data:ForecastData) -> Void, onError: @escaping() -> Void)
    func refresh()
}

// Controller Implementation
class ForecastControllerImpl: ForecastController {
   
    let sourceStringURL = "http://api.openweathermap.org/data/2.5/forecast/daily"
    
    var observable:Observable<(HTTPURLResponse, String)>?
    let disposeBag = DisposeBag()
    var successCallback:((ForecastData)->Void)?
    var errorCallback:(()->Void)?
    
    
    /// Call get forecast api
    ///
    /// - Parameters:
    ///   - id: id
    ///   - onSuccess: onSuccess callback
    ///   - onError: onError callback
    func getForecast(id: String, onSuccess: @escaping (ForecastData) -> Void, onError: @escaping () -> Void) {
        
        let params = ["appid":NSLocalizedString("api_key", comment: ""),"id":String(describing: id),"units":NSLocalizedString("val_unit", comment: "")]
        
        observable = RxAlamofire.requestString(.get, sourceStringURL, parameters: params).debug()
        
        successCallback = onSuccess
        errorCallback = onError
        subscribeObservable()
    }
 
    
    /// Refresh same observable
    func refresh() {
        if(observable != nil){
            subscribeObservable()
        }
    }
    
    
    /// Subscrive to call api
    func subscribeObservable(){
        observable?.subscribe(
            onNext: { (r, json) in
                
                if json as String? != nil {
                    let data:ForecastData = ForecastData(JSONString: json)!
                    if(Util.checkForSuccess(cod: data.cod!)){
                        self.successCallback!(data)
                    }else{
                        self.errorCallback!()
                    }
                    
                }else{
                    self.errorCallback!()
                }
                
        }, onError: { (error) in
            self.errorCallback!()
        })
            .addDisposableTo(disposeBag)

    }
}
