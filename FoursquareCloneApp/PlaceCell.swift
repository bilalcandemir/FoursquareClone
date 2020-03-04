//
//  PlaceCell.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 22.01.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    
    let placeModel = Models.sharedInstance
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        placeNameLabel.textColor = Colors.textColor
        placeTypeLabel.textColor = Colors.textColor
        
    }
    func placeNameConfigure( placeName: String){
        placeNameLabel.text = "Place Name: \(placeName.uppercased())"
    }
    
    func placeTypeConfigure(placeType:String){
        placeTypeLabel.text = "Place Type: \(placeType.uppercased())"
    }
    
    func placeImageConfigure(placeImage:UIImage){ //
        self.placeImage.image = placeImage
    }
}
