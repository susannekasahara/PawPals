//
//  lostpetVC.swift
//  PawPals
//
//  Created by Susanne Burnham on 12/4/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

import CoreLocation

class lostpetVC: UIViewController, CLLocationManagerDelegate {
    
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    @IBAction func currentLocButton(sender: AnyObject)
        
        
    {
        
        // get lat and long from CLLocationManager using requestLocation
        
        guard let latitude = self.latitude else { return }
        guard let longitude = self.longitude else { return }
        
        //broadcast lost dog location on currentLocation
        
    }
    
    @IBAction func homeLocButton(sender: AnyObject) {
        
        // get lat and long from railsrequest singleton
        
        guard let latitude = self.latitude else { return }
        guard let longitude = self.longitude else { return }
        
        //broadcast lost dog at home location

    }

    @IBOutlet weak var streetAddressLost: UITextField!
    
    @IBOutlet weak var cityLost: UITextField!
    
    @IBOutlet weak var stateLost: UITextField!
    
    @IBOutlet weak var zipLost: UITextField!
    
    @IBAction func lostLocButton(sender: AnyObject) {
    
        // run clgeocoder
        
        guard let latitude = self.latitude else { return }
        guard let longitude = self.longitude else { return }
        
        
        
    }
    
        //broadcasr lost dog at new location
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        guard let currentLocation = locationManager.location else { return }
        
        let latitude = Double(currentLocation.coordinate.latitude)
        let longitude = Double(currentLocation.coordinate.longitude)
        
        self.latitude = latitude
        self.longitude = longitude
        
        print("latitude \(latitude)")
        print("longitude \(longitude)")
        
        
        //New Location
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    }

