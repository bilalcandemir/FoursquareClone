//
//  Models.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 20.01.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import Foundation
import UIKit
class Models{
    
    static let sharedInstance = Models()
    
    var placeName = ""
    var placeType = ""
    var placeComment = ""
    var placePhoto = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    var rate:Int?
    private init(){}
    
}

