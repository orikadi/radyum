//
//  MapPageViewController.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapPageViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    
    let locationManager = CLLocationManager()
        let regionInMeters: Double = 10000
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //
           // mapView.delegate = self as! MKMapViewDelegate

            let pointAno = MKPointAnnotation()
            pointAno.title = "title"
            pointAno.subtitle = "sub"
            pointAno.coordinate = CLLocationCoordinate2D(latitude: 37.802654, longitude: -122.408827)
            mapView.addAnnotation(pointAno)
            //
            checkLocationServices()
        }
    
        
        func setupLocationManager() {
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        
        func centerViewOnUserLocation() {
            if let location = locationManager.location?.coordinate {
                let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                mapView.setRegion(region, animated: true)
            }
        }
        
        
        func checkLocationServices() {
            if CLLocationManager.locationServicesEnabled() {
                setupLocationManager()
                checkLocationAuthorization()
            } else {
                // Show alert letting the user know they have to turn this on.
            }
        }
        
        
        func checkLocationAuthorization() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
                centerViewOnUserLocation()
                locationManager.startUpdatingLocation()
                break
            case .denied:
                // Show alert instructing them how to turn on permissions
                let alert = UIAlertController(title: "WARNING", message: "permissioms", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                    //alert.dismiss(animated: true, completion: nil)
                }))
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                // Show an alert letting them know what's up
                let alert = UIAlertController(title: "WARNING", message: "restricted", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                    //alert.dismiss(animated: true, completion: nil)
                }))
                break
            case .authorizedAlways:
                break
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func getAnnotations(){
        //TODO: complete when DB is ready
    }
    
    @IBAction func toMap(segue:UIStoryboardSegue){}
}
//
extension MapPageViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotView == nil{
            annotView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        if(annotation is MKUserLocation){
            return nil
        }
        annotView?.rightCalloutAccessoryView = UIButton(type: .infoDark)
        annotView?.canShowCallout = true
        return annotView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if(control == view.rightCalloutAccessoryView){
            performSegue(withIdentifier: "a", sender: nil)
        }
    }
    
}
//

