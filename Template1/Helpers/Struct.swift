//
//  Struct.swift
//
//  Created by Himal Madhushan.
//  Copyright © Himal Madhushan. All rights reserved.
//

import Foundation
import UIKit

var authToken: String {
    get {
        return Helper.instance.authToken()
    }
}

struct APIKEY {
    static let firebase = ""
    static let googleService = ""
}

struct DefaultKey {
    static let session = "session"
    static let username = "username"
    static let deviceId = "deviceId"
    static let userLogged = "userLogged"
    static let authorization = "authorization"
    static let pushToken = "pushToken"
}

struct NotificationIdentifier {
    static let keyboardWillShow = Notification.Name("KeyboardWillShow")
}

struct Constant {
    static let emailSubject = "<#Email Subject#>"
    
    struct WebSite {
        static let common = "<#example_url#>"
    }
}

struct AppColor {
    static let blue = #colorLiteral(red: 0, green: 0.6549019608, blue: 1, alpha: 1)
    static let red = #colorLiteral(red: 0.9960784314, green: 0.1568627451, blue: 0.3176470588, alpha: 1)
    static let yellow = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
    static let green = #colorLiteral(red: 0.1960784314, green: 0.7960784314, blue: 0.462745098, alpha: 1)
}

struct HMHeaders {
    static let contentTypeJSON: [String: String] = ["Content-Type":"application/json"]
    static let contentTypeXForm: [String: String] = ["Content-Type":"application/x-www-form-urlencoded"]
    static let accept: [String: String] = ["Accept":"application/json"]
    static var authorization: [String: String] {
        get {
            return ["Authorization": "Bearer \(authToken)"]
        }
    }
}

struct AlertMessage {
    typealias AlertTuple = (title: String, message: String)
    static let noInternet: AlertTuple = ("No Internet","App requires a working internet connection, which you don't have at the moment")
    static let noSharableImage: AlertTuple = ("Sorry!","Unable to share at this time")
}
