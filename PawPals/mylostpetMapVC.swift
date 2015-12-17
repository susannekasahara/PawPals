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

class mylostpetMapVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mylostpetMap: MKMapView!
    
    var petID: Int = 0
    var latitude: Double = 0
    var longitude: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mylostpetMap.delegate = self
        
        
        RailsRequest.session().chipData { (petLocation) -> () in
            
            //use venue info to create annotation
            
            print("chip data finished")
            
            if let locationInfo = petLocation?["pet_check_ins"] as? [[String:AnyObject]] {
                
                print("has chip info")
                
                // create an annotation with the lat and lon returned
                
                if let last = locationInfo.last {
                    
                    print(locationInfo)
                    print(last)
                    
                    let lat = last["latitude"] as? Double ?? 0
                    let lng = last["longitude"] as? Double ?? 0
                    let coord = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coord
                    self.mylostpetMap.addAnnotation(annotation)

                    
                    
                    print("locationInfo \(locationInfo)")
                    
                }
                
            }
            
        }
        
        
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLoction: CLLocation = locations[0]
        let latitude = userLoction.coordinate.latitude
        let longitude = userLoction.coordinate.longitude
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.mylostpetMap.setRegion(region, animated: true)
        self.mylostpetMap.showsUserLocation = true
    }
}








   