//
//  BaseView.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 02/06/17.
//
//

import Foundation

protocol BaseView: class {
    func showProgress()
    func hideProgress()
    func showErrorMessage(message: String)
}
