    //
//  WeatherPresenterImpl.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 02/06/17.
//
//

import Foundation

// View
protocol WeatherView: BaseView {
    func showWeather(data: WeatherData)
}

// Presenter
protocol WeatherPresenter {
    func validate(city: String?) -> Bool
    func getWeatherInfo(city: String)
}

// Presenter Implementation
class WeatherPresenterImpl: WeatherPresenter{

    let view:WeatherView
    let controller:WeatherController
    
    init(view:WeatherView) {
        self.view = view
        controller = WeatherControllerImpl()
    }
    
    
    /// Call get weather from controller
    ///
    /// - Parameter city: name
    func getWeatherInfo(city: String) {
        
        if(validate(city: city))
        {
            if(Util.isInternetAvailable()){
                
                view.showProgress()
                controller.getWeather(city: city, onSuccess: { (data) in
                    self.view.hideProgress()
                    self.view.showWeather(data: data)
                }) {
                    self.view.hideProgress()
                    self.view.showErrorMessage(message: NSLocalizedString("str_something_went_wrong", comment: ""))
                }
            }else{
                view.showErrorMessage(message: NSLocalizedString("str_no_internet", comment: ""))
            }
        }
    }

    
    /// Validate input
    ///
    /// - Parameter city: name
    /// - Returns: false if empty
    func validate(city: String?) -> Bool {
        if(city != nil && !(city?.isEmpty)!){
            return true
        }
        return false
    }

    
}
