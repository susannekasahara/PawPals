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
    
    let lpManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mylostpetMap.delegate = self
        
        lpManager.requestAlwaysAuthorization()
        lpManager.delegate = self
        
        mylostpetMap.showsUserLocation = false
        
        
        lpManager.startUpdatingLocation()
        
        lpManager.requestLocation()
        
    }
    
    
    
    
    
        func getChipData(petID: Int, latitude: Float, longitude: Float) {
            

        
        RailsRequest.session().chipData(latitude, longitude: longitude, success:  {
            didLocate in
            
            if didLocate {
                
                let VC = self.storyboard?.instantiateViewControllerWithIdentifier("mymapVC") as? MapViewController
                
                self.navigationController?.pushViewController(VC!, animated: true)
               
                
            } else {
                
            
                
            }
            
            
        })
        
    }
    
    
    

        
        func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            guard let location = locations.first else { return }
            
            print(location.coordinate.latitude, location.coordinate.longitude)
            
            // request lost pets around location
            
        }
        
        func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
            
            print(error)
        }
        
        func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
            
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            
            //annotationView.pinColor = .Purple
            annotationView.pinTintColor = UIColor(red:1, green:0.38, blue:0.33, alpha:1)
            
            annotationView.canShowCallout = true
            
            let button = UIButton(type: .DetailDisclosure)
            
            button.addTarget(self, action: "showDetail:", forControlEvents: .TouchUpInside)
            
            annotationView.rightCalloutAccessoryView = button
            
            return annotationView
            
        }
        
    
    }

    
    
    
    




   