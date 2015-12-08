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
    
    let lManager = CLLocationManager()

    @IBAction func currentLocButton(sender: AnyObject) {

        lManager.delegate = self
        
        lManager.requestWhenInUseAuthorization()

        lManager.requestLocation()

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if let location = locations.first {
            
            print(location)
            
            RailsRequest.session().locationManager(location.coordinate.latitude, longitude: location.coordinate.longitude, success: { didLogin in
                
                // did send location
                
            })
            
        }
    }
    
    @IBAction func homeLocButton(sender: AnyObject) {
        
        // get lat and long from railsrequest singleton
        
        
        //broadcast lost dog at home location

    }

    @IBOutlet weak var streetAddressLost: UITextField!
    
    @IBOutlet weak var cityLost: UITextField!
    
    @IBOutlet weak var stateLost: UITextField!
    
    @IBOutlet weak var zipLost: UITextField!
    
    @IBAction func lostLocButton(sender: AnyObject) {
    
        // run clgeocoder
        
        
        
        
        
    }
    
        //broadcasr lost dog at new location
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

