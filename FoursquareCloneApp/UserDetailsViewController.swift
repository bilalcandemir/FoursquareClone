//
//  UserDetailsViewController.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 2.02.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import UIKit
import Parse
class UserDetailsViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBAction func logOut(_ sender: Any) {
        PFUser.logOut()
        let vc = self.storyboard!.instantiateViewController(identifier: "SignInViewController") as! SignInViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "User Details"
        
        let user = PFUser.current()
        usernameLabel.text = user?.username
        emailLabel.text = user?.email
        usernameLabel.textColor = Colors.textColor
        emailLabel.textColor = Colors.textColor
        
        logOutButton.layer.cornerRadius = 5
        logOutButton.layer.backgroundColor = Colors.textColor.cgColor
        logOutButton.tintColor = UIColor.white
        
        
    }

}
