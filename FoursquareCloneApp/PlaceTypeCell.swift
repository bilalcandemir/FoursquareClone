//
//  PlaceTypeCell.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 17.03.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import UIKit

class PlaceTypeCell: UICollectionViewCell {
    @IBOutlet weak var labelPlaceType: UILabel!
    @IBOutlet weak var imageViewPlaceType: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure (placeType: placeTypeModel, typeImage: UIImage){
        labelPlaceType.text = placeType.name
        labelPlaceType.textColor = Colors.textColor
        imageViewPlaceType.image = typeImage
    }

}
