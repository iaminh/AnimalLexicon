//
//  APICommunicator.swift
//  NextLife
//
//  Created by Minh on 5/30/16.
//  Copyright © 2016 ZENTITY a.s. All rights reserved.
//

import Foundation

public class API {
    
    static let communicator : API = {
        return API()
    }()
}

extension API {
    func getContinentRelations(completion: @escaping RequestCompletionBlock) -> APIRequestOperation {
        let path = APIKeys.BaseAddress
        let params : [String: AnyObject] = [
            "resource_id" : "6316e78d-d8d2-404a-8741-91cc1395c6fd" as AnyObject,
            "limit" : 300 as AnyObject
        ]
        
        return APIRequestOperation(path: path,
                                   parameters: params,
                                   method: .GET,
                                   requestCompletionBlock: completion)
    }
    
    func getFoodRelations(completion: @escaping RequestCompletionBlock) -> APIRequestOperation {
        let path = APIKeys.BaseAddress
        let params : [String: AnyObject] = [
            "resource_id" : "e3cd5857-d62e-44f0-8414-17721808c62e" as AnyObject,
            "limit" : 300 as AnyObject
        ]
        
        return APIRequestOperation(path: path,
                                   parameters: params,
                                   method: .GET,
                                   requestCompletionBlock: completion)
    }
    
    func getAllAnimalsRequest(limit: Int? = nil, completion: @escaping RequestCompletionBlock) -> APIRequestOperation {
        let path = APIKeys.BaseAddress
        let params : [String: AnyObject] = [
            "resource_id" : "4fc2aaff-3e7b-4d24-94d7-713a1f45074c" as AnyObject,
            "limit" : 300 as AnyObject
        ]
        
        return APIRequestOperation(path: path,
                                   parameters: params,
                                   method: .GET,
                                   requestCompletionBlock: completion)
    }
    
    
    func getAllAnimalClassRequest(completion: @escaping RequestCompletionBlock) -> APIRequestOperation {
        let path = APIKeys.BaseAddress
        let params : [String: AnyObject] = [
            "resource_id" : "90e66377-9d31-4852-8cfb-1981319ccb20" as AnyObject,
        ]
        
        return APIRequestOperation(path: path,
                                   parameters: params,
                                   method: .GET,
                                   requestCompletionBlock: completion)
    }

}
