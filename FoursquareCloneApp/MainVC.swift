//
//  MainVC.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 16.03.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var placetype = [placeTypeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "PlaceTypeCell", bundle: nil), forCellWithReuseIdentifier: "PlaceTypeCell")
        collectionView.backgroundColor = .clear
        var item = placeTypeModel(id: 0, name: "Coffee", image: "coffee")
        placetype.append(item)
        item = placeTypeModel(id: 1, name: "Kebab", image: "kebab")
        placetype.append(item)
        item = placeTypeModel(id: 2, name: "Hookah", image: "hookah")
        placetype.append(item)
        item = placeTypeModel(id: 3, name: "Club", image: "drink")
        placetype.append(item)
    }
    
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placetype.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = placetype[indexPath.row]
        let cell:PlaceTypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceTypeCell", for: indexPath) as! PlaceTypeCell
        cell.configure(placeType: item, typeImage: UIImage(named: item.imagePath)!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(120)
        let height = CGFloat(120)

        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 4)
        layout.minimumInteritemSpacing = 04
        layout.minimumLineSpacing = 04
        layout.invalidateLayout()
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = placetype[indexPath.row]
        
        let nc = storyboard?.instantiateViewController(withIdentifier: "PlacesNC") as! UINavigationController
        nc.modalPresentationStyle = .fullScreen
        let vc = nc.topViewController as! PlacesViewController
        vc.selectedPlaceType = item.name
        print(item.name)
        self.present(nc, animated: true, completion: nil)
    }
}
