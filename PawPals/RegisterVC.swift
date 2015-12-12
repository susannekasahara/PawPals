//
//  RegisterVC.swift
//  PawPals
//
//  Created by Susanne Burnham on 11/29/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var emailRegField: UITextField!
    
    @IBOutlet weak var passwordRegField: UITextField!
    
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipcodeRegField: UITextField!
    
    @IBOutlet weak var streetaddressField: UITextField!
    
    @IBOutlet weak var cityField: UITextField!
    
    @IBAction func nextButton(sender: AnyObject) {
        
        
        
        guard let email = emailRegField.text,let password = passwordRegField.text, let zipcode = zipcodeRegField.text, let streetaddress = streetaddressField.text, let city = cityField.text, let state = stateField.text else { return }
        
        
        RailsRequest.session().registerWithUsername(email, andPassword: password, streetaddress: streetaddress, city: city, state: state, zipcode: zipcode, success:  {
            didRegister in
            
            if didRegister {
                
                
            } else {
                
                
            }
            
        })
        
    }
    
    
}


