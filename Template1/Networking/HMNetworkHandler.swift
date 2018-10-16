//
//  HMNetworkHandler.swift
//
//  Created by Himal Madhushan.
//  Copyright © Himal Madhushan. All rights reserved.
//

import Foundation
import ObjectMapper

class HMNetworkHandler {
    
    typealias MainCompletionBlock = (_ success: Bool, _ result: Any?) -> Void
    
    /// Login user
    ///
    /// - Parameters:
    ///   - params: "email", "password"
    ///   - completion: Response completion block (success, response)
    static func login(params: [String:Any], completion:@escaping MainCompletionBlock) {
//        _ = HMNetworking.headers.add(other: HMHeaders.accept)
//        _ = HMNetworking.headers.add(other: HMHeaders.contentTypeJSON)
//        _ = HMNetworking.headers.add(other: HMHeaders.authorization)
        HMNetworking.request(.login, method: .post, parameters: params) { (success, response) in
            completion(success, response)
        }
    }
    
    /// Registering user
    ///
    /// - Parameters:
    ///   - params: Refer Register model
    ///   - completion: Response completion block (success, response)
    static func register(params: [String:Any], completion:@escaping MainCompletionBlock) {
        HMNetworking.request(.register, method: .post, parameters: params) { (success, response) in
            if let resp = response {
                completion(success, response)
            }
        }
    }
    
    static func getCategories(completion:@escaping MainCompletionBlock) {
        HMNetworking.request(.categories, method: .get, parameters: nil) { (succeess, response) in
//            if let categories = Mapper<Category>().mapArray(JSONObject: response) {
//                completion(succeess, categories)
//            }
        }
    }
    
    static func getProducts(completion:@escaping MainCompletionBlock) {
        HMNetworking.request(.products, method: .get, parameters: nil) { (succeess, response) in
//            if let categories = Mapper<Product>().mapArray(JSONObject: response) {
//                completion(succeess, categories)
//            }
        }
    }
    
    // MARK: - Token
//    static func refreshToken(completion:@escaping MainCompletionBlock) {
//        _ = HMNetworking.headers.add(other: HMHeaders.authorization)
//        HMNetworking.request(.refreshToken, method: .get, parameters: nil) { (success, response) in
//            completion(success, response)
//        }
//    }
}
