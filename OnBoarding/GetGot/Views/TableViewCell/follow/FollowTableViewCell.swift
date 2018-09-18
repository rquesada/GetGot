//
//  FollowTableViewCell.swift
//  GetGot
//
//  Created by Roy Quesada on 9/17/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit
import SDWebImage

class FollowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    var userID:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
