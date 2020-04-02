//
//  SplashVC.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 16.03.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.present(vc, animated: true, completion: nil)
    }
}
