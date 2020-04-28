//
//  SearchPageTableViewController.swift
//  denemeCanim
//
//  Created by Umut Geyik on 21/03/2020.
//  Copyright © 2020 ProMac. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase


class SearchPageTableViewController: UITableViewController, UISearchResultsUpdating{
    
    
    
    @IBOutlet var myTable: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var usersArray = [NSDictionary?]()
    var filteredUsers = [NSDictionary?]()
    var followers = [NSDictionary?]()
    
    var databaseRef = Database.database().reference()
    var db = Firestore.firestore()
    
    var myUsers = [Users]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.register(UINib(nibName: Constants.searchCellName, bundle: nil), forCellReuseIdentifier: Constants.searchCellReusable)
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        

        databaseRef.child("users").queryOrdered(byChild: "name").observe(.childAdded
            , with: { (DataSnapshot) in
                
                self.usersArray.append(DataSnapshot.value as? NSDictionary)
                print(self.usersArray)
                
                self.myTable.insertRows(at: [IndexPath(row: self.usersArray.count-1, section: 0)], with: UITableView.RowAnimation.automatic)
                
                
        }) { (Error) in
            print(Error.localizedDescription)
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    /*
    func didFollowClicked(tag: Int) {
        
        print(tag)
        var user: NSDictionary?
        let currentUser = Auth.auth().currentUser?.uid
        if searchController.isActive && searchController.searchBar.text != ""{
            
            user = filteredUsers[tag]
            
        }
        else{
            user = self.usersArray[tag]
        }
        
        print(user)
        print(Auth.auth().currentUser?.uid)
        
        
        let uid = Auth.auth().currentUser?.uid
               let key = databaseRef.child("users").childByAutoId().key
               
               var isFollower = false
               databaseRef.child("users").child(uid!).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
                   if let following = snapshot.value as? [String: AnyObject] {
                       for (ke, value) in following {
                        if value as! String == user!["uid"] as! String{
                            isFollower = true
                            self.databaseRef.child("users").child(uid!).child("following/\(ke)").removeValue()
                            self.databaseRef.child("users").child((user!["uid"] as? String)!).child("followers/\(ke)").removeValue()
                            
                            
                        }
                       }
                   }
                   // Follow as user has no followers
                
                if !isFollower {
                    let following = ["following/\(key)" : user!["uid"] as! String]
                    let followers = ["followers/\(key)" : uid]
                    
                    self.databaseRef.child("users").child(uid!).updateChildValues(following)
                    self.databaseRef.child("users").child(user!["uid"] as! String).updateChildValues(followers)
                    
                }
               })
        
        databaseRef.removeAllObservers()
        myTable.reloadData()
        
        /*
        databaseRef.child("users").observe(.value) { (snapshot) in
            if (snapshot.exists()){
            let array:NSArray = snapshot.children.allObjects as NSArray
                
                for obj in array {
                    let snapshot:DataSnapshot = obj as! DataSnapshot
                    if let childSnapshot = snapshot.value as? [String : AnyObject]
                         {
                            if (childSnapshot["uid"] as! String == currentUser) {
                                
                            } else {
                                guard let uid = Auth.auth().currentUser?.uid else {return}
                                let databaseRef = Database.database().reference().child("users/\(uid)").child("followers")
                                
                                
                                self.db.collection("users/\(uid)/followers")
                                let userObject = [
                                    "uid" : user?["uid"]
                                ] as [String: Any]
                                
                                databaseRef.setValue(userObject)
                                
                            }
                    }
                }

            
            }
 
        }
        
        
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/\(uid)").child("followers")
        
        
        db.collection("users/\(uid)/followers").do
        let userObject = [
            "uid" : user?["uid"]
        ] as [String: Any]
        
        databaseRef.setValue(userObject)
 
         */
    }
    

   */
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if searchController.isActive && searchController.searchBar.text != ""{
            return filteredUsers.count
        }
        return self.usersArray.count
    }
    
   

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchCellReusable, for: indexPath) as! SearchCell

        // Configure the cell...
        let user: NSDictionary?
        let currentUser = Auth.auth().currentUser?.uid
        
        if searchController.isActive && searchController.searchBar.text != ""{
            print(indexPath.row)
            print(filteredUsers.count)
            user = filteredUsers[indexPath.row]
            print("Girdi")
        }
        else{
            user = self.usersArray[indexPath.row]
        }
        
        if currentUser  == user?["uid"] as? String {
            
            cell.usernameText.text = user?["username"] as? String
            cell.nameText.text = user?["name"] as? String
            cell.surnameText.text = user?["surname"] as? String
            let urlString = user?["profile_picture"] as! String
            
            let url = URL(string: urlString)
            
            

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.profileImageView.image = UIImage(data: data!)
                }
            }
            cell.isUserInteractionEnabled = false
           
            
        }
        else {
            cell.usernameText.text = user?["username"] as? String
            cell.nameText.text = user?["name"] as? String
            cell.surnameText.text = user?["surname"] as? String
            
            let urlString = user?["profile_picture"] as! String
           
            
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
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var user: NSDictionary?
        let currentUser = Auth.auth().currentUser?.uid
        if searchController.isActive && searchController.searchBar.text != ""{
            
            user = filteredUsers[indexPath.row]
            
        }
        else{
            user = self.usersArray[indexPath.row]
        }
        
        print(user)
        print(Auth.auth().currentUser?.uid)
        
        
        let uid = Auth.auth().currentUser?.uid
               let key = databaseRef.child("users").childByAutoId().key
               
               var isFollower = false
               databaseRef.child("users").child(uid!).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
                   if let following = snapshot.value as? [String: AnyObject] {
                       for (ke, value) in following {
                        if value as! String == user!["uid"] as! String{
                            isFollower = true
                            self.databaseRef.child("users").child(uid!).child("following/\(ke)").removeValue()
                            self.databaseRef.child("users").child((user!["uid"] as? String)!).child("followers/\(ke)").removeValue()
                            self.myTable.cellForRow(at: indexPath)?.accessoryType = .none
                            
                            
                        }
                       }
                   }
                   // Follow as user has no followers
                
                if !isFollower {
                    let following = ["following/\(key)" : user!["uid"] as! String]
                    let followers = ["followers/\(key)" : uid]
                    
                    self.databaseRef.child("users").child(uid!).updateChildValues(following)
                    self.databaseRef.child("users").child(user!["uid"] as! String).updateChildValues(followers)
                    
                    self.myTable.cellForRow(at: indexPath)?.accessoryType = .checkmark
                }
               })
        
        databaseRef.removeAllObservers()
        tableView.reloadData()
      
       
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContent(searchText: self.searchController.searchBar.text!)
        
    }
    func filterContent(searchText:String){
        self.filteredUsers = self.usersArray.filter { user in
            
            let username = user!["username"]    as? String
            
            return(username?.lowercased().contains(searchText.lowercased()))!
          
        }
        tableView.reloadData()
    }
    
    
    

}




