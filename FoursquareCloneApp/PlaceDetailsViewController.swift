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
    var selectedPlaceId = ""
    var placeName = ""
    var placeType = ""
    var selectedPlaceLat = Double()
    var selectedPlaceLon = Double()
    var size = CGSize(width: 30.0, height: 30.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startAnimating(size, message: "Loading", messageFont: UIFont(name: "Font", size: 7.0), type: .lineScale, color: Colors.textColor, textColor: Colors.textColor, fadeInAnimation: nil)
        
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(toShowPlaceArea))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "house.fill"), style: .plain, target: self, action: #selector(back))
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
                            self.title = placeName
                            self.placeName = placeName
                        }
                        if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                            self.placeTypeLabel.textColor = Colors.textColor
                            self.placeTypeLabel.text = placeType
                            self.placeType = placeType
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
                    self.stopAnimating()
                }
            }
        }
        
    }
    
    @objc func toShowPlaceArea(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "toMapVC") as! PlaceMapViewController
        vc.placeLatitude = self.selectedPlaceLat
        vc.placeLongitude = self.selectedPlaceLon
        vc.placeName = self.placeName
        vc.placeType = self.placeType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
}




