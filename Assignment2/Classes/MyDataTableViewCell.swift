//
//  MyDataTableViewCell.swift
//  W10Database
//
//  Created by Xcode User on 2019-11-13.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

class MyDataTableViewCell: UITableViewCell {

    @IBOutlet var myLogo : UIImageView!
    @IBOutlet var myName : UILabel!
    @IBOutlet var myScore : UILabel!
    @IBOutlet var myTime : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
