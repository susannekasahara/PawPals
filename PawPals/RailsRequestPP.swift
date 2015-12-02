//
//  RailsRequestPP.swift
//  PawPals
//
//  Created by Susanne Burnham on 11/29/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

let _rr = RailsRequest()

let _d = NSUserDefaults.standardUserDefaults()

class RailsRequest: NSObject {
    
    var email: String?
    
    class func session() -> RailsRequest { return _rr }
    
    var token: String? {
        
        get { return _d.objectForKey("token") as? String }
        set { _d.setObject(newValue, forKey: "token") }
        
        
    }
    
    private let base = "https://pawpals.herokuapp.com/"
    
    
    func loginWithUsername(email: String, andPassword password: String, success: (Bool) -> ()) {
        
        var info = RequestInfo()
        self.email = email
        
        info.endpoint = "login"
        info.method = .POST
        info.parameters = [
            
            "email" : email,
            "password" : password
            
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo)
            
            
            
        }
        
    }
    
    func registerWithUsername(email: String, andPassword password: String, zipcode: String, success: (Bool) -> ()) {
        
        var info = RequestInfo()
        
        info.endpoint = "signup"
        info.method = .POST
        info.parameters = [
    
//            "zipcode" : zipcode,
            "email" : email,
            "password" : password,
                        
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo)
            
            
            if let email = returnedInfo?["email"] as? [String:AnyObject] {
                
                if let key = email["Access_Token"] as? String {
                    
                    self.token = key
                    success(true)
                    print(self.token)
                }
                
            } else {
                
                success(false)
                
            }
            
        }
        
    }
    
    func profileWithUsername(petName: String, petAge: String, petBreed: String, streetAddress: String, petDescription: String, success: (Bool) -> ()) {
        
        var info = RequestInfo()
        
        info.endpoint = "pets"
        info.method = .POST
        info.parameters = [
            
            //            "zipcode" : zipcode,
            "name" : petName,
            "age" : petAge,
            "breed" : petBreed,
            "streetaddress" : streetAddress,
            "description": petDescription,
            
            
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo)
            
            
            if let petName = returnedInfo?["email"] as? [String:AnyObject] {
                
                if let key = petName["Access_Token"] as? String {
                    
                    self.token = key
                    success(true)
                    print(self.token)
                }
                
            } else {
                
                success(false)
                
            }
            
        }
        
    }

    
    func requestWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
        
        var fullURLString = base + info.endpoint
        
        for (i,(k,v)) in info.query.enumerate() {
            
            if i == 0 { fullURLString += "?" } else { fullURLString += "&" }
            
            fullURLString += "\(k)=\(v)"
            
            print(fullURLString)
            
        }
        
        guard let url = NSURL(string: fullURLString) else { return } // add run completion with fail
        
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = info.method.rawValue
        
        //add token if we have one
        
        if let token = token {
            
            // can add token when they give it to you
            request.setValue(token, forHTTPHeaderField: "Access-Token")
            
            
        }
        if info.parameters.count > 0 {
            
            if let requestData = try? NSJSONSerialization.dataWithJSONObject(info.parameters, options: .PrettyPrinted) {
                
                if let jsonString = NSString(data: requestData, encoding: NSUTF8StringEncoding) {
                    
                    request.setValue("\(jsonString.length)", forHTTPHeaderField: "Content-Length")
                    
                    let postData = jsonString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                    
                    request.HTTPBody = postData
                    
                }
                
            }
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // creates a task from request - based on network connectivity
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                
                
                
                // work with data returned
                
                if let data = data {
                    
                    // have data
                    
                    if let returnedInfo = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) {
                        
                        completion(returnedInfo: returnedInfo)
                        
                    }
                    
                } else {
                    
                    // no data: check for error and return alert from
                }
            }
            task.resume()
            
        }
        
    }
}


struct RequestInfo {
    
    enum MethodType: String {
        
        case POST, GET, DELETE
    }
    
    var endpoint: String!
    var method: MethodType = .GET
    var parameters: [String:AnyObject] = [:]
    var query: [String:AnyObject] = [:]
    
}