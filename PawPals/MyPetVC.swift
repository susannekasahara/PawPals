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
    
    
    @IBOutlet weak var petdescriptField: UITextView!
    
    
    @IBOutlet weak var petpictureField: UIImageView!
    
    
    @IBAction func takephotoButton(sender: AnyObject) {
    }
    
    @IBAction func galleryphotoButton(sender: AnyObject) {
    }
    
    @IBAction func profilesubmitButton(sender: AnyObject) {
        
        guard let petName = petnameField.text, let petAge = petageField.text, let petBreed = petbreedField.text, let petDescription = petdescriptField.text else { return }
    
        
        
        RailsRequest.session().profileWithUsername(petName, petAge: petAge, petBreed: petBreed, petDescription: petDescription, success:  {
            didProfile in
            
            if didProfile {
                
                
            } else {
                
                
                
            }
            
        })
    }
    
    
    override func viewDidLoad() {
        
        print(RailsRequest.session().token)
        
    }
    
}



    
    

   