//
//  HMNetworking.swift
//
//  Created by Himal Madhushan.
//  Copyright © Himal Madhushan. All rights reserved.
//

import UIKit
import Alamofire

let baseURL = "http://hoom.app"

class HMNetworking: NSObject {
    
    static let instance = HMNetworking()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: baseURL)
    static var headers = [String: String]()
    private static var completionHandler: (Float)->Void = { arg in }
    typealias MainCompletionBlock = (_ success: Bool, _ result: Any?) -> Void
    typealias Headers = [String:String]
    
    
    /// Request that takes any parameter then encodes and sets to the HTTPBody.
    ///
    /// - Parameters:
    ///   - apiURL: APIURL.completedURL
    ///   - method: HTTPMethod
    ///   - parameters: Parameters
    ///   - headers: HMHeaders
    ///   - completion: Completion block for success or failure
    static func customRequest(_ apiURL: APIURL, method: HTTPMethod, parameters: Any?, headers:Headers = HMNetworking.headers, completion: @escaping MainCompletionBlock) {
        print("Calling URL: ", apiURL.completedURL)
        let loading = LoadingView(frame: CGRect.zero)
        do {
            var request = try URLRequest(url: apiURL.completedURL, method: method, headers: headers)
            if parameters != nil {
                request.httpBody = try! JSONSerialization.data(withJSONObject: parameters as Any) // JSONSerialization.data(withJSONObject: parameters)
            }
            
            Alamofire.request(request).responseData(completionHandler: { (responseData) in
                loading.hide()
                switch responseData.result {
                case .success(let json):
                    var jsonAny: Any?
                    do {
                        jsonAny = try JSONSerialization.jsonObject(with: json, options: JSONSerialization.ReadingOptions.allowFragments)
                    } catch _ {}
                    
                    if jsonAny is [String: Any] {
                        let resp = jsonAny as! [String: Any]
                        if resp.containsAndNotNil(key: "code") {
//                            var title = ""
                            var message = ""
//                            if resp.containsAndNotNil(key: "reason") {
//                                title = (resp["reason"] as? String)!
//                            }
                            if resp.containsAndNotNil(key: "errorMessage") {
                                message = (resp["errorMessage"] as? String)!
                            }
                            Helper.showAlert(on: nil, title: "", message: message)
                            completion(false, nil)
                            return
                        } else {
                            completion(true, jsonAny)
                            return
                        }
                    }
                    completion(true, json)
                case .failure(let error):
                    print(error)
                    completion(false, nil)
                }
            })
        } catch _ {
        }
    }
    
    
    /// Request that matches for all and encodes accoording to the method
    ///
    /// - Parameters:
    ///   - apiURL: APIURL.completedURL
    ///   - method: HTTPMethod
    ///   - parameters: Parameters
    ///   - headers: HMHeaders
    ///   - completion: Completion block for success or failure
    static func request(_ apiURL: APIURL, method: HTTPMethod, parameters: Parameters?, headers:Headers = HMNetworking.headers, completion: @escaping MainCompletionBlock) {
        let loading = LoadingView(frame: CGRect.zero)
        _ = self.headers.add(other: HMHeaders.accept)
        _ = self.headers.add(other: HMHeaders.contentTypeJSON)
        print("Calling URL: ", apiURL.completedURL)
        Alamofire.request(apiURL.completedURL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            loading.hide()
            switch response.result {
            case .success(let json):
                if json is [String: Any] {
                    let resp = json as! [String: Any]
                    if resp.containsAndNotNil(key: "code") {
//                        var title = ""
                        var message = ""
//                        if resp.containsAndNotNil(key: "reason") {
//                            title = (resp["reason"] as? String)!
//                        }
                        if resp.containsAndNotNil(key: "errorMessage") {
                            message = (resp["errorMessage"] as? String)!
                        }
                        Helper.showAlert(on: nil, title: "", message: message)
                        completion(false, nil)
                        return
                    } else {
                        completion(true, json)
                        return
                    }
                }
                completion(true, json)
            case .failure(let error):
                print(error)
                completion(false, nil)
            }
        }
    }
}


// MARK: - Reachability
extension HMNetworking {
    func setupReachability() {
        let manager = NetworkReachabilityManager()
        manager?.listener = { status in
            switch status {
            case .notReachable:
                Helper.showAlert(on: nil, title: AlertMessage.noInternet.title, message: AlertMessage.noInternet.message)

            default:
                break
            }
        }
        manager?.startListening()
        AppDelegate.instance.reachabilityManager = manager
    }
}


// MARK: - APIURL
protocol APIURLAccessor {
    var completedURL : String {get}
}

enum APIURL: APIURLAccessor {
    case login
    case register
    case categories
    case products
    
    var completedURL: String {
        switch self {
        case .login:
            return baseURL.appending("/auth/token")
            
        case .register:
            return baseURL.appending("/api/users")
            
        case .categories:
            return "http://192.168.1.4:3000/categories"
            
        case .products:
            return "http://192.168.1.4:3000/products"
        }
    }
}
