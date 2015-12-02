//
//  MyPetVC.swift
//  PawPals
//
//  Created by Susanne Burnham on 11/30/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

class MyPetVC: UIViewController {
    
    @IBOutlet weak var petnameField: UITextField!
    
    @IBOutlet weak var petageField: UITextField!
    
    
    @IBOutlet weak var petbreedField: UITextField!
    
    @IBOutlet weak var streetaddressField: UITextField!
    
    @IBOutlet weak var petdescriptField: UITextView!
    
    
    @IBOutlet weak var petpictureField: UIImageView!
    
    
    @IBAction func takephotoButton(sender: AnyObject) {
    }
    
    @IBAction func galleryphotoButton(sender: AnyObject) {
    }
    
    @IBAction func profilesubmitButton(sender: AnyObject) {
        
        guard let petName = petnameField.text, let petAge = petageField.text, let petBreed = petbreedField.text, let streetAddress = streetaddressField.text, let petDescription = petdescriptField.text else { return }
    
        
        
        RailsRequest.session().profileWithUsername(petName, petAge: petAge, petBreed: petBreed, streetAddress: streetAddress, petDescription:petDescription, success:  {
            didProfile in
            
            if didProfile {
                
                let loginstoryboard = UIStoryboard(name: "loginStoryboard", bundle: nil)
                
                let VC = loginstoryboard.instantiateViewControllerWithIdentifier("VC")
                
                self.presentViewController(VC, animated: true, completion: nil)
                
                
            } else {
                
                // throw an alert error that login failed
                
            }
            
        })
    }
    
    
    override func viewDidLoad() {
        
        print(RailsRequest.session().token)
        
    }
    
}



    
    

   