//
//  API.swift
//  NextLife
//
//  Created by Minh on 5/30/16.
//  Copyright © 2016 ZENTITY a.s. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias RequestCompletionBlock = (_ success: Bool, _ responseObject: JSON?) -> Void


public enum HTTPMethod : String {
    
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
    case NONE
}

class APIRequestOperation : Operation {

    private var Manager : Alamofire.SessionManager = {
        let serverTrustPolicies : [String : ServerTrustPolicy] = [
            "opendata.praha.eu": .disableEvaluation,
        ]
        
        let afManager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        return afManager
    }()
    
    
    let predefinedHeaders = [String:String]()
    
    let path : String
    var method : HTTPMethod = .GET
    var parameters : [String : AnyObject]?
    var headers : [String : String]?
    var request : DataRequest?
    var requestCompletionBlock: RequestCompletionBlock? = nil
    
    var _finished = false
    var _executing = false
    
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isExecuting: Bool {
        get { return _executing }
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override var isFinished: Bool {
        get { return _finished }
        set {
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    init(path : String,
         parameters : [String: AnyObject]? = nil,
         headers : [String : String]? = nil,
         method : HTTPMethod,
         requestCompletionBlock : RequestCompletionBlock?) {
        
        self.path = path
        self.requestCompletionBlock = requestCompletionBlock
        self.method = method
        
        self.parameters = parameters
        self.headers = headers
        
        super.init()
    }
    
    func addToAPIQueue() {
        MainAPIQueue.queue.addOperation(self)
    }
    
    func addToAPISerialQueue() {
        MainAPIQueue.serialQueue.addOperation(self)
    }
    
    override func cancel() {
        request?.cancel()
        super.cancel()
    }
    
    override func main() {
        if self.isCancelled { return }
    }
    
    override func start() {
        if (self.isCancelled) {
            isFinished = true
            return
        }
        
        isExecuting = true
        
        var allHeaders = predefinedHeaders
        if let headers = self.headers {
            for (key,value) in headers {
                allHeaders[key] = value
            }
        }

        switch method {
        case .GET:
            request = Manager.request(path, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: allHeaders)
            break
        case .POST:
            request = Manager.request(path, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: allHeaders)

            break
        case .PUT:
            request = Manager.request(path, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: allHeaders)
            break
        default:
            break
        }
        
        request?.validate()
        request?.responseData { [weak self] response in
            guard let `self` = self else {
                return
            }
            
            defer {
                self.isExecuting = false
                self.isFinished = true
            }
            
            _ = log.message("\(self.method) \n \(self.path) \n STATUS: \(response.response?.statusCode ?? 0) \n PARAMETERS: \(self.parameters)")
            
            if (response.result.isSuccess) {
                if let value = response.result.value, let json = try? JSON(data: value) {
                    if value.count >= 100000 {
                        _ = log.message("Response length: \(value.count) B\n")
                    } else {
                        _ = log.message("Response == \n\(json)")
                    }
                    
                    self.requestCompletionBlock?(true, json)
                }
                
            } else {
                if let error = response.result.error {
                    self.requestCompletionBlock?(false, nil)
                    // print error
                    if let data = response.data, let datastring = NSString(data:data, encoding:String.Encoding.utf8.rawValue) as? String {
                        _ = log.message("\(datastring)")
                    }
                    
                    _ = log.error("API error", error: error as NSError?)
                }
            }
        }
    }
}

public struct MainAPIQueue {
    
    static var queue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "apiQueue"
        queue.maxConcurrentOperationCount = 3
        return queue
    }()
    
    // We use this queue for API calls need to be serialized
    // i.e. when we do an optimistic UI update
    static var serialQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}
