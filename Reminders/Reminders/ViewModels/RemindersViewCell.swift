//
//  RemindersViewCell.swift
//  Reminders
//
//  Created by Mattia Cardone on 10/04/22.
//

import UIKit

class RemindersViewCell: UITableViewCell {

   
    @IBOutlet weak var TitleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
