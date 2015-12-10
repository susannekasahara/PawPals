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
                

                let VC = self.storyboard?.instantiateViewControllerWithIdentifier("mapVC") as? MapViewController
                
                self.navigationController?.pushViewController(VC!, animated: true)
//
                
            } else {
                
                // throw an alert error that login failed
                
            }
        })
    }
    
}