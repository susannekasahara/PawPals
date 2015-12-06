//
//  LoginVC.swift
//  PawPals
//
//  Created by Susanne Burnham on 11/29/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailLoginField: UITextField!
    
    @IBOutlet weak var passwordLoginField: UITextField!
    
    @IBAction func loginButton(sender: AnyObject) {
        
        guard let email = emailLoginField.text, let password = passwordLoginField.text else { return }
        
        
        RailsRequest.session().loginWithUsername(email, andPassword: password, success: { didLogin in
            
            if didLogin {
                
//                let loginstoryboard = UIStoryboard(name: "login", bundle: nil)
//                
//                let VC = loginstoryboard.instantiateViewControllerWithIdentifier("VC")
//                
//                self.presentViewController(VC, animated: true, completion: nil)
                
                
            } else {
                
                // throw an alert error that login failed
                
            }
        })
    }
    
}