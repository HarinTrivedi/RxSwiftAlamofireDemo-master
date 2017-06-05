//
//  ForecastPresenterImpl.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 02/06/17.
//
//

import Foundation

// View
protocol ForecastView: BaseView {
    func showForecast(data: ForecastData)
}

// Presenter
protocol ForecastPresenter {
    func getForecast(id: String)
    func refreshTask()
}

// Presenter Implementation
class ForecastPresenterImpl: ForecastPresenter{

    let view:ForecastView
    let controller:ForecastController
    
    init(view:ForecastView) {
        self.view = view
        controller = ForecastControllerImpl()
    }
    
    
    /// Call refresh controller method
    func refreshTask() {
        controller.refresh()
    }
    
    
    /// Call get forecast controller method
    ///
    /// - Parameter id: id
    func getForecast(id: String) {
        if(Util.isInternetAvailable()){
                
            view.showProgress()
            controller.getForecast(id: id, onSuccess: { (data) in
                    self.view.hideProgress()
                    self.view.showForecast(data: data)
                }) {
                    self.view.hideProgress()
                    self.view.showErrorMessage(message: NSLocalizedString("str_something_went_wrong", comment: ""))
                }
            }else{
                view.showErrorMessage(message:  NSLocalizedString("str_no_internet", comment: ""))
            }
    }
    
}
