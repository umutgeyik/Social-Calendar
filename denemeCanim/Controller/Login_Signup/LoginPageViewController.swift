//
//  LoginPageViewController.swift
//  denemeCanim
//
//  Created by ProMac on 12.03.2020.
//  Copyright © 2020 ProMac. All rights reserved.
//

import UIKit
import Firebase

class LoginPageViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        if let email = emailText.text, let password = passwordText.text{
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error {
                    print(e)
                } else {
                    
                    let mainController = self?.storyboard?.instantiateViewController(withIdentifier: Constants.mainTabBar ) as! MainTabController
                    mainController.modalPresentationStyle = .fullScreen
                    self?.present(mainController, animated: true, completion: nil)
                    
                }
                
                   }
            
        }
       
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
