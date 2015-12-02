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
    
    @IBOutlet weak var zipcodeRegField: UITextField!
    
    @IBAction func nextButton(sender: AnyObject) {
    
    
    
    guard let email = emailRegField.text where !email.isEmpty else { return }
    guard let password = passwordRegField.text where !password.isEmpty else { return }
    guard let zipcode = zipcodeRegField.text where !zipcode.isEmpty else { return }
    
        RailsRequest.session().registerWithUsername(email, andPassword: password, zipcode: zipcode, success:  {
            didRegister in
            
            if didRegister {
    
    let loginstoryboard = UIStoryboard(name: "loginStoryboard", bundle: nil)
    
    let VC = loginstoryboard.instantiateViewControllerWithIdentifier("VC")
    
    self.presentViewController(VC, animated: true, completion: nil)
    
    
   } else {
    
    // throw an alert error that login failed
    
}

})
}


}


