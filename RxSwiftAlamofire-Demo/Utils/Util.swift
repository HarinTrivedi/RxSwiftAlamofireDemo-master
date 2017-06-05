//
//  Util.swift
//  RxSwiftAlamofire-Demo
//
//  Created by Harry's Lab on 31/05/17.
//
//

import UIKit
import Foundation
import SystemConfiguration

class Util{
    
    
    /// Set gradient background to view
    ///
    /// - Parameter view: view
    static func createGradientLayer(view:UIView) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = view.bounds
        
        gradientLayer.colors = [UIColor(hexString: "#3F51B5FF")?.cgColor ?? UIColor.white.cgColor, UIColor.white.cgColor]//UIColor(hex: "#3F51B5")
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    /// Checks internet availability
    ///
    /// - Returns: true if available
    static func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    
    /// Show UiViewAlert
    ///
    /// - Parameters:
    ///   - view: view
    ///   - msg: message to show
    static func showAlert(view:UIViewController, msg:String) {
        
        let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // do nothing...
        }
        alertController.addAction(okAction)
        view.present(alertController, animated: true, completion: nil)
    
    }
    
    static func checkForSuccess(cod: Int) -> Bool{
        if(cod == 200){
            return true
        }
        return false
    }
}



// Extension for color to generate from hex code
extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
