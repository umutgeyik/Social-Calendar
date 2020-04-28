//
//  SignupPageViewController.swift
//  denemeCanim
//
//  Created by ProMac on 12.03.2020.
//  Copyright © 2020 ProMac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage


class SignupPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordAgainText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var emailAgainText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var surnameText: UITextField!
    @IBOutlet weak var buttonImageView: UIButton!
    
    let imagePicker = UIImagePickerController()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        buttonImageView.layer.cornerRadius = 0.5 * buttonImageView.bounds.size.width
        buttonImageView.clipsToBounds = true
        imagePicker.allowsEditing = true
        // Do any additional setup after loading the view.
    
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        
        let email = emailText.text!
        let reemail = emailAgainText.text!
        let password = passwordText.text!
        let repassword = passwordAgainText.text!
        let username = usernameText.text!
        let name = nameText.text
        let surname = surnameText.text
        
        if email != "" && reemail != "" && password != "" && repassword != "" && username != "" && name != "" && surname != "" {
            
            if email == reemail {
                
                if password == repassword{
            
                    Auth.auth().createUser(withEmail: email, password: password) { user, error in
                        if let e = error {
                            print(e.localizedDescription)
                        } else {
                            
                            self.uploadProfileImage(self.buttonImageView.image(for: .normal)!)
                           
                            
                            let mainController = self.storyboard?.instantiateViewController(withIdentifier: Constants.mainTabBar) as! MainTabController
                            mainController.modalPresentationStyle = .fullScreen
                            self.present(mainController, animated: true, completion: nil)
                        }
                    }
                    
                } else{
                    print("password eslesmiyor")
                }
            
            } else {
                print("email eslesmiyor")
            }
            
        } else {
            print("BOS BIRAKMA AQ")
        }
        
        
       
    }
    
    
    
    
    @IBAction func imagePickerClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func uploadProfileImage(_ image : UIImage) {
     
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference()
        let mountainsRef = storageRef.child("/users/pictures/\(imageName)")
        
        let data = image.pngData()
        
        let uploadTask = mountainsRef.putData(data!, metadata: nil) { (metadata,error) in
            guard let metadata = metadata else {
                return
            }
            
            let size = metadata.size
            mountainsRef.downloadURL {(url,error) in
                if let downloadURL = url {
                    self.saveProfile(url)
                } else {
                    return
                }
            }
    
        }
    }
    
        
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        buttonImageView.setImage(pickedImage, for: UIControl.State.normal)
        
        dismiss(animated: true, completion: nil)
    }
    
  
    func saveProfile(_ url: URL?){
        
        let myurl = url?.absoluteString
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/\(uid)")
        
        let userObject = [
            "username" : usernameText.text!,
            "name" : nameText.text!,
            "surname" : surnameText.text!,
            "profile_picture" : myurl!,
            "uid" : uid
        ] as [String: Any]
        
        databaseRef.setValue(userObject)
        
    }
 

}
