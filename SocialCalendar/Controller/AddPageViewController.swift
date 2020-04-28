//
//  AddPageViewController.swift
//  denemeCanim
//
//  Created by Umut Geyik on 20/03/2020.
//  Copyright © 2020 ProMac. All rights reserved.
//

import UIKit
import Firebase

class AddPageViewController: UIViewController, UITextViewDelegate, UIApplicationDelegate {

    @IBOutlet weak var evenTitleLabel: UITextField!
    @IBOutlet weak var allDayLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startsDateTextField: UITextField!
    @IBOutlet weak var endsDateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var allDayField: UISwitch!
    @IBOutlet weak var toShowLabel: UILabel!
    @IBOutlet weak var justMeLabel: UILabel!
    @IBOutlet weak var followingsLabel: UILabel!
    @IBOutlet weak var everyoneLabel: UILabel!
    @IBOutlet weak var justmeBttn: UIButton!
    @IBOutlet weak var followingsBttn: UIButton!
    @IBOutlet weak var everyoneBttn: UIButton!
    
    
    let datePicker = UIDatePicker()
    let datePicker2 = UIDatePicker()
    let formatter = DateFormatter()
    
    var toShowNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        evenTitleLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        evenTitleLabel.font = UIFont(name: "AvenirNext-Medium", size: 24)
        
        allDayLabel.textColor = UIColor(red: 0.553, green: 0.571, blue: 0.651, alpha: 1)
        allDayLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        
        startDateLabel.textColor = UIColor(red: 0.553, green: 0.571, blue: 0.651, alpha: 1)
        startDateLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        
        endDateLabel.textColor = UIColor(red: 0.553, green: 0.571, blue: 0.651, alpha: 1)
        endDateLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        
        justMeLabel.textColor = UIColor(red: 0.553, green: 0.571, blue: 0.651, alpha: 1)
        justMeLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        
        followingsLabel.textColor = UIColor(red: 0.553, green: 0.571, blue: 0.651, alpha: 1)
        followingsLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        
        everyoneLabel.textColor = UIColor(red: 0.553, green: 0.571, blue: 0.651, alpha: 1)
        everyoneLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        
        toShowLabel.textColor = UIColor(red: 0.553, green: 0.571, blue: 0.651, alpha: 1)
        toShowLabel.font = UIFont(name: "AvenirNext-Bold", size: 20)
        
        descriptionTextField.text = "Write Description Here..."
        descriptionTextField.textColor = UIColor.lightGray
        descriptionTextField.returnKeyType = .done
        descriptionTextField.delegate = self
        
        justmeBttn.isSelected = true
       
        
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        datePicker.datePickerMode = .dateAndTime
        datePicker2.datePickerMode = .dateAndTime
        
        locationTextField.textAlignment = .center
        
        createDatePicker()
        

    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write Description Here..."{
            textView.text = ""
            textView.textColor = UIColor.black
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = "Write Description Here..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func swifthSender(_ sender: UISwitch) {
        
        if(sender.isOn == true){
            datePicker.datePickerMode = .date
            datePicker2.datePickerMode = .date
            
            formatter.dateStyle = .short
            formatter.timeStyle = .none
        }
        else{
            datePicker.datePickerMode = .dateAndTime
            datePicker2.datePickerMode = .dateAndTime
            
            formatter.dateStyle = .short
            formatter.timeStyle = .short
        }
    }
    func createDatePicker(){
        
        startsDateTextField.textAlignment = .center
        endsDateTextField.textAlignment = .center
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        startsDateTextField.inputAccessoryView = toolbar
        endsDateTextField.inputAccessoryView = toolbar
        startsDateTextField.inputView = datePicker
        endsDateTextField.inputView = datePicker2
    }
    
    @objc func donePressed(){
        startsDateTextField.text = formatter.string(from: datePicker.date)
        endsDateTextField.text = formatter.string(from: datePicker2.date)
        self.view.endEditing(true)
    }
    
    
   
    @IBAction func radioClicked(_ sender: UIButton) {
        if sender.tag == 0 {
            justmeBttn.isSelected = true
            followingsBttn.isSelected = false
            everyoneBttn.isSelected = false
            toShowNum = 0
        }
        else if sender.tag == 1 {
            justmeBttn.isSelected = false
            followingsBttn.isSelected = true
            everyoneBttn.isSelected = false
            toShowNum = 1
        }
        else if sender.tag == 2 {
            justmeBttn.isSelected = false
            followingsBttn.isSelected = false
            everyoneBttn.isSelected = true
            toShowNum = 2
        }
    }
    
    @IBAction func addEventClicked(_ sender: UIButton) {
        
        if startsDateTextField.text == "" || endsDateTextField.text == ""{
            if startsDateTextField.text == ""{
                startsDateTextField.backgroundColor = UIColor(red: 0.533, green: 0, blue: 0, alpha: 0.48)
            }
            if endsDateTextField.text == ""{
                endsDateTextField.backgroundColor = UIColor(red: 0.533, green: 0, blue: 0, alpha: 0.48)
            }
            if evenTitleLabel.text == ""{
                evenTitleLabel.backgroundColor = UIColor(red: 0.533, green: 0, blue: 0, alpha: 0.48)
            }
        } else {
            let uid = Auth.auth().currentUser?.uid
            let ref = Database.database().reference()
            
            let key = ref.child("posts").childByAutoId().key
            let feed = ["uid" : uid,
                        "eventTitle": evenTitleLabel.text!,
                        "allDay" : allDayField.isOn,
                        "startDate" : startsDateTextField.text,
                        "endDate" : endsDateTextField.text,
                        "location" : locationTextField.text,
                        "description" : descriptionTextField.text,
                        "toShow" : toShowNum,
                        "postID" : key] as [String : Any]
            let postFeed = ["\(key)" : feed]
            ref.child("posts").updateChildValues(postFeed)
            
          
            self.dismiss(animated: true, completion: finito)

        }
        
    }
    
    func finito(){
        DispatchQueue.main.async {
            let mainController = self.storyboard?.instantiateViewController(withIdentifier: Constants.mainTabBar ) as! MainTabController
            mainController.modalPresentationStyle = .fullScreen
            self.getTopMost()?.present(mainController, animated: true, completion: nil)
            
        }
    }
    
    func getTopMost() -> UIViewController? {
        var topMostView = UIApplication.shared.keyWindow?.rootViewController
        
        while let presentedViewController = topMostView?.presentedViewController {
            topMostView = presentedViewController
        }
        return topMostView
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
