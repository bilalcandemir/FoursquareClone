//
//  AddPlaceViewController.swift
//  FoursquareCloneApp
//
//  Created by Bilal Candemir on 27.01.2020.
//  Copyright © 2020 Bilal Candemir. All rights reserved.
//

import UIKit
import Parse
class AddPlaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var alertMessage = ""
    var alertCounter = 0
    var placeList = [Models]() //
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var addPictureLabel: UILabel!
    @IBOutlet weak var placeNameTf: UITextField!
    @IBOutlet weak var placeTypeTF: UITextField!
    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var NextButton: UIButton!
    @IBAction func next(_ sender: Any) {
        if placeNameTf.text == ""{
            addMessage(message: "-Write Place Name \n")
            alertCounter = alertCounter + 1
        }
        if placeTypeTF.text == ""{
            addMessage(message: "-Write Place Type")
            alertCounter = alertCounter + 1
        }
        if alertCounter != 0{
            alert()
            alertCounter = 0
            alertMessage = ""
        }
        else{
            if let choosenImage = selectImage.image{
                let placeModel = Models.sharedInstance
                placeModel.placeName = placeNameTf.text!
                placeModel.placeType = placeTypeTF.text!
                placeModel.placeComment = commentTF.text!
                placeModel.placePhoto = choosenImage
                
                let nc = storyboard?.instantiateViewController(withIdentifier: "MapNC") as! UINavigationController
                nc.modalPresentationStyle = .fullScreen
                self.present(nc, animated: true, completion: nil)
            }
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Add Place"
        self.navigationItem.title = "Add Place"
        
        selectImage.isUserInteractionEnabled = true
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        selectImage.addGestureRecognizer(imageTap)
       
        placeNameLabel.textColor = Colors.textColor
        placeNameLabel.text = "Place Name :"
        
        placeTypeLabel.textColor = Colors.textColor
        placeTypeLabel.text = "Place Type :"
        
        commentLabel.textColor = Colors.textColor
        commentLabel.text = "Add Comment :"
        
        addPictureLabel.text = "Tap And Choose Image"
        addPictureLabel.textColor = Colors.textColor
        
        placeNameTf.textColor = Colors.textColor
        placeTypeTF.textColor = Colors.textColor
        commentTF.textColor = Colors.textColor
        
        NextButton.tintColor = UIColor.white
        NextButton.backgroundColor = Colors.textColor
        NextButton.layer.cornerRadius = 5
        
        
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tap)
    }
    


}

extension AddPlaceViewController{
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
    
    func alert(){
        let alert = UIAlertController(title: "Uups", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okey!", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func addMessage(message:String){
        self.alertMessage = alertMessage + message
    }
    
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
