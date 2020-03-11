//
//  SignInViewController.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 20.01.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import UIKit
import Parse
class SignInViewController: UIViewController {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBAction func signIn(_ sender: Any) {
        
        if (usernameTextField.text == "" && passwordTextField.text == ""){
            alert(message: "username/password empty.")
        }
        else{
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil{
                    self.alert(message: error?.localizedDescription ?? "Error")
                }
                else{
                    // MARK: Segue
                    let nc = self.storyboard!.instantiateViewController(withIdentifier: "PlacesNC") as! UINavigationController
                    nc.modalPresentationStyle = .fullScreen
                    self.present(nc, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Design
        usernameLabel.textColor = Colors.textColor
        passwordLabel.textColor = Colors.textColor
        usernameLabel.text = "Username"
        passwordLabel.text = "Password"
        usernameTextField.textColor = Colors.textColor
        passwordTextField.textColor = Colors.textColor
        usernameTextField.layer.cornerRadius = 4
        passwordTextField.layer.cornerRadius = 4
        signUpLabel.textColor = Colors.textColor
        signUpLabel.text = "You haven't Account:"
        signUpButton.tintColor = UIColor.gray
        signUpButton.layer.cornerRadius = 5
        signInButton.tintColor = UIColor.white
        signInButton.backgroundColor = Colors.textColor
        signInButton.layer.cornerRadius = 5
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tap)
    }
    

}

//MARK: Functions
extension SignInViewController{
    @objc func alert(message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okey!", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
}
