//
//  SocialCell.swift
//  denemeCanim
//
//  Created by Umut Geyik on 19/03/2020.
//  Copyright © 2020 ProMac. All rights reserved.
//

import UIKit



class SocialCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
            profileImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        profileNameLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        profileNameLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        
        eventNameLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        eventNameLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
        
        eventDateLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)

        eventDateLabel.font = UIFont(name: "AvenirNext-Italic", size: 14)
        
        postDateLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)

        postDateLabel.font = UIFont(name: "AvenirNext-Italic", size: 12)
        
        
        
    }
    
    
    @IBAction func addClicked(_ sender: UIButton) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
