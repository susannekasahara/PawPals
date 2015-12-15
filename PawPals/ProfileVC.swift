//
//  ProfileVC.swift
//  PawPals
//
//  Created by Susanne Burnham on 11/29/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    var petInfo: [String:AnyObject]!

    
    @IBOutlet weak var petpicImage: UIImageView!

    @IBOutlet weak var petnameLabel: UILabel!
    
    
    @IBOutlet weak var petageLabel: UILabel!
    
    @IBOutlet weak var petbreedLabel: UILabel!
    
    @IBOutlet weak var petcityLabel: UILabel!
    
    @IBOutlet weak var petstateLabel: UILabel!
    
    @IBOutlet weak var petdescriptionText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if let petname = pet["name"] as? String {
        
       // petnameLabel.text = petname
            
        }

        // Do any additional setup after loading the view.
    }

 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



