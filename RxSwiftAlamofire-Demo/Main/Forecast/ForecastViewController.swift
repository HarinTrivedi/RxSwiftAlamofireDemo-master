//
//  ForecastViewController.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 31/05/17.
//
//

import UIKit

class ForecastViewController: BaseTableViewController, ForecastView{

    var id:Int?
    var forecastData:[Forecast]?
    var dayTimePeriodFormatter:DateFormatter?
    var presenter:ForecastPresenter?
    var pullToRefreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Util.createGradientLayer(view: self.tableView)
        

        dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter?.dateFormat = "dd MMM yyyy"
        presenter = ForecastPresenterImpl(view: self)
        
        initPullToRefreshControl()
        
        // get id from prev controller
        if let id = id {
            self.id = id
            presenter?.getForecast(id: String(describing: id))
        }
    }

    
    /// initialize pull to refresh control
    func initPullToRefreshControl(){
        pullToRefreshControl = UIRefreshControl()
        pullToRefreshControl?.attributedTitle = NSAttributedString(string: "Refreshing")
        pullToRefreshControl?.backgroundColor = UIColor.init(hexString:"#3F51B5FF")
        pullToRefreshControl?.tintColor = UIColor.white
        pullToRefreshControl?.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(pullToRefreshControl!)
    }
    
    func refresh(sender:AnyObject) {
        // Code to refresh table view
        presenter?.getForecast(id: String(describing: id))
    }
    
    override func hideProgress() {
        super.hideProgress()
        pullToRefreshControl?.endRefreshing()
    }

    
    /// Display forecast data in table view
    ///
    /// - Parameter data: forecast data
    func showForecast(data: ForecastData) {
        if(data.list != nil){
            forecastData = data.list
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.forecastData == nil{
            return 0
        }
        return self.forecastData!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "cell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ForecastViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        cell.backgroundColor = UIColor.clear
        
        // Fetches the appropriate meal for the data source layout.
        if let item = self.forecastData?[indexPath.row] as Forecast?{
        
            let date = NSDate(timeIntervalSince1970: Double.init(item.dt!))
            let dateString = dayTimePeriodFormatter?.string(from: date as Date)

            cell.tvCity.text = dateString
            if item.weather != nil, let w = item.weather?[0] as Weather?{
                cell.tvCondition.text = w.description!
            }
            cell.tvDesc.text = String(describing: item.humidity!)
            if let temp = item.temp as Temp?{
                cell.tvMin.text = "\(String(format: "%.1f", temp.min!)) °C"//\(NSLocalizedString("str_celsius", comment: "")
                cell.tvMax.text = "\(String(format: "%.1f", temp.max!)) °C"
            }
        }
        
        return cell
    }

}
