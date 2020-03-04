//
//  ViewController.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 20.01.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import UIKit
import Parse
import NVActivityIndicatorView
class PlacesViewController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var tableView: UITableView!
    var placeName = [String]()
    var placeType = [String]()
    var placeId = [String]()
    var selectedPlaceId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = CGSize(width: 30.0, height: 30.0)
        self.startAnimating(size, message: "Loading", messageFont: UIFont(name: "Font", size: 7.0), type: .lineScale, color: Colors.textColor, textColor: Colors.textColor, fadeInAnimation: nil)
        
        self.title = "Places"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addPlace))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(userDetails))
        navigationController?.navigationBar.tintColor = Colors.textColor
        
        getPlaces()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "PlaceCell", bundle: nil), forCellReuseIdentifier: "PlaceCell")
        tableView.reloadData()
    }
    

}
//MARK:TableViewDelegation
extension PlacesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let placename = placeName[indexPath.row]
        let placetype = placeType[indexPath.row]
        let cell:PlaceCell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as! PlaceCell
        cell.placeNameConfigure(placeName: placename)
        cell.placeTypeConfigure(placeType: placetype)
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placeId[indexPath.row]
        let nc = storyboard!.instantiateViewController(withIdentifier: "PlaceDetailsNC") as! UINavigationController
        nc.modalPresentationStyle = .fullScreen
        let vc = nc.topViewController as! PlaceDetailsViewController
        vc.selectedPlaceId = placeId[indexPath.row]
        self.present(nc, animated: true, completion: nil)
    }
}
//MARK: Functions
extension PlacesViewController{
    @objc func addPlace(){
        performSegue(withIdentifier: "toAddPlace", sender: nil)
    }
    @objc func userDetails(){
        performSegue(withIdentifier: "toUserDetailsVC", sender: nil)
    }
    
    
    
    func getPlaces(){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { (objects, error) in
            if error != nil{
                print(error)
            }
            else{
                if objects != nil{
                    
                    
                    for object in objects!{
                        if let placeName = object.object(forKey: "name") as? String{
                            if let placeType = object.object(forKey: "type") as? String{
                                if let placeId = object.objectId{
                                    self.placeName.append(placeName)
                                    self.placeType.append(placeType)
                                    self.placeId.append(placeId)
                                }
                            }
                        }
                    }
                    self.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
}

