//
//  MapViewController.swift
//  PawPals
//
//  Created by Susanne Burnham on 12/2/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit

import MapKit

import CoreLocation


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var myMapView: MKMapView!
    
    let lManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMapView.delegate = self
        
        
        //need to ask for location
        lManager.requestWhenInUseAuthorization()
        
        //setting methods so lManager can call methods on location manager
        
        lManager.delegate = self
        
        myMapView.annotations
        
        //or
        
        //myMapView.showsUserLocation
        
        lManager.startUpdatingLocation()
        
        lManager.requestLocation()
        
        
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
    
//    func showDetail(button: UIButton) {
//        
//        if let viewController = storyboard?.instantiateViewControllerWithIdentifier("DetailVC") {
//            
//            viewController.view.backgroundColor = UIColor.lightGrayColor()
//            
//            navigationController?.pushViewController(viewController, animated: true)
//        }
//}


}



