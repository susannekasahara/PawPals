//
//  mylostpetMapVC.swift
//  PawPals
//
//  Created by Susanne Burnham on 12/5/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

// to do: ADD MKANNOTATION to show pin

import UIKit
import MapKit
import CoreLocation

class mylostpetMapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mylostpetMap: MKMapView!
    
    
    var petID = Int()
    var latitude = Float()
    var longitude = Float()
    
    func getChipData(petID: Int, latitude: Float, longitude: Float) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RailsRequest.session().chipData(latitude, longitude: longitude, success:  {
            didLocate in
            
            if didLocate {
                
                let VC = self.storyboard?.instantiateViewControllerWithIdentifier("mymapVC") as? MapViewController
                
                self.navigationController?.pushViewController(VC!, animated: true)
                //
                
            } else {
                
                // throw an alert error that login failed
                
            }
            
            
        })
        
    }
    



}
   