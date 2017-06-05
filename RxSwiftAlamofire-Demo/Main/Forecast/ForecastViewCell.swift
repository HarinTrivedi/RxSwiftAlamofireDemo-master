//
//  ForecastViewCell.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 31/05/17.
//
//

import UIKit

class ForecastViewCell: UITableViewCell {

    @IBOutlet weak var tvCity: UITextView!
    @IBOutlet weak var tvCondition: UITextView!
    @IBOutlet weak var tvDesc: UITextView!
    @IBOutlet weak var tvMax: UITextView!
    @IBOutlet weak var tvMin: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
