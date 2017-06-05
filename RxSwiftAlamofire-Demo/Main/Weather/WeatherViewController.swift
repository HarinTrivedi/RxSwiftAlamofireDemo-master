//
//  WeatherViewController.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 30/05/17.
//
//

import UIKit

class WeatherViewController: BaseViewController, UITextFieldDelegate, WeatherView {

    @IBOutlet weak var edtCity: UITextField!
    
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var tvCity: UITextView!
    @IBOutlet weak var tvCondition: UITextView!
    @IBOutlet weak var tvTemp: UITextView!
    
    var id:Int = 0
    var presenter:WeatherPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        Util.createGradientLayer(view: self.view)
        
        edtCity.delegate = self
        weatherView.isHidden = true
        
        presenter = WeatherPresenterImpl(view: self)
        
    }
    

    
    /// Display weather data
    ///
    /// - Parameter data: weather object with temperature, condition
    func showWeather(data: WeatherData) {
        print("name : \(String(describing: data.name!))")
        
        self.weatherView.isHidden = false
        self.tvCity.text = data.name!
        
        if let main = data.main{
            print("temp : \(String(describing: main.temp!))")
            self.tvTemp.text = "\(String(format: "%.1f", data.main!.temp!)) °C"
        }
        
        if (data.weather?.count)! > 0 {
            if let data = data.weather?[0] {
                print("temp : \(String(describing: data.main!))")
                self.tvCondition.text = String(describing: data.main!)
            }
        }
        
        self.id = data.id!
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    @IBAction func getWeatherTapped(_ sender: UIButton) {
        edtCity.resignFirstResponder()
        
        let name:String = edtCity.text!
        presenter?.getWeatherInfo(city: name)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(id != 0){
            super.prepare(for: segue, sender: sender)
        
            switch(segue.identifier ?? "") {
                case "info":
                    guard let forecastViewController = segue.destination as? ForecastViewController else {
                        fatalError("Unexpected destination: \(segue.destination)")
                    }
                    forecastViewController.id = id
            
            default:
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            }
        }
    }
    
}


