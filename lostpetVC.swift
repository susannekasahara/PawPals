//
//  lostpetVC.swift
//  PawPals
//
//  Created by Susanne Burnham on 12/4/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class lostpetVC: UIViewController, CLLocationManagerDelegate {
    
    var geocoder: CLGeocoder!
    
    let lManager = CLLocationManager()
    
    var lostCoordinate: CLLocationCoordinate2D?

    @IBAction func currentLocButton(sender: AnyObject) {

        lManager.delegate = self
        
        lManager.requestWhenInUseAuthorization()
        
        lManager.requestLocation()
        guard let loc = lManager.location else { return }
        
        RailsRequest.session().postLocation(loc.coordinate.latitude, longitude: loc.coordinate.longitude, present: true, success: { success in
            
            // did send location
            if success {
                print("success lost")
                
            } else {
                print("fail lost")
            }
          
        })

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if let location = locations.first {
            
            print(location)
            
            
            
        }
    }
    
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print(error)
    }
    
    @IBOutlet weak var homeLocButton: UIButton! 
    
    @IBAction func homeLocButton(sender: AnyObject) {
        
        RailsRequest.session().postLocation(RailsRequest.session().latitude, longitude: RailsRequest.session().longitude, success: { didLogin in
            
            // did send location
            
        })
        
        
        // get lat and long from railsrequest singleton
        
        
        //broadcast lost dog at home location

    }

    @IBOutlet weak var streetAddressLost: UITextField!
    
    @IBOutlet weak var cityLost: UITextField!
    
    @IBOutlet weak var stateLost: UITextField!
    
    @IBOutlet weak var zipLost: UITextField!
    
    
    @IBOutlet weak var lostLocButton: UIButton!
    
    @IBAction func lostLoc(sender: AnyObject) {
        
        
    
    
        NSLog("Lost Loc")
        
        self.geocoder = CLGeocoder()
        
        let address: String = "\(self.streetAddressLost.text!) \(self.cityLost.text!) \(self.stateLost.text!) \(self.zipLost.text!)"
        
        self.lostLocButton.enabled = false
        
        self.geocoder.geocodeAddressString(address) { (placemarks, error) -> Void in
            
            if placemarks!.count > 0 {
                var placemark: CLPlacemark = placemarks![0]
                var location: CLLocation = placemark.location!
                var coordinate: CLLocationCoordinate2D = location.coordinate
            }
        }
        self.lostLocButton.enabled = true
        
        
    }
}



    

        
    
    





    


