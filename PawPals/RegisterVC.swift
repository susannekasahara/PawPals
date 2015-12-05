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
    
    
    
    guard let email = emailRegField.text where !email.isEmpty else { return }
    guard let password = passwordRegField.text where !password.isEmpty else { return }
    guard let zipcode = zipcodeRegField.text where !zipcode.isEmpty else { return }
    guard let streetaddress = streetaddressField.text where !streetaddress.isEmpty else { return }
    guard let city = cityField.text where !city.isEmpty else { return }
    guard let state = stateField.text where !state.isEmpty else { return }
        
    
        RailsRequest.session().registerWithUsername(email, andPassword: password, streetaddress: streetaddress, city: city, state: state, zipcode: zipcode, success:  {
            didRegister in
            
            if didRegister {
    
   // let loginstoryboard = UIStoryboard(name: "login", bundle: nil)
    
   // let VC = loginstoryboard.instantiateViewControllerWithIdentifier("VC")
    
    //self.presentViewController(VC, animated: true, completion: nil)
    
    
   } else {
    
    // throw an alert error that login failed
    
}

})
}


}


