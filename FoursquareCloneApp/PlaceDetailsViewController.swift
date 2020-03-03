//
//  PlaceDetailsViewController.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 23.02.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import UIKit
import Parse
import NVActivityIndicatorView
class PlaceDetailsViewController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var placeCommentLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    var selectedPlaceId = ""
    var selectedPlaceLat = Double()
    var selectedPlaceLon = Double()
    var size = CGSize(width: 30.0, height: 30.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startAnimating(size, message: "Loading", messageFont: UIFont(name: "Font", size: 7.0), type: .lineScale, color: Colors.textColor, textColor: Colors.textColor, fadeInAnimation: nil)
        navigationController?.navigationBar.tintColor = Colors.textColor
        navBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(toShowPlaceArea))
        navBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "house"), style: .plain, target: self, action: #selector(backToHome))
        navBar.tintColor = Colors.textColor
        
        getData()
    }
}

extension PlaceDetailsViewController{
    func getData(){
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: selectedPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil{
                //alert
            }
            else{
                if objects != nil{
                    if objects!.count > 0{
                        let chosenPlaceObject = objects![0]
                        
                        if let placeName  = chosenPlaceObject.object(forKey: "name") as? String {
                            self.placeNameLabel.textColor = Colors.textColor
                            self.placeNameLabel.text = placeName
                            self.navBar.topItem?.title = placeName
                        }
                        if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                            self.placeTypeLabel.textColor = Colors.textColor
                            self.placeTypeLabel.text = placeType
                        }
                        if let placeComment = chosenPlaceObject.object(forKey: "comment") as? String {
                            self.placeCommentLabel.textColor = Colors.textColor
                            self.placeCommentLabel.text = placeComment
                        }
                        if let latitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                            if let doubleLatitude = Double(latitude){
                                self.selectedPlaceLat = doubleLatitude
                            }
                        }
                        if let longitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                            if let doubleLongitude = Double(longitude){
                                self.selectedPlaceLon = doubleLongitude
                            }
                        }
                        if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject{
                            imageData.getDataInBackground { (data, error) in
                                if error != nil && data == nil{
                                    
                                }
                                else{
                                    self.placeImage.image = UIImage(data: data!)
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    

    
    @objc func toShowPlaceArea(){
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    @objc func backToHome(){
        let nc = storyboard?.instantiateViewController(withIdentifier: "PlacesNC") as! UINavigationController
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true, completion: nil)
        
        
    }
}
