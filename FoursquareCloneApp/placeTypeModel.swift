//
//  placeTypeModel.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 17.03.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import Foundation

class placeTypeModel {
    var id:Int
    var name:String
    var imagePath:String
    init(id:Int, name:String, image:String) {
        self.id = id
        self.name = name
        self.imagePath = image
    }
}
