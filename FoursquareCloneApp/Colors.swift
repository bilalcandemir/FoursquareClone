//
//  Colors.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 20.01.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import Foundation
import UIKit
class Colors{
    static let tintColor = UIColor.white
    static let textColor = Colors.UIColorFromRGB(rgbValue: 0xFF3399)
    static let backgroundColor = Colors.UIColorFromRGB(rgbValue: 0xC0C0C0)
    static let actionSheetColor = UIColor.black
    
    
    static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
