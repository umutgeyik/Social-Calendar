//
//  SearchCell.swift
//  denemeCanim
//
//  Created by Umut Geyik on 21/03/2020.
//  Copyright © 2020 ProMac. All rights reserved.
//

import UIKit

protocol SearchCellDelegate {
    func didFollowClicked(tag: Int)
}

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var bttn: UIButton!
    @IBOutlet weak var surnameText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!{
    didSet{
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
    }
    }
    
    var delegate: SearchCellDelegate?
    
    @IBAction func followClicked(_ sender: UIButton) {
        delegate?.didFollowClicked(tag: sender.tag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        nameText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        nameText.font = UIFont(name: "AvenirNext-Medium", size: 16)
        
        surnameText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        surnameText.font = UIFont(name: "AvenirNext-Medium", size: 16)
        
        usernameText.textColor = UIColor(red: 0.553, green: 0.573, blue: 0.651, alpha: 1)
        usernameText.font = UIFont(name: "AvenirNext-Bold", size: 18)
             
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
