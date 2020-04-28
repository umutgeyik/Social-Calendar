//
//  ProfilePageViewController.swift
//  denemeCanim
//
//  Created by Umut Geyik on 19/03/2020.
//  Copyright © 2020 ProMac. All rights reserved.
//

import UIKit
import Firebase



class ProfilePageViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!{
    didSet{
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
    }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileMainView: UIView!
    @IBOutlet weak var followersBttn: UIButton!
    @IBOutlet weak var followingsBttn: UIButton!
    
    
    var followers = [String]()
    var followerCount = 0
    var followingCount = 0
    var followings = [String]()
    let db = Firestore.firestore()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

      userNameLabel.textColor = UIColor(red: 0.553, green: 0.573, blue: 0.651, alpha: 1)
      userNameLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
      // Line height: 25 pt
      userNameLabel.textAlignment = .center
      userNameLabel.text = "@batman"
        
        
        //UIImageView
        
        
        //DescriptionLabel
        
        descriptionLabel.textColor = UIColor(red: 0.553, green: 0.573, blue: 0.651, alpha: 1)
        descriptionLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "Selma"
        
        //LocationLabel
        
        locationLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        locationLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
        locationLabel.textAlignment = .center
        locationLabel.text = "Hunel"
        
        profileMainView.layer.shadowColor = UIColor.gray.cgColor
        profileMainView.layer.shadowOpacity = 1
        profileMainView.layer.shadowOffset = .zero
        profileMainView.layer.shadowRadius = 10
        
        profileMainView.layer.shadowPath = UIBezierPath(rect: profileMainView.bounds).cgPath
        profileMainView.layer.shouldRasterize = true
        profileMainView.layer.rasterizationScale = UIScreen.main.scale
        profileMainView.layer.cornerRadius = 20
        profileMainView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
        loadFollowers()
        
       
        
    }
    
    
    @IBAction func followClicked(_ sender: UIButton) {
        if sender.tag == 0 {
            
        }
        else if sender.tag == 1 {
            
        }
    }
    
    func loadFollowers(){
        
        let ref = Database.database().reference()
        ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
        let users = snapshot.value as! [String : NSDictionary]
        for(_,value) in users {
            if let uid = value["uid"] as? String {
                if uid == Auth.auth().currentUser?.uid {
                    if let followingUsers = value["following"] as? [String : String] {
                        for (_,user) in followingUsers {
                            self.followings.append(user)
                        }
                    }
                    
                    if let followers = value["followers"] as? [String : String] {
                        for (_,user) in followers {
                                self.followers.append(user)
                            self.followerCount += 1
                            print(followers)
                        }
                    }
                }
            }
        }
            self.loadProfiel()
        })
        ref.removeAllObservers()
        
        
    }
    
    func loadProfiel(){
        
        
        let uid = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dict = snapshot.value as? [String: Any] else {return}
            
            let user = User(uid: uid!, dictionar: dict)
            
            self.userNameLabel.text = user.username
            self.locationLabel.text = user.surname
            self.descriptionLabel.text = user.name
            self.followersBttn.setTitle("Followers: " + String(self.followers.count), for: .normal)
            self.followingsBttn.setTitle("Followings: " + String(self.followings.count), for: .normal)
            let url = URL(string: user.profile_picture )

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a
                if data == nil {
                    print("DATA NILL")
                }
                else{
                    DispatchQueue.main.async {
                        self.profileImageView.image = UIImage(data: data!)
                        
                    }
                }
                
            }
            
            
        }) { (err) in
            print(err)
        }
        
        
    }
   

}
