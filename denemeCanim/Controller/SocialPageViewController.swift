//
//  SocialPageViewController.swift
//  denemeCanim
//
//  Created by ProMac on 12.03.2020.
//  Copyright © 2020 ProMac. All rights reserved.
//

import UIKit
import Firebase

class SocialPageViewController: UITableViewController {

    @IBOutlet var myTableView: UITableView!
    
    
    
    let events: [Social] = [
        Social(sender: "Ece Ayitos", eventName: "POPOMU YE", eventDate: "01.01.2031", profileImage:UIImage(named: "berkeleyCafe") ),
        Social(sender: "Umut Popos", eventName: "SEVISELIM", eventDate: "Her gun", profileImage: UIImage(named: "coffeeShop"))
    ]
    
    var posts = [Event]()
    var following = [String]()
    var followingBack = [String]()
    var totalUsers = [Users]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        
        navigationItem.hidesBackButton = true
        
        myTableView.register(UINib(nibName: Constants.cellName, bundle: nil), forCellReuseIdentifier: Constants.cellReusable)

        fetchPosts()
        userFinder()
        // Do any additional setup after loading the view.
    }
    
    func fetchPosts(){
        let ref = Database.database().reference()
        ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
            let users = snapshot.value as! [String : NSDictionary]
            for(_,value) in users {
                if let uid = value["uid"] as? String {
                    if uid == Auth.auth().currentUser?.uid {
                        if let followingUsers = value["following"] as? [String : String] {
                            for (_,user) in followingUsers {
                                self.following.append(user)
                            }
                        }
                        
                        if let followers = value["followers"] as? [String : String] {
                            for (_,user) in followers {
                                if self.following.contains(user) {
                                    self.followingBack.append(user)
                                }
                            }
                        }
                        self.following.append(Auth.auth().currentUser!.uid)
                        self.followingBack.append(Auth.auth().currentUser!.uid)
                        
                        ref.child("posts").queryOrderedByKey().observeSingleEvent(of: .value, with: {(snap) in
                            let postsSnap = snap.value as! [String : NSDictionary]
                            for(_,post) in postsSnap {
                                if let uid = post["uid"] as? String {
                                    for each in self.following {
                                        if each == uid {
                                            let myPost = Event()
                                            if uid == Auth.auth().currentUser?.uid && post["toShow"] as? Int == 0 {
                                                if let allDay = post["allDay"] as? Bool, let description = post["description"] as? String, let endDate = post["endDate"] as? String, let eventTitle = post["eventTitle"] as? String, let location = post["location"] as? String, let startDate = post["startDate"] as? String, let postID = post["postID"] as? String, let toShow = post["toShow"] as? Int, let uid = post["uid"] as? String {
                                                    
                                                    myPost.allDay = allDay
                                                    myPost.descriptionEvent = description
                                                    myPost.endDate = endDate
                                                    myPost.eventTitle = eventTitle
                                                    myPost.location = location
                                                    myPost.startDate = startDate
                                                    myPost.postID = postID
                                                    myPost.toShow = toShow
                                                    myPost.uid = uid
                                                    
                                                    self.posts.append(myPost)
                                                    
                                                }
                                            }
                                            if post["toShow"] as? Int == 1 && self.followingBack.contains(each){
                                                if let allDay = post["allDay"] as? Bool, let description = post["description"] as? String, let endDate = post["endDate"] as? String, let eventTitle = post["eventTitle"] as? String, let location = post["location"] as? String, let startDate = post["startDate"] as? String, let postID = post["postID"] as? String, let toShow = post["toShow"] as? Int, let uid = post["uid"] as? String {
                                                                                                   
                                                    myPost.allDay = allDay
                                                    myPost.descriptionEvent = description
                                                    myPost.endDate = endDate
                                                    myPost.eventTitle = eventTitle
                                                    myPost.location = location
                                                    myPost.startDate = startDate
                                                    myPost.postID = postID
                                                    myPost.toShow = toShow
                                                    myPost.uid = uid
                                                    
                                                    self.posts.append(myPost)
                                                    
                                                   
                                               }
                                                
                                            }
                                            if post["toShow"] as? Int == 2 {
                                                if let allDay = post["allDay"] as? Bool, let description = post["description"] as? String, let endDate = post["endDate"] as? String, let eventTitle = post["eventTitle"] as? String, let location = post["location"] as? String, let startDate = post["startDate"] as? String, let postID = post["postID"] as? String, let toShow = post["toShow"] as? Int, let uid = post["uid"] as? String {
                                                                                                   
                                                    myPost.allDay = allDay
                                                    myPost.descriptionEvent = description
                                                    myPost.endDate = endDate
                                                    myPost.eventTitle = eventTitle
                                                    myPost.location = location
                                                    myPost.startDate = startDate
                                                    myPost.postID = postID
                                                    myPost.toShow = toShow
                                                    myPost.uid = uid
                                                    
                                                   self.posts.append(myPost)
                                               }
                                            }
                                        }
                                    }
                                    
                                    self.myTableView.reloadData()
                                }
                            }
                        })
                        
                    }
                }
            }
        })
        ref.removeAllObservers()
    }
    
    func userFinder(){
        
        let ref = Database.database().reference()
        ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with:  {snap in
            let myUsers = snap.value as! [String : NSDictionary]
            for(_,value) in myUsers {
                
                    
                    let saUser = Users()
                    
                    if let name = value["name"] as? String , let surname = value["surname"] as? String, let profile_image = value["profile_picture"] as? String, let uid = value["uid"] as? String {
                        saUser.name = name
                        saUser.surname = surname
                        saUser.profile_image = profile_image
                        saUser.uid = uid
                        
                        self.totalUsers.append(saUser)
                    
                }
            }
        })
        ref.removeAllObservers()
        
    }
    
    func userReturner(uid: String) -> Users {
        return totalUsers.filter({ $0.uid == uid}).first!
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: Constants.cellReusable, for: indexPath) as! SocialCell
        
        if posts.isEmpty == false {
            
            let myUser = userReturner(uid: self.posts[indexPath.row].uid)
            
            cell.eventDateLabel.text = self.posts[indexPath.row].startDate
            cell.eventNameLabel.text = self.posts[indexPath.row].eventTitle
            cell.profileNameLabel.text = myUser.name + " " + myUser.surname
            let urlString = myUser.profile_image!
            let url = URL(string: urlString)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.profileImageView.image = UIImage(data: data!)
                }
            }
        }
        return cell
    }

}


