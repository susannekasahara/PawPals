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
    
    // location
    
    private let base = "https://pawpals.herokuapp.com/"
    
    //login
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
            
            if let user = returnedInfo?["user"] as? [String:AnyObject] {
                
                if let key = user["access_token"] as? String {
                    
                    self.token = key
                    success(true)
                    print(self.token)
                }
                
            } else {
                
                success(false)
                
            }
            
        }
        
    }
    //register
    func registerWithUsername(email: String, andPassword password: String, streetaddress: String, city: String, state: String, zipcode: String, success: (Bool) -> ()) {
        
        var info = RequestInfo()
        
        info.endpoint = "signup"
        info.method = .POST
        info.parameters = [
    
            "email" : email,
            "password" : password,
                        
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo)
            
            
            if let user = returnedInfo?["user"] as? [String:AnyObject] {
                
                if let key = user["access_token"] as? String {
                    
                    self.token = key
                    success(true)
                    print(self.token)
                    
                    //request address
                    RailsRequest.session().addressWithUsername(streetaddress, city: city, state: state, zipcode: zipcode, success: { (success) -> () in
                        
                        // finished saving address
                        
                    })
                }
                
            } else {
                
                success(false)
                
            }
            
        }
        
    }
    //setup address
    func addressWithUsername(streetaddress: String, city: String, state: String, zipcode: String, success: (Bool) -> ()) {
        
        var info = RequestInfo()
        
        info.endpoint = "addresses"
        info.method = .POST
        info.parameters = [
            
            "street_address" : streetaddress,
            "city" : city,
            "state" : state,
            "zip" : zipcode,
            
            
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo)
            success(true)
            
        }
    }
    //SET UP PET Profile
    func profileWithUsername(petName: String, petAge: String, petBreed: String, petDescription: String, success: (Bool) -> ()) {
        
        var info = RequestInfo()
        
        info.endpoint = "pets"
        info.method = .POST
        info.parameters = [
            
            
            "name" : petName,
            "age" : petAge,
            "breed" : petBreed,
            "description": petDescription,
            
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo)
            
            
        }
        
    }
    
    //POST LOST PET @ NEW LOC
    

    //POST LOST PET CURRENT LOC
    
    
    //POST LOST PET HOME LOC
    
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