//
//  MapViewController.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 21.02.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import UIKit
import MapKit
import Parse
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "Select Location"
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "house"), style: .plain, target: self, action: #selector(backToHome))
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.north.fill"), style: .plain, target: self, action: #selector(save))
        
        navigationController?.navigationBar.tintColor = Colors.textColor
        
        map.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        tap.minimumPressDuration = 2
        map.addGestureRecognizer(tap)
    }
    
    
    

   

}

extension MapViewController{
    @objc func save(){
        let placeModel = Models.sharedInstance
        
        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placeType
        object["comment"] = placeModel.placeComment
        object["latitude"] = placeModel.placeLatitude
        object["longitude"] = placeModel.placeLongitude
        let imageName = UUID()
        
        
        if let imageData = placeModel.placePhoto.jpegData(compressionQuality: 0.5){
            object["image"] = PFFileObject(name: "\(imageName).jpg", data: imageData)
        }
        
        object.saveInBackground { (success, error) in
            if error != nil{
                
            }
            if success{
                let nc = self.storyboard?.instantiateViewController(withIdentifier: "PlacesNC") as! UINavigationController
                nc.modalPresentationStyle = .fullScreen
                self.present(nc, animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    @objc func backToHome(){
        let nc = storyboard?.instantiateViewController(withIdentifier: "PlacesNC") as! UINavigationController
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true, completion: nil)
    }
    
    
    @objc func chooseLocation(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizer.State.began{
            let touches = gestureRecognizer.location(in: self.map)
            let coordinates = self.map.convert(touches, toCoordinateFrom: self.map)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            
            annotation.title = Models.sharedInstance.placeName
            annotation.subtitle = Models.sharedInstance.placeType
            
            self.map.addAnnotation(annotation)
            
            Models.sharedInstance.placeLatitude = String(coordinates.latitude)
            Models.sharedInstance.placeLongitude = String(coordinates.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
    }
    
}
