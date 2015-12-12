//
//  lostprofileVC.swift
//  PawPals
//
//  Created by Susanne Burnham on 12/5/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

class lostprofileVC: UIViewController {
    
    
    @IBAction func wheresMyPetButton(sender: AnyObject) {
        
        func myPetLoc(latitude: Double, longitude: Double,  success: (Bool) -> ()) {
            
            guard let myPetID = myPetID else { return success(false) }
            
            var info = RequestInfo()
            
            info.endpoint = "pet_checkins/" + petID
            info.method = .POST
            info.parameters = [
                
                "pet_id" : myPetID,
                "longitude" : "\(longitude)",
                "latitude" : "\(latitude)"
                
                
            ]
            
            requestWithInfo(info) { (returnedInfo) -> () in
                
                print(returnedInfo)
                success(true)
                
            }
            
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
