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
    @IBOutlet weak var view: UIView!
    
    
    let placeModel = Models.sharedInstance
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        placeNameLabel.textColor = Colors.textColor
        placeTypeLabel.textColor = Colors.textColor
        accessoryView = .none
        selectionStyle = .none
        
    }
    func placeNameConfigure( placeName: String){
        placeNameLabel.text = "\(placeName.capitalizingFirstLetter())"
        print(placeName)
    }
    
    func placeTypeConfigure(placeType:String){
        placeTypeLabel.text = "\(placeType.capitalizingFirstLetter())"
    }
    
    func placeImageConfigure(placeImage:UIImage){ //
        self.placeImage.image = placeImage
    }
    
    func placeRateConfigure(_ placeRate:Int){
        view.loadRating(rate: placeRate)
    }
}

extension String{
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

extension UIView {
    func loadRating(rate:Int) {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        var x = 0
        for i in 1...5 {
            let imageView = UIImageView(frame: CGRect(x: x, y: 0, width: 12, height: 12))
            imageView.image = UIImage(named: (i <= rate) ? "iconStarLight" : "iconStarDark")
            imageView.contentMode = .center
            self.addSubview(imageView)
            x += 28
        }
    }
}
