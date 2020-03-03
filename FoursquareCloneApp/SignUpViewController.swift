//
//  SignUpViewController.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 21.01.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import UIKit
import QuartzCore
import Parse
class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    var emptyAreas = [String]()
    var emptyAreasMessage = ""
    // MARK: SignUp Action
    @IBAction func signUp(_ sender: Any) {
        if (emailTextField.text == ""){
            addAlertMessages(message: "Please Add E-Mail Address")
        }
        if(passwordTextField.text == ""){
            addAlertMessages(message: "Please Enter Your Password")
        }
        if(usernameTextField.text == ""){
            addAlertMessages(message: "Please Enter Your Username")
        }
        if emptyAreas.count != 0{
            emptyAreas.forEach { (message) in
                self.emptyAreasMessage = message + " " + self.emptyAreasMessage
            }
            alert(message: self.emptyAreasMessage)
            emptyAreasMessage = ""
            emptyAreas.removeAll()
        }
        else{
            let user = PFUser()
            user.email = emailTextField.text!
            user.username = usernameTextField.text!
            user.password = passwordTextField.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil{
                    self.alert(message: "Sign Up Error")
                }
                else {
                    let nc = self.storyboard?.instantiateViewController(withIdentifier: "PlacesNC") as! UINavigationController
                    nc.modalPresentationStyle = .fullScreen
                    self.present(nc, animated: true, completion: nil)
                }
            }
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Design & ViewDidLoad
        usernameLabel.text = "Username"
        usernameLabel.textColor = Colors.textColor
        passwordLabel.text = "Password"
        passwordLabel.textColor = Colors.textColor
        emailLabel.text = "E-Mail"
        emailLabel.textColor = Colors.textColor
        
        usernameTextField.textColor = Colors.textColor
        usernameTextField.layer.cornerRadius = 4
        passwordTextField.textColor = Colors.textColor
        passwordTextField.layer.cornerRadius = 4
        emailTextField.textColor = Colors.textColor
        emailTextField.layer.cornerRadius = 4
        
        signUpButton.tintColor = UIColor.white
        signUpButton.backgroundColor = Colors.textColor
        signUpButton.layer.cornerRadius = 5
        
        signUpLabel.layer.cornerRadius =  5
        signUpLabel.layer.backgroundColor = Colors.textColor.cgColor
        signUpLabel.textColor = UIColor.white
        
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    

}
//MARK: Functions
extension SignUpViewController{
    @objc func alert(message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okey!", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func addAlertMessages(message:String){
        self.emptyAreas.append(message + "\n")
    }
    
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
}
