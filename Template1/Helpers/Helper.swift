//
//  Helper.swift
//
//  Created by Himal Madhushan.
//  Copyright © Himal Madhushan. All rights reserved.
//

import UIKit
import MediaPlayer
import CoreLocation

class Helper: NSObject {
    
    static let instance = Helper()
    
    // MARK: - Foundation
    static func deviceId() -> String {
        if (UserDefaults.standard.value(forKey: DefaultKey.deviceId) == nil) {
            let id = UIDevice.current.identifierForVendor?.uuidString
            UserDefaults.standard.set(id, forKey: DefaultKey.deviceId)
            return UserDefaults.standard.value(forKey: DefaultKey.deviceId) as! String
        } else {
            return UserDefaults.standard.value(forKey: DefaultKey.deviceId) as! String
        }
    }
    
    func setAuthToken(token: String) {
        UserDefaults.standard.set(token, forKey: DefaultKey.authorization)
        UserDefaults.standard.synchronize()
    }
    
    func authToken() -> String {
        return UserDefaults.standard.value(forKey: DefaultKey.authorization) as! String
    }
    
    // MARK: - UI
    static func rootViewController() -> UIViewController {
        return (UIApplication.shared.windows[0].rootViewController)!
    }
    
    static func showAlert(on:UIViewController?, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
        }))
        if on == nil {
            rootViewController().present(alert, animated: true, completion: nil)
        } else {
            on?.present(alert, animated: true, completion: nil)
        }
    }
    
}


