//
//  PlaceMapViewController.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 1.03.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import UIKit
import MapKit
class PlaceMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var mapView: MKMapView!
    
    
    var placeLatitude = Double()
    var placeLongitude = Double()
    var placeName = ""
    var placeType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(placeLongitude) ve \(placeLatitude)")
        navBar.tintColor = Colors.textColor
        let leftButton:UIBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backPlace))
        navBar.topItem?.leftBarButtonItem = leftButton
        getMapData()
    }
    
    func getMapData(){
        let location = CLLocationCoordinate2D(latitude: placeLatitude, longitude: placeLongitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
               
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = placeName
        annotation.subtitle = placeType
        mapView.addAnnotation(annotation)
    }
    
}


extension PlaceMapViewController{
    @objc func backPlace(){
        performSegue(withIdentifier: "toPlaceDetailsVC", sender: nil)
    }
    
}
