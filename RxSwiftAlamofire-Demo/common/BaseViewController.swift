//
//  BaseViewController.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 02/06/17.
//
//

import UIKit
import SVProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
    }
    
    func showProgress() {
        SVProgressHUD.show()
    }
    
    func hideProgress() {
        SVProgressHUD.dismiss()
    }
    
    func showErrorMessage(message: String) {
        Util.showAlert(view: self, msg: message)
    }
    
}
