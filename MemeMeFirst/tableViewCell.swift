//
//  tableViewControllerCell.swift
//  MemeMeFirst
//
//  Created by osmanjan omar on 12/15/16.
//  Copyright © 2016 osmanjan omar. All rights reserved.
//

import UIKit

class tableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewCellImage: UIImageView!
    @IBOutlet weak var topTextOnTableViewCell: UILabel!
    @IBOutlet weak var buttomTextOnTableViewCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
